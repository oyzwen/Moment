package com.Moment.dao;

import com.Moment.model.Comment;
import com.Moment.model.Message;
import com.Moment.util.SqlHelper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by ow on 16/5/14.
 */
public class MomentDao {


    //查询用户
    public ResultSet queryUser() throws SQLException {
        String sqlStr = "SELECT * FROM user where username = 'ow'";
        ResultSet rs = SqlHelper.executeQuery(sqlStr, null);
        return rs;
    }

    //查询消息
    public ResultSet queryMessage() throws SQLException {
        //String sqlStr = "SELECT message.*,comment.* FROM message, comment where message.msgID = comment.msgID";
        //String sqlStr = "SELECT * FROM message left join comment on message.msgID = comment.msgID";
        String sqlStr = "SELECT * FROM message";
        ResultSet rs = SqlHelper.executeQuery(sqlStr, null);
        return rs;
    }

    //查询评论
    public ResultSet queryComment() throws SQLException {
        String sqlStr = "SELECT * FROM comment";
        ResultSet rs = SqlHelper.executeQuery(sqlStr, null);
        return rs;
    }

    //插入消息
    public static void insertMessage(Message msg) {
        String sql = "INSERT INTO message (msgUsername, msgHeadImg,msgContent,msgTime) VALUES (?,?,?,?)";//增
        //String[] para =  {"张三","zhangsan.jpg","今天天气挺不错","2016年05月14日17:01:24"};
        String[] para = {msg.getMsgUsername(), msg.getMsgHeadImg(), msg.getMsgContent(), msg.getMsgTime()};
        SqlHelper.executeUpdate(sql, para);
    }

    //插入评论
    public static void insertComment(Comment cmt) {
        String sql = "INSERT INTO comment (cmtUsername,cmtContent,liked,msgID) VALUES (?,?,?,?)";//增
        //String[] para =  {"张三","你说的很对","0","210"};
        String[] para = {cmt.getCmtUsername(), cmt.getCmtContent(), cmt.getLiked(), cmt.getMsgID()};
        SqlHelper.executeUpdate(sql, para);
    }

    /*//删除消息
    public static void deleteMessage(String msgID) {
        String sql = "DELETE FROM message WHERE messageID=?";//删
        String[] para = {msgID};
        SqlHelper.executeUpdate(sql, para);
    }

    //删除评论
    public static void deleteComment(String msgID) {
        String sql = "DELETE FROM comment WHERE messageID=?";//删
        String[] para = {msgID};
        SqlHelper.executeUpdate(sql, para);
    }

    //更新消息
    public static void update(Message msg) {
        String sql = "UPDATE message SET username=?, headImg=?, content=?, time=? WHERE messageID="+msg.getMessageID();//改
        String[] para = {msg.getUsername(),msg.getHeadImg(),msg.getContent(),msg.getTime()};
        SqlHelper.executeUpdate(sql, para);
    }*/
}
