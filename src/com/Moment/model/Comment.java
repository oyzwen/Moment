package com.Moment.model;

/**
 * Created by ow on 16/5/14.
 */
public class Comment {
    public String getCmtID() {
        return cmtID;
    }

    public void setCmtID(String cmtID) {
        this.cmtID = cmtID;
    }

    public String getCmtUsername() {
        return cmtUsername;
    }

    public void setCmtUsername(String cmtUsername) {
        this.cmtUsername = cmtUsername;
    }

    public String getCmtContent() {
        return cmtContent;
    }

    public void setCmtContent(String cmtContent) {
        this.cmtContent = cmtContent;
    }

    public String getLiked() {
        return liked;
    }

    public void setLiked(String liked) {
        this.liked = liked;
    }

    public String getMsgID() {
        return msgID;
    }

    public void setMsgID(String msgID) {
        this.msgID = msgID;
    }

    private String cmtID;
    private String cmtUsername;
    private String cmtContent;
    private String liked;//点赞  0 false 1 true;
    private String msgID;//外键  评论对象message的ID

    public static void main(String[] args) {

    }


}
