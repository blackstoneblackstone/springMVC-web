package cn.com.gcks.repository;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Random;

/**
 * 消息信息
 * Created by Pasenger on 15/6/26.
 */

@Service
@Getter
@Setter
@Slf4j
public class MsgRepository {

    @Autowired
    private RedisTemplate redisTemplate;


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
        size = redisTemplate.opsForList().size(listName);
        //删除已取出的数据：队尾插入队头插入
        redisTemplate.opsForList().trim(listName, everyGetNum, -1);
        return list;
    }

    public List<String> getUserList(String listName) {
        List<String> result = redisTemplate.opsForList().range(listName, 0, 100);
        return result;
    }

    public String getPrizeUser(String listName) {
        Long total = redisTemplate.opsForList().size(listName);
        Random random = new Random();
        int s = random.nextInt(total.intValue()) % (total.intValue() + 1);
        String user = String.valueOf(redisTemplate.opsForList().index(listName, s));
        return user;
    }

    public Long getUserCount(String listName) {
        Long total = redisTemplate.opsForList().size(listName);

        return total;
    }

    public String getUserName(String key) {
        JSONObject users = new JSONObject(getValueByKey(key));
        return users.getString("nickname");
    }

    public Object getValueByKey(final String keys) {

        return "";
    }
}
