package com.Moment.model;

/**
 * Created by ow on 16/5/14.
 */
public class Message {
    public String getMsgID() {
        return msgID;
    }

    public void setMsgID(String msgID) {
        this.msgID = msgID;
    }

    public String getMsgUsername() {
        return msgUsername;
    }

    public void setMsgUsername(String msgUsername) {
        this.msgUsername = msgUsername;
    }

    public String getMsgHeadImg() {
        return msgHeadImg;
    }

    public void setMsgHeadImg(String msgHeadImg) {
        this.msgHeadImg = msgHeadImg;
    }

    public String getMsgContent() {
        return msgContent;
    }

    public void setMsgContent(String msgContent) {
        this.msgContent = msgContent;
    }

    public String getMsgTime() {
        return msgTime;
    }

    public void setMsgTime(String msgTime) {
        this.msgTime = msgTime;
    }

    private String msgID;//主键  messageID
    private String msgUsername;//用户名
    private String msgHeadImg;//头像地址
    private String msgContent;//文本内容
    private String msgTime;//发布时间

    public static void main(String[] args) {

    }


}
