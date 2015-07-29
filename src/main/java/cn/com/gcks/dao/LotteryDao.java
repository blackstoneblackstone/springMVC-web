package cn.com.gcks.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by lihb on 7/26/15.
 */
@Service
public class LotteryDao {
    @Autowired
    private  JdbcTemplate jdbcTemplate;

    public  List<Map<String,Object>>  getPrize(String sceneid)
    {
        String sql="SELECT * from tp_wall_prize where sceneid=? ORDER by id ASC";
        List<Map<String,Object>> result= this.jdbcTemplate.queryForList(sql,sceneid);
        return result;
    }

    public  Map<String,Object>  getPrizeById(String id,String sceneid)
    {
        String sql="SELECT * from tp_wall_prize where sceneid=? and id=?";
        Map<String,Object> result= this.jdbcTemplate.queryForMap(sql, sceneid, id);
        return result;
    }

    public  int  setPrizeRecord(String openid,String username,String pic,String sceneid,String prize){
        String sql="INSERT INTO tp_wall_prize_record (openid,nickname,portrait,sceneid,prize,time) VALUES (?,?,?,?,?,?)";
        int result= this.jdbcTemplate.update(sql, openid, username, pic, sceneid, prize, new Date().getTime());
        return result;
    }
    public  List<Map<String,Object>>  getPrizeRecordById(String pid,String sceneid)
    {
        String sql="SELECT * from tp_wall_prize_record where sceneid=? and prize = ? order by time ASC";
        List<Map<String,Object>> result= this.jdbcTemplate.queryForList(sql, sceneid, pid);
        return result;
    }
    public  int  delPrizeRecord(String pid,String sceneid)
    {
        String sql="DELETE from tp_wall_prize_record where sceneid=? and prize = ?";
        int result= this.jdbcTemplate.update(sql, sceneid,pid);
        return result;
    }
}
