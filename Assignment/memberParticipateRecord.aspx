<%@ Page Title="" Language="C#" MasterPageFile="~/member.Master" AutoEventWireup="true" CodeBehind="memberParticipateRecord.aspx.cs" Inherits="Assignment.memberParticipateRecord" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
            margin: 2% 8% 20% 8%;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="announce-title">
        <asp:Label CssClass="h1" ID="Label1" runat="server" Text="Participate Record"></asp:Label>
    </div>
    <div class="search-box">
        <asp:LinkButton CssClass="search-btn" ID="LinkButton1" runat="server" OnClick="LinkButton1_Click"><i class="fa-solid fa-magnifying-glass"></i></asp:LinkButton>
        <asp:TextBox CssClass="search-txt" ID="TextBox1" runat="server" placeholder="Search" ></asp:TextBox>

    </div>
       <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT COUNT(Participate_Record.recordID) AS count FROM Participate_Record where memberID = @memberID">
           <SelectParameters>
               <asp:SessionParameter Name="memberID" SessionField="memberID" />
           </SelectParameters>
    </asp:SqlDataSource>
    <asp:Repeater ID="Repeater2" runat="server"  DataSourceID="SqlDataSource2">
        <ItemTemplate>

         <asp:Label CssClass="h2" ID="Label2" runat="server" Text='<%# Eval("count") +" result(s)"%>'></asp:Label>
            
        </ItemTemplate>
    </asp:Repeater>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM Participate_Record INNER JOIN Payment ON Payment.paymentID = Participate_Record.paymentID WHERE Participate_Record.memberID=@memberID ORDER BY Participate_Record.recordID DESC ">
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
                        <th>Record ID
                        </th>
                        <th>Total Price
                        </th>
                        <th>Total Quantity
                        </th>
                        <th>Total Paid
                        </th>
                        <th>Payment Method
                        </th>
                        <th>Paid On
                        </th>
                    </tr>
        </HeaderTemplate>

        <ItemTemplate>



               <tr class="data1" onclick="window.location.href = '/memberParticipateRecordDetail.aspx?recordID=<%#Eval("recordID")%>';">
                <td><%# Container.ItemIndex +1%></td>
                <td><%#Eval("recordID") %></td>
                <td><%#Eval("recordTotalPrice","{0:RM 0.00}") %></td>
                <td><%#Eval("recordTotalQuantity") %></td>
                <td><%#Eval("totalPaid","{0:RM 0.00}") %></td>
                <td><%#Eval("paymentMethod","{0:RM 0.00}") %></td>
                <td><%#Eval("paymentCreatedDate") %></td>
              <%--  <td style="text-align:center;" onclick="window.location.href = '/memberEventComment.aspx?eventID=<%#Eval("eventID")%>';"><i class="far fa-commenting"></i></td>--%>
            </tr>

        </ItemTemplate>
        <AlternatingItemTemplate>
            <tr class="data2" onclick="window.location.href = '/memberParticipateRecordDetail.aspx?recordID=<%#Eval("recordID")%>';">
                 <td><%# Container.ItemIndex+1%></td>
               <td><%#Eval("recordID") %></td>
   <td><%#Eval("recordTotalPrice","{0:RM 0.00}") %></td>
   <td><%#Eval("recordTotalQuantity") %></td>
   <td><%#Eval("totalPaid","{0:RM 0.00}") %></td>
   <td><%#Eval("paymentMethod","{0:RM 0.00}") %></td>
   <td><%#Eval("paymentCreatedDate") %></td>
                 <%--   <td style="text-align:center;" onclick="window.location.href = '/memberEventComment.aspx?eventID=<%#Eval("eventID")%>';"><i class="far fa-commenting"></i></td>--%>
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
