package com.Moment.servlet;

import com.Moment.dao.MomentDao;
import com.Moment.model.Comment;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by ow on 16/5/14.
 */
public class MomentServlet extends HttpServlet {
    private MomentDao dao = new MomentDao();

    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("method");
        try {
            switch (method) {
                case "query":
                    query(req, resp);
                    break;

                case "insertMessage":

                    break;

                case "insertComment":
                    insertComment(req, resp);
                    break;
                default:
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }


    }


    public void query(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        ResultSet rsMessage = dao.queryMessage();
        ResultSet rsComment = dao.queryComment();
        ResultSet rsCurUser = dao.queryUser();

        req.setAttribute("rsCurUser", rsCurUser);
        req.setAttribute("rsMessage", rsMessage);
        req.setAttribute("rsComment", rsComment);


        req.getRequestDispatcher("moment.jsp").forward(req, resp);
    }


    public void insertComment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        //ResultSet rsMessage = dao.queryComment();
        //req.setAttribute("rsMessage", rsMessage);
        //req.getRequestDispatcher("Moment.jsp").forward(req, resp);

        String cmtUsername = req.getParameter("cmtUsername");
        String cmtContent = req.getParameter("cmtContent");
        String liked = req.getParameter("liked");
        String msgID = req.getParameter("msgID");

        java.net.URLDecoder.decode(cmtUsername, "utf-8");
        java.net.URLDecoder.decode(cmtContent, "utf-8");
        java.net.URLDecoder.decode(liked, "utf-8");
        java.net.URLDecoder.decode(msgID, "utf-8");

        Comment cmt = new Comment();
        cmt.setCmtContent(cmtContent);
        cmt.setCmtUsername(cmtUsername);
        cmt.setLiked(liked);
        cmt.setMsgID(msgID);


        dao.insertComment(cmt);
        query(req,resp);
        //req.getRequestDispatcher("moment.jsp").forward(req, resp);

    }
}
