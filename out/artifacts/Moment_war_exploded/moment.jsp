<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.*" %>
<%@ page import="com.Moment.model.Comment" %><%--
  Created by IntelliJ IDEA.
  User: ow
  Date: 16/5/20
  Time: 13:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ow的朋友圈</title>
    <% String path = request.getContextPath(); %>
    <script type="text/javascript" src="script/jquery-1.7.2.js"></script>
    <style type="text/css">
        body {
            background: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        #container {
            width: 600px;
            height: 2500px;
            background: #ffffff;
            border: #ffffff 1px solid;
            margin: 0 auto;
            /*overflow: hidden;*/

        }

        #header {
            width: 598px;
            height: 400px;
            border: #f2f2f2 1px solid;
            margin: 0 auto 60px auto;
            padding: 0;
            background: url("img/bg.jpg");
            background-size: contain;
        }

        #myHeadImg {
            float: right;
            width: 100px;
            height: 100px;
            padding: 0;
            margin: 350px 50px 0px 20px;
            border: #ffffff 3px solid;
            box-shadow: 0 0 1px #666;
        }

        .title {
            float: right;
            color: #ffffff;
            font-size: 18px;
            font-weight: 800;
            padding: 0;
            margin-top: 370px;
            box-shadow: 0 0 1px #000;

        }

        .item {
            /*float: left;*/
            width: 560px;
            height: auto;
            margin: 20px auto;
            padding: 0;
            /*border: #72f5ff 1px solid;*/
        }

        .headImg {
            float: left;
            width: 60px;
            height: 60px;
            /*background: #72f5ff;*/
        }

        .headImg img {
            width: 60px;
            height: 60px;
            margin: 0;
            padding: 0;
        }

        .texts {
            float: left;
            margin: 0px 0px 5px 10px;
            width: 480px;
            height: auto;

        }

        .texts p {
            padding: 0;
            margin: 0px;
            margin-top: 10px;
        }

        .username {
            color: #6f84ce;
            font-size: 18px;
        }

        .content {
            color: #666666;
            line-height: 150%;
        }

        .icons {
            clear: both;
            margin: 0px 0px 0px 70px;
        }

        .time {
            float: left;
            font-size: 14px;
            font-family: 'DejaVu Sans', Arial, Helvetica, sans-serif;
            color: #cccccc;
            margin: 0;
            padding: 0px;
        }

        .time p {
            margin: 0;
            padding: 0px;
        }

        .icon_like {
            float: left;
            margin: 0px 0px 0px 250px;
        }

        .icon_like img {
            width: 18px;
            height: 16px;
        }

        .icon_comment {
            float: left;
            margin: 0px 10px 0px 15px;
        }

        .icon_comment img {
            width: 18px;
            height: 16px;
        }

        .interaction {
            clear: both;
            width: 480px;
            height: auto;
            background: #f2f2f2;
            margin: 30px 0px 0px 70px;
            padding-bottom: 0px;
            overflow: hidden
        }

        .icon_liked {
            float: left;
            width: 18px;
            height: 16px;
            margin: 10px 10px;
        }

        .liked {
            float: left;
            color: #6f84ce;
            margin: 10px 0px;
            padding: 0;
        }

        .comment {
            clear: both;
            color: #666;
            font-size: 16px;
            margin: 10px 0px;
            padding: 0;
            /*border:#72f5ff 1px solid;*/
        }

        .username {
            font-size: 16px;
            color: #6f84ce;
            margin: 0 10px;
            padding: 0;
        }

        .line {
            clear: both;
            height: 1px;
            width: 100%;
            background: #dddddd;
            margin: 10px 0px 0px 0px;
            /*margin-bottom: 10px;*/
            /*overflow: hidden;*/
        }

        .item-line {
            float: left;
            height: 1px;
            width: 100%;
            background: #f2f2f2;
            margin: 10px 0px;
        }

        .showInput {
            /*background: #72f5ff;*/
            margin: 10px auto;
            padding: 0;
        }

        .textInputComment {
            font-size: 16px;
            color: #666;
            margin: 0px 10px;
            padding: 0;
            width: 384px;
            height: 24px;
        }

        .btnSend {
            float: right;
            width: 60px;
            height: 22px;
            border-radius: 4px;
            background: #6f84ce;
            color: #FFFFFF;
            border: none;
            margin: 1px 10px 0px 0px;
            font-size: 12px;
        }
    </style>


    <script>
        $(function () {
            $(".showInput").hide();

            $(".icon_like").click(function () {
                var url = $(this).children("img").attr("src");
                var msgID = $(this).parent().parent().parent().children(".item").attr("msgID");
                var headImg = $("#container").children("#header").children("#myHeadImg").attr("src").substr(4);
                var username = $("#container").children("#header").children(".title").html();
                var cmtContent = '';

                if (url == "img/liked_gray.png") {
                    //alert("还没点赞,现在点赞")
                    $(this).children("img").attr("src", "img/liked.png");


                    var node = $(this).parent().parent().children("div[class='interaction']").children("p[class='liked']");
                    if(node.length>0){//已有人点赞
                        node.append(","+username);
                    }else{//还没人点赞
                        var str = "<img class='icon_liked' src='img/liked_blue.png'/>"+
                                        "<p class='liked'>" +username+"</p>"+
                                        "<div class='line'></div>";

                        $(this).parent().parent().children("div[class='interaction']").prepend(str);

                    }


                    // location.href = "moment?method=insertComment&cmtUsername=" + username + "&cmtContent=" + cmtContent + "&msgID=" + msgID + "&liked=1";

                    $.ajax({
                        url: "moment",
                        data: {
                            cmtUsername: username,
                            cmtContent: cmtContent,
                            msgID: msgID,
                            liked: "1",
                            method: "insertComment"
                        },
                        type: "POST",
                        datatype: "text",
                        sucess: function () {
                            //alert("sucess!")
                        },
                        error: function () {
                            alert("error");
                            return false;
                        }
                    })
                } else {
                    //alert("点过赞了,现在取消")
                    //$(this).children("img").attr("src", "img/liked_gray.png");

                }

            });

            $(".icon_comment").click(function () {
                if ($(".showInput").is(":visible")) {
                    $(this).parent().parent().children(".interaction").children(".showInput").hide();
                } else {
                    $(this).parent().parent().children(".interaction").children(".showInput").show();
                    $(this).parent().parent().children(".interaction").children(".showInput").children("input").focus();
                }
            });

            $(".btnSend").click(function () {
                var msgID = $(this).parent().parent().parent().parent().children(".item").attr("msgID");
                var username = $("#container").children("#header").children(".title").html();
                var cmtContent = $(this).parent().children("input").val();

                $(".showInput").hide();//隐藏输入框
                $(this).parent().children("input").val("");//清空输入框



//                alert("---btnSend----"+$(this).parent().html())

                //alert("评论成功!!!--------"+msgID+"--------"+cmtContent+"------"+username);
                //location.href = "moment?method=insertComment&cmtUsername=" + username + "&cmtContent=" + cmtContent + "&msgID=" + msgID + "&liked=0";

                $.ajax({
                    url: "moment",
                    data: {
                        cmtUsername: username,
                        cmtContent: cmtContent,
                        msgID: msgID,
                        liked: "0",
                        method: "insertComment"
                    },
                    type: "POST",
                    datatype: "text",
                    sucess: function () {
                        //alert("sucess!")
                    },
                    error: function () {
                        alert("error");
                        return false;
                    }
                })

                var str = "<p class='comment'><span class='username'>" + username + ":</span>" + cmtContent + "</p>";
                $(this).parent().before(str);

                //$(this).parent().parent().children("div[class='interaction']").children(".showInput").before(str);


//                $(this).parent().parent().children("p:last").append(str);

            })

        })
    </script>
