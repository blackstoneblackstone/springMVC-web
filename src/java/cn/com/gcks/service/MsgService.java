package cn.com.gcks.service;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import cn.com.gcks.repository.MsgRepository;


import java.util.ArrayList;
import java.util.List;

/**
 * 消息操作
 * Created by Pasenger on 15/6/26.
 */

@Service
@Getter
@Setter
@Slf4j
public class MsgService {

    @Autowired
    private MsgRepository msgRepository;

    //@Value("${everykeepnum}")
    private String everyKeepNum="1000";

    //@Value("${everygetnum}")
    private String everyGetNum="50";


    public JSONArray getMsgList(String listName){
        List<String> list = msgRepository.getMsgList(listName, Long.parseLong(everyKeepNum),
                Long.parseLong(everyGetNum));
        if (list == null) {
            return null;
        }
        JSONArray array= new JSONArray();
        for (String msgStr:list) {
            JSONObject jsonMsg = new JSONObject(msgStr);
            String openid = (String) jsonMsg.get("openid");
            String userStr = msgRepository.getUserName(openid);
            JSONObject msg= new JSONObject();
            msg.put("content",jsonMsg.get("content").toString());
            msg.put("username", userStr);
            array.put(msg);
        }
        return array;
    }

    public List<String> getUserList(String listName){
        List<String> list = msgRepository.getUserList(listName);
        return list;
    }
    public JSONObject getRandomPrizeUser(String listName){
        String s=msgRepository.getPrizeUser(listName);
        return new JSONObject(s);
    }

    public Long getUserCount(String table){
        return msgRepository.getUserCount(table);
    }


    public void addUserToPrize(String tablename,String openid){
        String user=msgRepository.read(openid);
        if(user!=null){
            msgRepository.userAddList(tablename,user);
        }
    }
    public void reShangQiang(String tablename){
        List<String> ls=msgRepository.getAllUsers(tablename);
        for (String l:ls){
            JSONObject user=  new JSONObject(l);
            String openid=user.getString("wecha_id");
            msgRepository.delete(openid);
        }
        msgRepository.clearList(tablename);
    }
}
