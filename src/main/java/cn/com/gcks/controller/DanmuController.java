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
        session.setAttribute("state", type + "-" + id);
        session.setAttribute("all_total",0);
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




            Integer j=(Integer)session.getAttribute("all_total");
            if(list!=null&&j!=null){
                j=j+list.length();
            }else{
                j=0;
            }
            session.setAttribute("all_total",j);
            js.put("info", "ok");
            js.put("all_total",j.toString());
            js.put("message_list",list);
        }catch (Exception e){
           e.printStackTrace();
        }

        return js.toString();
    }


}
