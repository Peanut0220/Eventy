<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="staffHome.aspx.cs" Inherits="Assignment.staffHome" %>

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



        .cssView1 {
            text-align: center;
            vertical-align: middle;
            margin-top: 20%;
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

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Event] WHERE ([staffID] = @staffID) ORDER BY [isArchive]">
        <SelectParameters>
            <asp:SessionParameter Name="staffID" SessionField="staffID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Notification] WHERE ([staffID] = @staffID) ORDER BY [isArchive], [createdDate] DESC">
        <SelectParameters>
            <asp:SessionParameter Name="staffID" SessionField="staffID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
            <div class="cssView1">


                <h1>Welcome Back !
                <asp:Label ID="Label1" runat="server"></asp:Label></h1>
                <h1>You can check your recent activity</h1>
                <div class="addStaff">
                    <asp:Button CssClass="btnAdd" ID="btnAddEvent" runat="server" Text="Created Event" OnClick="btnEvent_Click" Style="margin-right: 5%;" />
                    <asp:Button CssClass="btnAdd" ID="archive" Text="Created Notification" runat="server" OnClick="btnNotification_Click" />
                </div>
            </div>
        </asp:View>
        <asp:View ID="View2" runat="server">
            <div class="center">
                <h1 style="margin-left: 3%;">Created Event</h1>
                <div class="addStaff">
                    <asp:Button CssClass="btnAdd" ID="Button3" runat="server" Text="Back" OnClientClick='window.location.replace("/staffHome.aspx");return false;' />
                    <asp:Button CssClass="btnAdd" ID="Button4" Text="Created Notification" runat="server" OnClick="btnNotification_Click" />
                </div>

                <div class="table-content">
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                        <HeaderTemplate>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Event ID</th>
                                        <th>Event Name</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tbody>
                                <tr>
                                    <td><%#Container.ItemIndex+1 %></td>
                                    <td><%#Eval("eventID") %></td>
                                    <td><%#Eval("eventName") %> </td>
                                    <td>
                                        <asp:Label ID="lblStatus" runat="server" Text='<%# Convert.ToBoolean(Eval("isArchive")) ? "Archived" : "Not Archived" %>'></asp:Label>

                                    </td>




                                </tr>
                            </tbody>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>

            </div>
        </asp:View>
        <asp:View ID="View3" runat="server">
            <h1 style="margin-left: 3%;">Created Notification</h1>
            <div class="center">
                <div class="addStaff">
                    <asp:Button CssClass="btnAdd" ID="Button1" runat="server" Text="Created Event" OnClick="btnEvent_Click" />
                    <asp:Button CssClass="btnAdd" ID="Button2" Text="Back" runat="server" OnClientClick='window.location.replace("/staffHome.aspx");return false;' />
                </div>

                <div class="table-content">
                    <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
                        <HeaderTemplate>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Notification ID</th>
                                        <th>title</th>
                                        <th>createdDate</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tbody>
                                <tr>
                                    <td><%#Container.ItemIndex+1 %></td>
                                    <td><%#Eval("notifyID") %></td>
                                    <td><%#Eval("title") %></td>
                                    <td><%#Eval("createdDate","{0:dd/MM/yyyy}") %></td>
                                     <td>
                                       <asp:Label ID="Label2" runat="server" Text='<%# Convert.ToBoolean(Eval("isArchive")) ? "Archived" : "Not Archived" %>'></asp:Label>
                                    </td>

                                </tr>
                            </tbody>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>

            </div>
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

</asp:Content>
