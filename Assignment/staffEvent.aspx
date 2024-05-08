<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="staffEvent.aspx.cs" Inherits="Assignment.staffEvent" %>

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

        .status.upcoming {
            padding: 2px 4px;
            background: #e9b10a;
            color: var(--white);
            border-radius: 4px;
            font-weight: 500;
        }

        .status.register {
            padding: 2px 4px;
            background: #8de02c ;
            color: var(--white);
            border-radius: 4px;
            font-weight: 500;
        }

        .status.sold {
            padding: 2px 4px;
            background: #f00;
            color: var(--white);
            border-radius: 4px;
            font-weight: 500;
        }

        .status.close {
            padding: 2px 4px;
            background: #1795ce;
            color: var(--white);
            border-radius: 4px;
            font-weight: 500;
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

    <asp:Label CssClass="label" ID="title" runat="server" Text="Event"></asp:Label>
    <div class="search-box">
        <asp:TextBox CssClass="search-text" ID="txtSearch" runat="server" placeholder="Search..." OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
        <div class="search-btn" style="right: 0; top: 0">
            <asp:LinkButton CssClass="btnSearch" ID="btnSearchEvent" runat="server" OnClick="btnSearchEvent_Click">
                <i class="fa fa-search" aria-hidden="true"></i>
            </asp:LinkButton>
        </div>
    </div>
    <div class="addEvent">
        <asp:Button CssClass="btnAdd" ID="btnAddEvent" runat="server" Text="Add Event" OnClick="btnAddEvent_Click" PostBackUrl="~/staffEventCreate.aspx" />
        <asp:Button CssClass="btnAdd" ID="archive" Text="Show Archived" runat="server" OnClick="archive_Click" />
    </div>
    <div class="table-content">
        <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
            <asp:View runat="server" ID="v1">
                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="Repeater1_ItemCommand">
                    <HeaderTemplate>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Event ID</th>
                                    <th>Event Name</th>
                                    <th>Total Pax Left</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tbody>
                            <tr>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT SUM ([quantityLeft]) as Quantity FROM [TicketPrice] INNER JOIN Event On TicketPrice.eventID = Event.eventID WHERE Event.eventID = @eventID">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="Label5" Name="eventID" PropertyName="Text" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <td><%#Container.ItemIndex+1 %></td>
                                <td>
                                    <asp:Label ID="Label5" runat="server" Text='<%#Eval("eventID") %>'></asp:Label>
                                </td>
                                <td><%#Eval("eventName") %></td>
                                <td>
                                    <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2" OnItemCommand="Repeater1_ItemCommand">
                                        <ItemTemplate>
                                            <%#Eval("Quantity") %>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </td>
                                <td>
                                    <%string status = status1();
                                        if (status.Equals("Upcoming"))
                                        {%>
                                    <asp:Label CssClass="status upcoming" ID="Label1" runat="server" Text='<%#Eval("eventStatus") %>'></asp:Label>
                                    <%}
                                        else if (status.Equals("Open for Registration"))
                                        {%>
                                    <asp:Label CssClass="status register" ID="Label2" runat="server" Text='<%#Eval("eventStatus") %>'></asp:Label>
                                    <%}
                                        else if (status.Equals("Sold Out"))
                                        {%>
                                    <asp:Label CssClass="status sold" ID="Label3" runat="server" Text='<%#Eval("eventStatus") %>'></asp:Label>
                                    <%}
                                        else if (status.Equals("Closed"))
                                        {%>
                                    <asp:Label CssClass="status close" ID="Label4" runat="server" Text='<%#Eval("eventStatus") %>'></asp:Label>
                                    <%}
                                    %>   
                                </td>
                                <td>
                                    <asp:LinkButton CssClass="link" ID="btnEditEvent" runat="server" OnClick="btnEditEvent_Click" PostBackUrl='<%# "~/staffEventUpdate.aspx?eventID=" +  Eval("eventID")%>'>
                            <i class="fa fa-pencil" aria-hidden="true"></i>
                                    </asp:LinkButton>
                                    &nbsp;
                        <asp:LinkButton CssClass="link" ID="btnDeleteEvent" runat="server" OnClientClick="return sureDelete()" OnClick="btnDeleteEvent_Click1" CommandArgument='<%#Eval("eventID") %>'>
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
            </asp:View>
            <asp:View ID="v2" runat="server">
                <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource3" OnItemCommand="Repeater1_ItemCommand">
                    <HeaderTemplate>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Event ID</th>
                                    <th>Event Name</th>
                                    <th>Total Pax Left</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tbody>
                            <tr>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT SUM ([quantityLeft]) as Quantity FROM [TicketPrice] INNER JOIN Event On TicketPrice.eventID = Event.eventID WHERE Event.eventID = @eventID">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="Label6" Name="eventID" PropertyName="Text" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <td><%#Container.ItemIndex+1 %></td>
                                <td>
                                    <asp:Label ID="Label6" runat="server" Text='<%#Eval("eventID") %>'></asp:Label></td>
                                <td><%#Eval("eventName") %></td>
                                <td>
                                    <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2" OnItemCommand="Repeater1_ItemCommand">
                                        <ItemTemplate>
                                            <%#Eval("Quantity") %>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </td>
                                <td>
                                    <%string status = status2();
                                        if (status.Equals("Upcoming"))
                                        {%>
                                    <asp:Label CssClass="status upcoming" ID="Label1" runat="server" Text='<%#Eval("eventStatus") %>'></asp:Label>
                                    <%}
                                        else if (status.Equals("Open for Registration"))
                                        {%>
                                    <asp:Label CssClass="status register" ID="Label2" runat="server" Text='<%#Eval("eventStatus") %>'></asp:Label>
                                    <%}
                                        else if (status.Equals("Sold Out"))
                                        {%>
                                    <asp:Label CssClass="status sold" ID="Label3" runat="server" Text='<%#Eval("eventStatus") %>'></asp:Label>
                                    <%}
                                        else if (status.Equals("Closed"))
                                        {%>
                                    <asp:Label CssClass="status close" ID="Label4" runat="server" Text='<%#Eval("eventStatus") %>'></asp:Label>
                                    <%}
                                    %>   
                                </td>
                                <td>
                                    <asp:LinkButton CssClass="link" ID="btnUnarchive" runat="server" OnClientClick="return sureRecover()" OnClick="btnUnarchive_Click" CommandArgument='<%#Eval("eventID") %>'>
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
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT  * from Event where isArchive = 0 "></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT  * from Event where isArchive = 1 "></asp:SqlDataSource>
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
