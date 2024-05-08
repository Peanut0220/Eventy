﻿<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="staff.aspx.cs" Inherits="Assignment.staff" %>
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

        .label {
            position: relative;
            left: 20px;
            font-size: 40px;
            margin-bottom: 20px;
            color: rgb(7,8,23);
            font-weight: bold;
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
            position: relative;
            left: 40px;
            margin-top: 10px;
            background-color: #112363;
            border: none;
            color: white;
            padding: 5px 10px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 18px;
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Staff] WHERE isArchive=0"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Staff] WHERE isArchive=1"></asp:SqlDataSource>
    <asp:Label CssClass="label" ID="title" runat="server" Text="Staff"></asp:Label>
    <div class="search-box">
        <asp:TextBox CssClass="search-text" ID="txtSearch" runat="server" placeholder="Search..." OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
        <div class="search-btn">
            <asp:LinkButton CssClass="btnSearch" ID="btnSearchStaff" runat="server" OnClick="btnSearchStaff_Click">
                <i class="fa fa-search" aria-hidden="true"></i>
            </asp:LinkButton>
        </div>
    </div>
    <div class="addStaff">
        <asp:Button CssClass="btnAdd" ID="btnAddEvent" runat="server" Text="Add Staff" OnClick="btnAddEvent_Click" PostBackUrl="~/staffCreate.aspx" />
        <asp:Button CssClass="btnAdd" ID="archive" Text="Show Archived" runat="server" OnClick="archive_Click" />
    </div>
    <div class="table-content">
        <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
            <asp:View ID="View1" runat="server">
                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                    <HeaderTemplate>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Staff ID</th>
                                    <th>Staff Name</th>
                                    <th>Email</th>
                                    <th>Phone Number</th>
                                    <th>Role</th>
                                    <th>Join On</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tbody>
                            <tr>
                                <td><%#Container.ItemIndex+1 %></td>
                                <td>
                                    <asp:Label ID="Label5" runat="server" Text='<%#Eval("staffID") %>'></asp:Label>
                                </td>
                                <td><%#Eval("name") %></td>
                                <td><%#Eval("email") %></td>
                                <td><%#Eval("phoneNo") %></td>
                                <td><%#Eval("role") %></td>
                                <td><%#Eval("joinedDate","{0:dd/MM/yyyy}") %></td>
                                <td>
                                    <asp:LinkButton CssClass="link" ID="btnEditStaff" runat="server" OnClick="btnEditStaff_Click" PostBackUrl='<%# "~/staffUpdate.aspx?staffID=" +  Eval("staffID")%>'>
                             <i class="fa fa-pencil" aria-hidden="true"></i>
                                    </asp:LinkButton>
                                    &nbsp;
                        <asp:LinkButton CssClass="link" ID="btnDeleteStaff" runat="server" OnClientClick="return sureDelete()" CommandArgument='<%#Eval("staffID") %>' OnClick="btnDeleteStaff_Click">
                            <i class="fa fa-trash" aria-hidden="true" ></i>
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
    <asp:Label CssClass="currPage" ID="Label1" runat="server" Text=""></asp:Label>
</div>
            </asp:View>
            <asp:View ID="View2" runat="server">
                <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2" >
                    <HeaderTemplate>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Staff ID</th>
                                    <th>Staff Name</th>
                                    <th>Email</th>
                                    <th>Phone Number</th>
                                    <th>Role</th>
                                    <th>Join On</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tbody>
                            <tr>
                                <td><%#Container.ItemIndex+1 %></td>
                                <td>
                                    <asp:Label ID="Label6" runat="server" Text='<%#Eval("staffID") %>'></asp:Label>
                                </td>
                                <td><%#Eval("name") %></td>
                                <td><%#Eval("email") %></td>
                                <td><%#Eval("phoneNo") %></td>
                                <td><%#Eval("role") %></td>
                                <td><%#Eval("joinedDate","{0:dd-M-yyyy}") %></td>
                                <td>

                                    <asp:LinkButton CssClass="link" ID="btnUnarchive" runat="server" OnClientClick="return sureRecover()" OnClick="btnUnarchive_Click" CommandArgument='<%#Eval("staffID") %>'>
                                          <i class="fa fa-refresh" aria-hidden="true"></i>
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </tbody>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
                   
            </asp:View>
        </asp:MultiView>
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
    <script>
        function sureDelete() {
            var r = confirm("Are you sure you want to delete this record?");
            return r;
        }

        function sureRecover() {
            var recover = confirm("Are you sure you want to recover this record?");
            return recover;
        }
    </script>
</asp:Content>