</head>
<body>
<div id="container">
    <%
        ResultSet rsCurUser = (ResultSet) request.getAttribute("rsCurUser");
        String myHeadImg = "";
        String myUsername = "";
        while (rsCurUser.next()) {
            myHeadImg = rsCurUser.getString("headImg");
            myUsername = rsCurUser.getString("username");
        }
        out.println("<div id='header'>");
        out.println("<img id='myHeadImg' src='img/" + myHeadImg + "'/>");
        out.println("<p class='title'>" + myUsername + "</p>");
        out.println("</div>");

        ResultSet rsMessage = (ResultSet) request.getAttribute("rsMessage");
        ResultSet rsComment = (ResultSet) request.getAttribute("rsComment");

        while (rsMessage.next()) {
            String msgID = rsMessage.getString("msgID");
            String msgHeadImg = rsMessage.getString("msgHeadImg");
            String msgUsername = rsMessage.getString("msgUsername");
            String msgContent = rsMessage.getString("msgContent");
            String msgTime = rsMessage.getString("msgTime");


            out.println("<div class='item' msgID='" + msgID + "'>");
            out.println("<div class='headImg'><img src='img/" + msgHeadImg + "'/></div>");//头像
            out.println("<div class='texts'><p class='username'>" + msgUsername + "</p>");//用户名
            out.println("<p class='content'>" + msgContent + "</p></div>");//朋友圈消息内容


            String likedUsername = "";
            boolean iliked = false;
            ArrayList cmtArr = new ArrayList();

            rsComment.beforeFirst();
            while (rsComment.next()) {
                String cmtID = rsComment.getString("cmtID");
                String liked = rsComment.getString("liked");
                String cmtContent = rsComment.getString("cmtContent");
                String cmtUsername = rsComment.getString("cmtUsername");
                String curMsgID = rsComment.getString("msgID");

                Comment cmt = new Comment();
                cmt.setCmtID(cmtID);
                cmt.setCmtUsername(cmtUsername);
                cmt.setCmtContent(cmtContent);
                cmt.setLiked(liked);
                cmt.setMsgID(curMsgID);


                if (curMsgID.equals(msgID)) {
                    if (liked.equals("1")) {//点赞了
                        if (likedUsername.length() > 0) likedUsername += ",";
                        likedUsername += cmtUsername;
                        if (cmtUsername.equals(myUsername)) iliked = true;//当前用户点赞,显示红心
                    }

                    if (cmtContent.length() > 0) {
                        cmtArr.add(cmt);
                    }

                }
            }

            String likedIcon = iliked ? "img/liked.png" : "img/liked_gray.png";
            out.println("<div class='icons'><div class='time'>" + msgTime + "</p></div>");//时间
            out.println("<div class='icon_like'><img src='" + likedIcon + "'/></div>" +
                    "<div class='icon_comment'><img src='img/comment.png'/></div>" +
                    "</div>");

            boolean haveLiked = likedUsername.length() > 0;
            boolean haveComment = cmtArr.size() > 0;

            out.println("<div class='interaction'>");

            if (haveLiked) {
                out.println("<img class='icon_liked' src='img/liked_blue.png'/>");
                out.println("<p class='liked'>" + likedUsername + "</p>");
                if (haveComment) out.println("<div class='line'></div>");
            }

            for (int i = 0; i < cmtArr.size(); i++) {
                Comment cmt = (Comment) cmtArr.get(i);

                String username = (String) cmt.getCmtUsername();
                String comment = (String) cmt.getCmtContent();
                out.println("<p class='comment'><span class='username'>" + username + ":</span>" + comment + "</p>");
            }

            out.println("<div class='showInput'>" +
                    "<input class='textInputComment' type='text' name='comment'/>" +
                    "<button class='btnSend'>发送</button>" +
                    "</div></div>");
            out.println("</div>");
            out.println("<div class='item-line'/>");
        }

        rsMessage.close();
        rsComment.close();
    %>

</div>

</body>
</html>
