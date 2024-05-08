<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="memberEventPassDetail.aspx.cs" Inherits="Assignment.memberEventPassDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css" />
    <title></title>
    <style>
        @font-face {
            font-family: "Kanit";
            src: url("Kanit-Regular.ttf");
        }

        @keyframes slideinleft {
            0% {
                transform: translateX(-700px);
            }

            100% {
                transform: translateX(0);
            }
        }

        * {
            box-sizing: border-box;
            font-family: "Kanit";
        }

        body {
            background: black;
        }

        .container {
            margin: 10% 20% 0 8%;
        }

            .container .item {
                width: 70%;
                float: left;
                padding: 0 20px;
                background: #fff;
                margin: 60px 10px 10px 20%;
                animation: 1.5s slideinleft;
            }



        .item1, .item2 {
            text-align: center;
        }

        .container .item .to {
            display: block;
            text-align: center;
        }

        .container .item-right, .container .item-left {
            float: left;
            padding: 20px;
        }

        .container .item-right {
            padding: 40px 20px 20px 20px;
            margin-right: 20px;
            width: 25%;
            position: relative;
            height: 296px;
        }

            .container .item-right .up-border, .container .item-right .down-border {
                padding: 14px 15px;
                background-color: black;
                border-radius: 50%;
                position: absolute;
            }

            .container .item-right .up-border {
                top: -8px;
                right: -35px;
            }

            .container .item-right .down-border {
                bottom: -13px;
                right: -35px;
            }

            .container .item-right .num {
                font-size: 60px;
                text-align: center;
                color: #111
            }

            .container .item-right .day {
                color: #555;
                font-size: 20px;
                margin-bottom: 9px;
            }

        .container .item-left .event {
            color: #555;
            font-size: 20px;
            margin-bottom: 9px;
            display: block;
        }

        .container .item-right .day {
            text-align: center;
            font-size: 25px;
        }

        .container .item-left {
            width: 71%;
            padding: 34px 0px 19px 46px;
            border-left: 3px dotted #999;
        }

            .container .item-left .title {
                color: #111;
                font-size: 34px;
                margin-bottom: 12px
            }

            .container .item-left .sce {
                margin-top: 5px;
                display: block;
                height: 30px;
            }

                .container .item-left .sce .icon, .container .item-left .sce .p,
                .container .item-left .loc .icon, .container .item-left .loc .p {
                    float: left;
                    word-spacing: 2px;
                    letter-spacing: 0.5px;
                    color: #888;
                    margin-top: 2px;
                }

                .container .item-left .sce .icon, .container .item-left .loc .icon {
                    margin-right: 10px;
                    font-size: 20px;
                    color: #666
                }



        .fix {
            clear: both
        }

        .container .item .tickets {
            color: #fff;
            padding: 6px 14px;
            float: right;
            margin-top: 10px;
            font-size: 18px;
            border: none;
            cursor: pointer
        }

        .container .item .tickets {
            background-color: #1e870e;
        }

        .ok {
            color: white;
            position: absolute;
            left: 550px;
            top: 525px;
            text-align: center;
            animation: 1.5s slideinleft;
        }

        .btn {
            color: white;
            position: absolute;
            left: 700px;
            top: 565px;
            text-align: center;
            animation: 1.5s slideinleft;
            transition: all 0.75s;
            font-size: 20px;
        }

            .btn:hover {
                color: blue;
                transition: all 0.75s;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container" id="bill">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM Event_Pass INNER JOIN RecordEvent ON RecordEvent.recordEventID = Event_Pass.recordEventID INNER JOIN Event ON Event.eventID = RecordEvent.eventID INNER JOIN Category ON Category.categoryID = Event.categoryID where Event_Pass.passID = @passID">
                <SelectParameters>
                    <asp:QueryStringParameter Name="passID" QueryStringField="passID" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                    <div class="item">
                        <div class="item-right">
                            <div class="item1">
                                <asp:Label CssClass="num" ID="EventDay" runat="server" Text='<%# Eval("eventStartDate","{0:dd}")%>'></asp:Label>
                                <asp:Label CssClass="day" ID="EventMonth" runat="server" Text='<%# Eval("eventStartDate","{0:MMM}")%>'></asp:Label>
                            </div>

                            <asp:Label CssClass="to" ID="dayTo" runat="server" Text="to"></asp:Label>
                            <div class="item2">
                                <asp:Label CssClass="num" ID="EventDay1" runat="server" Text='<%# Eval("eventEndDate","{0:dd}")%>'></asp:Label>
                                <asp:Label CssClass="day" ID="EventMonth1" runat="server" Text='<%# Eval("eventEndDate","{0:MMM}")%>'></asp:Label>
                            </div>


                            <asp:Label CssClass="up-border" ID="Label3" runat="server" Text=""></asp:Label>
                            <asp:Label CssClass="down-border" ID="Label4" runat="server" Text=""></asp:Label>
                        </div>
                        <!-- end item-right -->

                        <div class="item-left">
                            <asp:Label CssClass="event" ID="eventCategory" runat="server" Text='<%# Eval("category")%>'></asp:Label>
                            <asp:Label CssClass="title" ID="eventName" runat="server" Text='<%# Eval("eventName")%>'></asp:Label>

                            <div class="sce">
                                <div class="icon">
                                    <i class="fa fa-table"></i>
                                </div>
                                <asp:Label CssClass="p" ID="eventDate" runat="server" Text='<%# Eval("ticketCategory")%>'></asp:Label>
                            </div>
                            <div class="sce">
                                <div class="icon">
                                    <i class="far fa-clock"></i>
                                </div>
                                <asp:Label CssClass="p" ID="eventTime" runat="server" Text='<%# DateTime.Parse(Eval("eventStartTime").ToString()).ToString("hh:mm") +" - "+  DateTime.Parse(Eval("eventEndTime").ToString()).ToString("hh:mm") %>'></asp:Label>

                            </div>
                            <div class="fix"></div>
                            <div class="loc">
                                <div class="icon">
                                    <i class="fa fa-map-marker"></i>
                                </div>
                                <asp:Label CssClass="p" ID="totalPax" runat="server" Text='<%# "Pax Quantity: "+Eval("totalQuantity")%>'></asp:Label>


                            </div>
                            <div class="fix"></div>
                            <div class="loc">
                                <div class="icon">
                                    <i class="fa fa-ticket" aria-hidden="true"></i>
                                </div>
                                <asp:Label CssClass="p" ID="member" runat="server" Text='<%# Eval("passID")%>'></asp:Label>


                            </div>


                            <asp:Button CssClass="tickets" ID="Button1" runat="server" Text='<%# Eval("passStatus")%>' />
                        </div>
                        <!-- end item-right -->
                    </div>

                    <!-- end item -->
                </ItemTemplate>
            </asp:Repeater>


        </div>
        <asp:Label CssClass="ok" ID="Label1" runat="server" Text="Note: Please Show This Virtual Pass To The Counter."></asp:Label>
        <asp:LinkButton CssClass="btn" ID="LinkButton1" runat="server" PostBackUrl="~/memberEventPass.aspx">Back</asp:LinkButton>
     
    </form>


</body>
</html>
