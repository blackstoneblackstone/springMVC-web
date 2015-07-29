package cn.com.gcks.repository;

import cn.com.gcks.utils.SensitivewordFilter;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Random;

/**
 * 消息信息
 * Created by lihb on 15/6/26.
 */

@Service
@Getter
@Setter
@Slf4j
public class MsgRepository {

    @Autowired
    private RedisTemplate redisTemplate;
    @Autowired
    private SensitivewordFilter sensitivewordFilter;

    public List<String> getMsgList(String listName, long everyKeepNum, long everyGetNum) {
//        if (isfirst == 1) {
//            //第一次调用接口时，清空所有数据
//            redisTemplate.opsForList().trim(listName, 99999999, -1);
//            return null;
//        }
        long size = redisTemplate.opsForList().size(listName);
        if (size > everyKeepNum) {//只有当实际数据大于要保留数据时才要裁剪
            redisTemplate.opsForList().trim(listName, size - everyKeepNum, -1);
        }
        //log.info("目前redis中"+ listName+ "集合数量是：" + size);
        //取出指定数量的数据
        List<String> list = redisTemplate.opsForList().range(listName, 0, everyGetNum - 1);
        for(int i=0;i<list.size();i++){
            JSONObject hs=new JSONObject(list.get(i));
            if(sensitivewordFilter.CheckSensitiveWord(hs.getString("content"),0,1)!=0){
                list.remove(i);
            }
        }
        //删除已取出的数据：队尾插入队头插入
        redisTemplate.opsForList().trim(listName, everyGetNum, -1);
        return list;
    }

    //得到100个用户
    public List<String> getUserList(String listName) {
        Long total=redisTemplate.opsForList().size(listName);
        Random random = new Random();
        int s;
        if(total!=1L){
            s = random.nextInt(total.intValue()-100) % (total.intValue()-100 + 1);
        }else{
            s=1;
        }
        List<String> result = redisTemplate.opsForList().range(listName, s, s+100);
        return result;
    }

    public String getPrizeUser(String listName) {
        Long total = redisTemplate.opsForList().size(listName);
        if(total==0L){
            return null;
        }
        Random random = new Random();
        int s;
        if(total!=1L){
            s = random.nextInt(total.intValue()) % (total.intValue() + 1);
        }else{
            s=1;
        }
        String user = String.valueOf(redisTemplate.opsForList().index(listName, s-1));
        redisTemplate.opsForList().remove(listName, 0, user);
        return user;
    }

    public Long getUserCount(String listName) {
        Long total = redisTemplate.opsForList().size(listName);

        return total;
    }

    public String getUserName(String key) {
        JSONObject users = new JSONObject(read(key));
        return users.getString("nickname");
    }

    public String read(String keys) {
        final byte[] key = redisTemplate.getKeySerializer().serialize(keys);

        return (String) redisTemplate.execute(new RedisCallback() {
            public String doInRedis(RedisConnection redisConnection) throws DataAccessException {
                byte[] val = redisConnection.get(key);
                if (val == null) {
                    return null;
                }
                return (String) redisTemplate.getValueSerializer().deserialize(val);
            }
        });
    }

    public void delete(String keys) {
        final byte[] key = redisTemplate.getKeySerializer().serialize(keys);
        redisTemplate.execute(new RedisCallback() {
            public String doInRedis(RedisConnection redisConnection) throws DataAccessException {
                redisConnection.del(key);
                return null;
            }
        });
    }

    public void userAddList(String tablename, String value) {
        redisTemplate.opsForList().rightPush(tablename, value);
    }

    public List<String> getAllUsers(String listName) {
        List<String> result = redisTemplate.opsForList().range(listName, 0, -1);
        return result;
    }
    public void clearList(String listName){
        redisTemplate.opsForList().trim(listName, 99999999, -1);
    }
}
