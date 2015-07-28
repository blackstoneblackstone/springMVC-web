package cn.com.gcks.controller;

import cn.com.gcks.dao.LotteryDao;
import cn.com.gcks.service.MsgService;
import lombok.Getter;
import lombok.Setter;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.util.JSONPObject;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * lfxa 2015-07-23
 */

@Controller
@RequestMapping(value = "/lottery")
@Getter
@Setter
public class LotteryController {
    @Autowired
    private MsgService msgService;
    @Autowired
    private LotteryDao lotteryDao;

    @RequestMapping(value = "/{type}/{id}", method = RequestMethod.GET)
    public String index(@PathVariable("type") String type,
                        @PathVariable("id") String id,
                        HttpSession session, HttpServletRequest request) {
        if (type == null || id == null || "null".equals(type) || "undefined".equals(type) || "null".equals(id) || "undefined".equals(id)) {
            return "ok";
        }
        session.setAttribute("state", type + "-" + id);
        session.setAttribute("sceneid", id);
        Long count = msgService.getUserCount(type + "-" + id + "-user");
        List<Map<String, Object>> prizes = lotteryDao.getPrize(id);
        request.setAttribute("userCount", count);
        request.setAttribute("prizes", prizes);
        return "lottery";
    }

    @RequestMapping(value = "getUserCount", method = RequestMethod.GET)
    @ResponseBody
    public String getUserCount(HttpSession session) {
        String table = String.valueOf(session.getAttribute("state"));
        JSONObject js = new JSONObject();
        Long count = msgService.getUserCount(table + "-user");
        js.put("err", 0);
        js.put("count", count);
        return js.toString();
    }

    @RequestMapping(value = "setPrize", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getPrize(HttpSession session, @RequestParam String pid) {
        try {
            String sceneid = String.valueOf(session.getAttribute("sceneid"));
            String table = String.valueOf(session.getAttribute("state"));
            JSONObject user = msgService.getRandomPrizeUser(table + "-user");
            int res = lotteryDao.setPrizeRecord(user.getString("wecha_id"), user.getString("nickname"), user.getString("portrait"), sceneid, pid);
            List<Map<String, Object>> records = null;
            if (res > 0) {
                records = lotteryDao.getPrizeRecordById(pid, sceneid);
            }
            return records;
        } catch (Exception e) {
            return new ArrayList<Map<String, Object>>();
        }

    }

    @RequestMapping(value = "getUser", method = RequestMethod.GET)
    @ResponseBody
    public List<String> getUser(HttpSession session) {
        String table = String.valueOf(session.getAttribute("state"));
        return msgService.getUserList(table + "-user");
    }

    @RequestMapping(value = "resetPrize", method = RequestMethod.GET)
    @ResponseBody
    public int resetPrize(HttpSession session, @RequestParam String pid) {
        String sceneid = String.valueOf(session.getAttribute("sceneid"));
        String table = String.valueOf(session.getAttribute("state"));
        List<Map<String, Object>> records = lotteryDao.getPrizeRecordById(pid, sceneid);
        for (Map<String, Object> record : records) {
            String openid = (String) record.get("openid");
            msgService.addUserToPrize(table + "-user", openid);
        }
        int re = lotteryDao.delPrizeRecord(pid, sceneid);
        return re;
    }

    @RequestMapping(value = "getPrizeRecord", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getPrizeRecord(HttpSession session, @RequestParam String pid) {
        String sceneid = String.valueOf(session.getAttribute("sceneid"));
        List<Map<String, Object>> records = lotteryDao.getPrizeRecordById(pid, sceneid);
        Map<String, Object> ps = lotteryDao.getPrizeById(pid, sceneid);
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("num", Integer.valueOf(String.valueOf(ps.get("num"))) - records.size());
        result.put("records", records);
        return result;
    }

    @RequestMapping(value = "reShangQiang", method = RequestMethod.GET)
    @ResponseBody
    public void reShangQiang(HttpSession session) {
        String table = String.valueOf(session.getAttribute("state"));
        msgService.reShangQiang(table + "-user");
    }
}
