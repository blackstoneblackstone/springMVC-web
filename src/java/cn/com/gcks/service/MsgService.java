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
            String userStr = msgRepository.getUserName(listName+"-user", openid);
            //String userStr = msgRepository.getUserName("3-3-user", openid);
            //log.info("用户信息：" + userStr);
            JSONObject jsonUser = new JSONObject(userStr);
            //String truename = (String) jsonUser.get("truename");
            //log.info("用户名称：" + truename);
            JSONObject msg= new JSONObject();
            msg.put("content",jsonMsg.get("content").toString());
            msg.put("username", jsonUser.get("truename").toString());
            array.put(msg);
        }
        return array;
    }




}
