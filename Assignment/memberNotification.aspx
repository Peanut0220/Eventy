<%@ Page Title="" Language="C#" MasterPageFile="~/member.Master" AutoEventWireup="true" CodeBehind="memberNotification.aspx.cs" Inherits="Assignment.memberNotification" %>

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
            margin: 0px 8% 0 8%;
  
        }
        .top{
             border-bottom: 3px solid;
            display: inline-block;
            margin-bottom:10px;
        }
        h1 {
            margin-bottom: 0;
        }

        .middle {
          
            width: 100%;
            margin-top: 10px;
        }

        .item-container {
            display: block;
            border: 2px solid;
            border-radius: 20px;
            width: 100%;
            padding:17px;
            margin-bottom:20px;
            height:100px;
        }

        .titlerow {
            display: inline-block;
            font-size:25px;
            color:#377ce9;

        }

        .timerow {
           display: inline-block;
           float:right;
        }

        .descriptionrow {
            display: block;
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Notification] where isArchive=0 ORDER BY notifyID DESC"></asp:SqlDataSource>
    <div class="container">
        <div class="top">
            <h1>Notification</h1>

        </div>
        <div class="middle">
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                    <div class="item-container">
                        <asp:Label CssClass="titlerow" ID="title" runat="server" Text='<%# Eval("title") %>'></asp:Label>
                        <asp:Label CssClass="timerow" ID="time" runat="server" Text='<%# Eval("createdDate") %>'></asp:Label>
                        <asp:Label CssClass="descriptionrow" ID="description" runat="server" Text='<%# Eval("description") %>'></asp:Label>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

           
        </div>
        <asp:Label ID="Label1" runat="server" Text="Label" style="display:none;"  OnPreRender="Repeater2_PreRender"></asp:Label>
    </div>

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
