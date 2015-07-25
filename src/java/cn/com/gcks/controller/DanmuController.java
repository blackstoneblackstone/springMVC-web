package cn.com.gcks.controller;

import lombok.Getter;
import lombok.Setter;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import cn.com.gcks.service.MsgService;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * lfxa 2015-07-23
 */

@Controller
@RequestMapping(value = "/danmu")
@Getter
@Setter
public class DanmuController {
    @Autowired
    private RedisTemplate redisTemplate;
    @Autowired
    private MsgService msgService;

    @RequestMapping(value = "/{type}/{id}", method = RequestMethod.GET)
    public String index(@PathVariable("type")String type,
                        @PathVariable("id") String id,
                        HttpSession session){
        //清空数据
        redisTemplate.opsForList().trim(type+"-"+id, 99999999, -1);
        session.setAttribute("state",type+"-"+id);
        return "danmu";
    }

    @RequestMapping(value = "getmsg", method = RequestMethod.GET)
    @ResponseBody
    public String getMsg(HttpSession session){
        String table=String.valueOf(session.getAttribute("state"));
        JSONObject js= new JSONObject();
        JSONArray list = null;
        try{
            list = msgService.getMsgList(table);
            js.put("info","ok");
            js.put("message_list",list);
            System.out.print(table);
            System.out.println(list.length());
        }catch (Exception e){

        }
        System.out.println(js.toString());
        return js.toString();
    }


}
