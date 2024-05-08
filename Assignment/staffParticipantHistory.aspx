<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="staffParticipantHistory.aspx.cs" Inherits="Assignment.staffParticipantHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://kit.fontawesome.com/a81368914c.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <style>
        @font-face {
            font-family: "Kanit";
            src: url("Kanit-Regular.ttf");
        }

        * {
            font-family: "Kanit";
        }

        h1 {
            position: relative;
            left: 20px;
            font-size: 40px;
            margin-bottom: 20px;
            color: rgb(7,8,23);
        }

        .search-text {
            border: 0;
            outline: none;
        }

        .search-box {
            position: relative;
            width: 400px;
            height: 40px;
            margin-left: auto;
            margin-right: auto;
            margin-top: 5px;
            width: 95%;
        }

            .search-box .search-text {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 80%;
                padding: 10px 20px;
                border-radius: 50px;
                font-size: 18px;
            }

            .search-box .search-btn {
                position: absolute;
                top: 0;
                right: 0;
                width: 60px;
                height: 100%;
                z-index: 1;
                cursor: pointer;
                color: #112363;
            }

                .search-box .search-btn .fa {
                    position: absolute;
                    top: 40%;
                    left: 50%;
                    transform: translate(-50%, -50%);
                    font-size: 20px;
                }

        .btnAdd {
            width: 10%;
            position: relative;
            left: 40px;
            margin-top: 20px;
            background-color: #112363;
            border: none;
            color: white;
            padding: 8px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            cursor: pointer;
            border-radius: 8px;
        }

            .btnAdd:hover {
                color: #466eff;
            }

        table {
            width: 95%;
            border-collapse: collapse;
            margin-top: 20px;
            margin-left: auto;
            margin-right: auto;
            margin-bottom: 20px;
            font-size: 1.0em;
            border-radius: 5px 5px 0 0;
            overflow: hidden;
            text-align: center;
        }

        .table-content thead tr {
            background-color: #112363;
            color: #ffffff;
            text-align: left;
            font-weight: bold;
            font-size: 16px;
            text-align: center;
        }

        .table-content th, td {
            padding: 12px 15px;
        }

        .table-content tbody tr {
            border-bottom: 1px solid #dddddd;
        }

            .table-content tbody tr:nth-of-type(even) {
                background-color: #f3f3f3;
                font-weight: bold;
                color: #112363;
            }

        .auto-style1 {
            width: 190px;
        }

        .link {
            text-decoration: none;
            color: #466eff;
        }

            .link i {
                font-size: 18px;
            }

                                                        .btnPage {
    color: black;
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM Participate_Record INNER JOIN Payment ON Payment.paymentID = Participate_Record.paymentID INNER JOIN Member ON Member.memberID = Participate_Record.memberID"></asp:SqlDataSource>
    <h1>Participant History</h1>
    <div class="search-box">
        <asp:TextBox CssClass="search-text" ID="txtSearch" runat="server" placeholder="Search..." OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
        <div class="search-btn">
            <asp:LinkButton CssClass="btnSearch" ID="btnSearchHistory" runat="server" OnClick="btnSearchHistory_Click">
                <i class="fa fa-search" aria-hidden="true"></i>
            </asp:LinkButton>
        </div>
    </div>
    <div class="table-content">
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
            <HeaderTemplate>
                <table class="table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Record ID</th>
                            <th>Total Quantity</th>
                            <th>Total Price</th>
                            <th>Tax</th>
                            <th>Discount</th>
                            <th>Total Paid</th>
                            <th>Member</th>
         
                            <th>Paid On</th>
                            <th>Action</th>
                        </tr>
                    </thead>
            </HeaderTemplate>
            <ItemTemplate>
                <tbody>
                    <tr>
                        <td><%# Container.ItemIndex +1%></td>
                        <td><%#Eval("recordID") %></td>
                        <td><%#Eval("recordTotalQuantity") %></td>
                        <td><%#Eval("recordTotalPrice","{0:RM 0.00}") %></td>
                        <td><%#Eval("tax","{0:RM 0.00}") %></td>
                        <td><%#Eval("discount","{0:RM 0.00}") %></td>
                        <td><%#Eval("totalPaid","{0:RM 0.00}") %></td>
                        <td><%#Eval("name") %></td>
                 
                        <td><%#Eval("paymentCreatedDate","{0:dd/MM/yyyy}") %></td>
                        <td>
                            <asp:LinkButton CssClass="Link" ID="LinkButton1" runat="server" PostBackUrl='<%# "~/staffParticipantView.aspx?recordID=" +  Eval("recordID")%>'>
                                <i class="fa fa-eye" aria-hidden="true"></i>
                            </asp:LinkButton>
                        </td>
                    </tr>
                    
                </tbody>
            </ItemTemplate>
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
    </div>
</asp:Content>
