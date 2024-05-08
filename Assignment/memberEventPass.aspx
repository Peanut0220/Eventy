<%@ Page Title="" Language="C#" MasterPageFile="~/member.Master" AutoEventWireup="true" CodeBehind="memberEventPass.aspx.cs" Inherits="Assignment.memberEventPass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css" />
    <style>
        @keyframes fadeIn {
            0% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }

        @font-face {
            font-family: "Kanit";
            src: url("Kanit-Regular.ttf");
        }

        * {
            font-family: "Kanit";
        }


        body {
            color: white;
            animation: 1.5s fadeIn;
        }

        .container {
            margin: 2% 8% 7% 8%;
            width: 80%;
        }

        table {
            border-collapse: collapse;
            margin: 25px 0;
            font-size: 0.9em;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
            width: 100%;
        }

            table .head {
                background-color: #2c5cc1;
                color: #ffffff;
                text-align: left;
                font-size: 17px;
            }

            table th, td {
                padding: 12px 15px;
            }

        .announce-title .h1 {
            font-size: 30px;
            display: inline-block;
            border-bottom: 7px solid rgb(19, 78, 144);
            margin: 5% 8% 0% 8%;
        }

        .h2 {
            font-size: 15px;
            display: inline-block;
            margin: 0% 8% 0% 8%;
        }

        .search-box {
            position: absolute;
            transform: translate(-50%,-50%);
            right: 5%;
            top: 26.5%;
            background-color: #0E114F;
            height: 40px;
            border-radius: 40px;
            padding: 15px 10px 0px 10px;
            opacity: 80%;
            transition: all 0.3s;
        }

            .search-box:hover {
                opacity: 100%;
                transition: all 0.3s;
            }



        .search-btn {
            text-decoration: none;
            color: #0E399E;
            float: left;
            width: 40px;
            border-radius: 50%;
            background: #0E114F;
            display: flex;
            justify-content: center;
            align-items: center;
            transition: 0.4s;
            border: none;
        }

        .search-txt {
            background: none;
            outline: none;
            border: none;
            float: right;
            padding: 0;
            color: white;
            font-size: 17px;
            line-height: 20px;
            width: 160px;
        }

        .data2 {
            background-color: #07091d;
            cursor: pointer;
            transition: all 0.3s;
        }

        .data1 {
            cursor: pointer;
            transition: all 0.3s;
        }

            .data1:hover {
                transform: translateX(10px);
                transition: all 0.3s;
            }

        .data2:hover {
            transform: translateX(10px);
            transition: all 0.3s;
        }

        .btnPage {
            color: white;
            font-size: 20px;
            margin-left: 15px;
            transition: all 0.5s;
        }

        .paging {
            text-align: center;
            display: flex;
            justify-content: center;
            margin: 3% 0% 3% 0%;
        }

        .btnPage:hover {
            color: blue;
            transform: translateY(-3px);
            transition: all 0.5s;
        }

        .btnPage:active {
            color: blue;
        }

        .currPage {
            font-size: 35px;
            color: #3c7dce;
            padding-top: 10px;
        }
        .used{
            color:red;
        }
         .unused{
     color:green;
 }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="announce-title">
        <asp:Label CssClass="h1" ID="Label1" runat="server" Text="Event Pass"></asp:Label>
    </div>
    <div class="search-box">
        <asp:LinkButton CssClass="search-btn" ID="LinkButton1" runat="server" OnClick="LinkButton1_Click"><i class="fa-solid fa-magnifying-glass"></i></asp:LinkButton>
        <asp:TextBox CssClass="search-txt" ID="TextBox1" runat="server" placeholder="Search"></asp:TextBox>

    </div>

    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM Event_Pass INNER JOIN RecordEvent ON RecordEvent.recordEventID = Event_Pass.recordEventID INNER JOIN Event ON Event.eventID = RecordEvent.eventID where Event_Pass.memberID = @memberID and (Event_Pass.passID LIKE '%'+@search1+'%' OR Event_Pass.passStatus LIKE '%'+@search2+'%' OR Event.eventName LIKE '%'+@search2+'%' OR Event.eventVenue LIKE '%'+@search2+'%' OR RecordEvent.ticketCategory LIKE '%'+@search2+'%') ORDER BY Event_Pass.passID DESC">
        <SelectParameters>
            <asp:Parameter Name="memberID" />
            <asp:Parameter Name="search1" />
            <asp:Parameter Name="search2" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT COUNT(Event_Pass.passID) AS count FROM Event_Pass INNER JOIN RecordEvent ON RecordEvent.recordEventID = Event_Pass.recordEventID INNER JOIN Event ON Event.eventID = RecordEvent.eventID where Event_Pass.memberID = @memberID">
        <SelectParameters>
            <asp:SessionParameter Name="memberID" SessionField="memberID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
        <ItemTemplate>

            <asp:Label CssClass="h2" ID="Label2" runat="server" Text='<%# Eval("count") +" result(s)"%>'></asp:Label>

        </ItemTemplate>
    </asp:Repeater>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM Event_Pass INNER JOIN RecordEvent ON RecordEvent.recordEventID = Event_Pass.recordEventID INNER JOIN Event ON Event.eventID = RecordEvent.eventID where Event_Pass.memberID = @memberID ORDER BY Event_Pass.passID DESC">
        <SelectParameters>
            <asp:SessionParameter Name="memberID" SessionField="memberID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
        <HeaderTemplate>

            <table class="container">
                <tr class="head">
                    <th>No.
                    </th>
                    <th>Event Pass ID
                    </th>
                    <th>Pass Status
                    </th>
                    <th>Event Name
                    </th>
                    <th>Event Venue
                    </th>
                    <th>Ticket Category
                    </th>
                    <th>Pax Quantity
                    </th>
                    <th>Event Date
                    </th>
                </tr>
        </HeaderTemplate>

        <ItemTemplate>



            <tr class="data1" onclick="window.location.href = '/memberEventPassDetail.aspx?passID=<%#Eval("passID")%>';">
                <td><%#Container.ItemIndex+1 %></td>
                <td><%#Eval("passID") %></td>
                <td><%string status = status1();
                        if (status.Equals("Used"))
                        {%>
                    <asp:Label CssClass="status used" ID="Label1" runat="server" Text='<%#Eval("passStatus") %>'></asp:Label>
                    <%}
                        else if (status.Equals("Unused"))
                        {%>
                    <asp:Label CssClass="status unused" ID="Label2" runat="server" Text='<%#Eval("passStatus") %>'></asp:Label>

                    <%}
                    %>   </td>
                <td><%#Eval("eventName") %></td>
                <td><%#Eval("eventVenue") %></td>
                <td><%#Eval("ticketCategory") %></td>
                <td><%#Eval("totalQuantity") %></td>
                <td><%#Eval("eventStartDate","{0:dd/MM/yyyy}") +" - "+ Eval("eventEndDate","{0:dd/MM/yyyy}") %></td>
            </tr>

        </ItemTemplate>
        <AlternatingItemTemplate>
            <tr class="data2" onclick="window.location.href = '/memberEventPassDetail.aspx?passID=<%#Eval("passID")%>';">
                <td><%#Container.ItemIndex+1 %></td>
                <td><%#Eval("passID") %></td>
                <td><%string status = status1();
        if (status.Equals("Used"))
        {%>
    <asp:Label CssClass="status used" ID="Label1" runat="server" Text='<%#Eval("passStatus") %>'></asp:Label>
    <%}
        else if (status.Equals("Unused"))
        {%>
    <asp:Label CssClass="status unused" ID="Label2" runat="server" Text='<%#Eval("passStatus") %>'></asp:Label>

    <%}
    %>   </td>
                <td><%#Eval("eventName") %></td>
                <td><%#Eval("eventVenue") %></td>
                <td><%#Eval("ticketCategory") %></td>
                <td><%#Eval("totalQuantity") %></td>
                <td><%#Eval("eventStartDate","{0:dd/MM/yyyy}") +" - "+ Eval("eventEndDate","{0:dd/MM/yyyy}") %></td>
            </tr>
        </AlternatingItemTemplate>
        <FooterTemplate>
            </table>
        </FooterTemplate>

    </asp:Repeater>
    <div class="paging">
        <asp:Label CssClass="currPage" ID="Label5" runat="server" Text=""></asp:Label>
        <asp:Repeater ID="rptPaging" runat="server" OnItemCommand="rptPaging_ItemCommand">
            <ItemTemplate>

                <asp:LinkButton ID="btnPage"
                    CssClass="btnPage"
                    CommandName="Page" CommandArgument="<%# Container.DataItem %>"
                    runat="server" Font-Bold="True">
 <%# Container.DataItem %>
                </asp:LinkButton>

            </ItemTemplate>
        </asp:Repeater>
    </div>

</asp:Content>
