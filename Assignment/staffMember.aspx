<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="staffMember.aspx.cs" Inherits="Assignment.staffMember" %>

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

        table {
            width: 95%;
            border-collapse: collapse;
            margin-top: 2%;
            margin-left: auto;
            margin-right: auto;
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Member]"></asp:SqlDataSource>
    <h1>Member</h1>
    <div class="search-box">
        <asp:TextBox CssClass="search-text" ID="txtSearch" runat="server" placeholder="Search..." OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
        <div class="search-btn">
            <asp:LinkButton CssClass="btnSearch" ID="btnSearchEvent" runat="server" OnClick="btnSearchEvent_Click">
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
                            <th>Member ID</th>
                            <th>Member Name</th>
                            <th>Email</th>
                            <th>Phone Number</th>
                            <th>Join On</th>
                            <th>Action</th>
                        </tr>
                    </thead>
            </HeaderTemplate>
            <ItemTemplate>
                <tbody>
                    <tr>
                        <td><%#Container.ItemIndex+1 %></td>
                        <td><%#Eval("memberID") %></td>
                        <td><%#Eval("name") %></td>
                        <td><%#Eval("email") %></td>
                        <td><%#Eval("phoneNo") %></td>
                        <td><%#Eval("joinedDate","{0:dd/MM/yyyy}") %></td>
                        <td>
                            <asp:LinkButton CssClass="link" ID="btnEditMember" runat="server" OnClick="btnEditMember_Click" PostBackUrl='<%# "~/staffMemberUpdate.aspx?memberID=" +  Eval("memberID")%>'>
                            <i class="fa fa-pencil" aria-hidden="true"></i>
                            </asp:LinkButton>
                            &nbsp;
                      
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

