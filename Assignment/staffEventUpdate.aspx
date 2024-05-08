<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="staffEventUpdate.aspx.cs" Inherits="Assignment.staffEventUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        @font-face {
            font-family: "Kanit";
            src: url("Kanit-Regular.ttf");
        }

        * {
            font-family: "Kanit";
        }



        body {
            font-family: Impact;
        }



        .staffTitle {
            font-size: 40px;
            text-align: center;
            width: 100%;
        }

        .table {
            width: 60%;
            margin: 2% 15% 5% 20%;
        }

        .label {
            font-size: 25px;
            width: 15%;
        }

        .input {
            border-radius: 10px;
            font-size: 20px;
            text-align: center;
            width: 65%;
            transition: all 0.5s ease-out;
        }

            .input:hover {
                transform: scale(1.1);
                border: 3px solid rgba(0, 0, 255, 0.6);
                transition: all 0.5s ease-out;
            }

        .list {
            width: 45%;
            border: 2px solid black;
            border-radius: 10px;
            font-size: 20px;
            margin-top: 3%;
            margin-bottom: 2%;
            text-align: center;
            transition: all 0.5s ease-out;
        }


        tr, td {
            padding: 1%;
            color: black;
        }

        th {
            border-bottom: 2px dotted;
            border-color: rgba(0, 0, 255, 0.6);
        }


        .btnUpdate {
            margin-left: 28%;
            cursor: pointer;
            color: black;
            background-color: transparent;
            border: 3px rgba(0, 0, 255, 0.6) solid;
            border-radius: 20px;
            padding: 10px 20px;
            display: inline-block;
            font-size: 17px;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.25s;
            width: 17%;
        }

            .btnUpdate:hover {
                background-color: rgba(0, 0, 255, 0.6);
                transition: all 0.25s;
                color: white;
            }

        .btnReset {
            width: 15%;
            cursor: pointer;
            color: black;
            background-color: transparent;
            border: 3px rgba(0, 0, 255, 0.6) solid;
            border-radius: 20px;
            padding: 10px 20px;
            display: inline-block;
            font-size: 17px;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.25s;
            margin-left: 7%;
        }

            .btnReset:hover {
                background-color: rgba(0, 0, 255, 0.6);
                transition: all 0.25s;
                color: white;
            }

        .btnUpload {
            width: 17%;
            margin-left: 5%;
            cursor: pointer;
            color: black;
            background-color: transparent;
            border: 3px rgba(0, 0, 255, 0.6) solid;
            border-radius: 20px;
            padding: 10px 20px;
            display: inline-block;
            font-size: 13px;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.25s;
        }

            .btnUpload:hover {
                background-color: rgba(0, 0, 255, 0.6);
                transition: all 0.25s;
                color: white;
            }

        .auto-style3 {
            height: 80px;
        }

        .auto-style4 {
            height: 9px;
        }

        .upload {
            border-radius: 10px;
            border: 2px solid black;
            width: 40%;
            font-size: 16px;
        }

            .upload:hover {
                border-color: rgba(0, 0, 255, 0.6);
            }

        .rbl {
            width: 40%;
            font-size: 20px;
        }

        h1 {
            position: relative;
            margin-left: 40px;
            margin-right: 10px;
            font-size: 40px;
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
            /* text-align: center;*/
        }

        .table-content thead tr {
            background-color: #112363;
            color: #ffffff;
            text-align: left;
            font-size: 16px;
            text-align: center;
        }

        .table-content th, td {
            padding: 8px 4px;
        }

        .btnBack {
            margin-left: -10%;
            margin-right: 8%;
        }

        .lblStatus {
            display: none;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div cssclass="content">
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
            <HeaderTemplate>
                <table class="table">
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <th colspan="3" class="auto-style3">
                        <asp:LinkButton ID="btnBack" CssClass="btnBack" runat="server" OnClientClick='window.location.replace("/staffEvent.aspx");return false;'><i class="fa fa-angle-double-left" style="font-size:36px;color:black;"></i></asp:LinkButton>

                        <asp:Label ID="lblTitle" runat="server" CssClass="staffTitle" Text="Event Update Form"></asp:Label>
                    </th>
                </tr>
                <tr>
                    <td colspan="3" class="auto-style4"></td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:Label CssClass="label" ID="lblEventName" runat="server" Text="Name : "></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox CssClass="input" ID="txtEventNameUpdate" runat="server" Text='<%#Eval("eventName") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEventNameUpdate" ErrorMessage="Name cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtEventNameUpdate" ErrorMessage="Name only can accept 5-30 character" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@&,%#.\s]{5,30}$" Text="*"></asp:RegularExpressionValidator>

                        <asp:Label CssClass="label" ID="Label1" runat="server" Style="display: none;" Text='<%#Eval("eventID") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">

                        <asp:Label CssClass="label" ID="lblEventDescription" runat="server" Text="Description : "></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox CssClass="input" ID="txtEventDescriptionUpdate"  TextMode="MultiLine" runat="server" Text='<%#Eval("eventDescription") %>'></asp:TextBox>
                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEventDescriptionUpdate" ErrorMessage="Description cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEventDescriptionUpdate" ErrorMessage="Description only can accept 10-350 character" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@&,%#.\s]{10,350}$" Text="*"></asp:RegularExpressionValidator>

                        &nbsp;

                    </td>
                </tr>

                <tr>
                    <td>
                        <asp:Label CssClass="label" ID="lblEventStatus" runat="server" Text="Status : "></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:Label CssClass="lblStatus" ID="Label3" runat="server" Text='<%#Eval("eventStatus") %>'></asp:Label>
                        <%string status = status1();

                            if (status.Equals("Upcoming"))
                            {%>
                        <asp:DropDownList CssClass="list" ID="ddlEventStatusUpdate" runat="server">
                            <asp:ListItem Selected="True">Upcoming</asp:ListItem>
                            <asp:ListItem>Open for Registration</asp:ListItem>
                            <asp:ListItem>Sold Out</asp:ListItem>
                            <asp:ListItem>Closed</asp:ListItem>
                        </asp:DropDownList>
                        <%}
                            else if (status.Equals("Open for Registration"))
                            {%>
                        <asp:DropDownList CssClass="list" ID="DropDownList1" runat="server">
                            <asp:ListItem>Upcoming</asp:ListItem>
                            <asp:ListItem Selected="True">Open for Registration</asp:ListItem>
                            <asp:ListItem>Sold Out</asp:ListItem>
                            <asp:ListItem>Closed</asp:ListItem>
                        </asp:DropDownList>
                        <%}
                            else if (status.Equals("Sold Out"))
                            {%>
                        <asp:DropDownList CssClass="list" ID="DropDownList2" runat="server">
                            <asp:ListItem>Upcoming</asp:ListItem>
                            <asp:ListItem>Open for Registration</asp:ListItem>
                            <asp:ListItem Selected="True">Sold Out</asp:ListItem>
                            <asp:ListItem>Closed</asp:ListItem>
                        </asp:DropDownList>
                        <%}
                            else if (status.Equals("Closed"))
                            {%>
                        <asp:DropDownList CssClass="list" ID="DropDownList3" runat="server">
                            <asp:ListItem>Upcoming</asp:ListItem>
                            <asp:ListItem>Open for Registration</asp:ListItem>
                            <asp:ListItem>Sold Out</asp:ListItem>
                            <asp:ListItem Selected="True">Closed</asp:ListItem>
                        </asp:DropDownList>
                        <%}
                        %>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label CssClass="label" ID="lblEventDate" runat="server" Text="Date : "></asp:Label>
                    </td>
                    <td class="cal1">
                        <asp:TextBox CssClass="input" ID="txtEventStartDateUpdate" runat="server" TextMode="Date" Text='<%#Eval("eventStartDate","{0:yyyy-MM-dd}") %>'></asp:TextBox>
                         <asp:Label CssClass="input" ID="LabelStartDate" style="display:none;" runat="server" TextMode="Date" Text='<%#Eval("eventStartDate","{0:yyyy-MM-dd}") %>'></asp:Label>

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEventStartDateUpdate" Display="None" ErrorMessage="Date cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     <asp:Label ID="to" runat="server" Text="To"></asp:Label>
                    </td>
                    <td class="cal2">

                        <asp:TextBox CssClass="input" ID="txtEventEndDateUpdate" runat="server" Width="75%" TextMode="Date" Text='<%#Eval("eventEndDate","{0:yyyy-MM-dd}") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtEventEndDateUpdate" ErrorMessage="Date cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtEventStartDateUpdate" ControlToValidate="txtEventEndDateUpdate" ErrorMessage="End Date must be greater than or equal to Start Date" Text="*" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>

                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label CssClass="label" ID="lblEventTime" runat="server" Text="Time : "></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="input" ID="txtEventStartTimeUpdate" runat="server" TextMode="Time" Text='<%#Eval("eventStartTime") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtEventStartTimeUpdate" Display="None" ErrorMessage="Time cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     <asp:Label ID="Label2" runat="server" Text="To"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="input" ID="txtEventEndTimeUpdate" runat="server" TextMode="Time" Width="75%" Text='<%#Eval("eventEndTime") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtEventEndTimeUpdate" ErrorMessage="Time cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>

                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label CssClass="label" ID="lblEventAddress" runat="server" Text="Venue : "></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox CssClass="input" ID="txtEventAddressUpdate" runat="server" Text='<%#Eval("eventVenue") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtEventAddressUpdate" ErrorMessage="Venue cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtEventAddressUpdate" ErrorMessage="Venue only can accept 5-300 character" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@&%#.,%\s]{5,300}$" Text="*"></asp:RegularExpressionValidator>

                    </td>
                </tr>


                <tr>
                    <td>
                        <asp:Label CssClass="label" ID="lblEventCategory" runat="server" Text="Category : "></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:Label CssClass="lblStatus" ID="lblCategory" runat="server" Text='<%#Eval("category") %>'></asp:Label>
                        <%string category = category1();
                            if (category.Equals("Social"))
                            {%>

                        <asp:DropDownList CssClass="list" ID="ddlEventCategoryUpdate" runat="server">
                            <asp:ListItem></asp:ListItem>
                            <asp:ListItem Selected="True">Social</asp:ListItem>
                            <asp:ListItem>Cultural</asp:ListItem>
                            <asp:ListItem>Sports</asp:ListItem>
                            <asp:ListItem>Educational</asp:ListItem>
                            <asp:ListItem>Entertainment</asp:ListItem>
                            <asp:ListItem>Technology</asp:ListItem>
                            <asp:ListItem>Health and Welness</asp:ListItem>
                            <asp:ListItem>Food</asp:ListItem>
                            <asp:ListItem>Fair</asp:ListItem>
                        </asp:DropDownList>
                        <%}
                            else if (category.Equals("Cultural"))
                            {%>
                        <asp:DropDownList CssClass="list" ID="ddl2" runat="server">
                            <asp:ListItem></asp:ListItem>
                            <asp:ListItem>Social</asp:ListItem>
                            <asp:ListItem Selected="True">Cultural</asp:ListItem>
                            <asp:ListItem>Sports</asp:ListItem>
                            <asp:ListItem>Educational</asp:ListItem>
                            <asp:ListItem>Entertainment</asp:ListItem>
                            <asp:ListItem>Technology</asp:ListItem>
                            <asp:ListItem>Health and Welness</asp:ListItem>
                            <asp:ListItem>Food</asp:ListItem>
                            <asp:ListItem>Fair</asp:ListItem>
                        </asp:DropDownList>
                        <%}
                            else if (category.Equals("Sports"))
                            {%>
                        <asp:DropDownList CssClass="list" ID="ddl3" runat="server">
                            <asp:ListItem></asp:ListItem>
                            <asp:ListItem>Social</asp:ListItem>
                            <asp:ListItem>Cultural</asp:ListItem>
                            <asp:ListItem Selected="True">Sports</asp:ListItem>
                            <asp:ListItem>Educational</asp:ListItem>
                            <asp:ListItem>Entertainment</asp:ListItem>
                            <asp:ListItem>Technology</asp:ListItem>
                            <asp:ListItem>Health and Welness</asp:ListItem>
                            <asp:ListItem>Food</asp:ListItem>
                            <asp:ListItem>Fair</asp:ListItem>
                        </asp:DropDownList>
                        <%}
                            else if (category.Equals("Educational"))
                            {%>
                        <asp:DropDownList CssClass="list" ID="ddl4" runat="server">
                            <asp:ListItem></asp:ListItem>
                            <asp:ListItem>Social</asp:ListItem>
                            <asp:ListItem>Cultural</asp:ListItem>
                            <asp:ListItem>Sports</asp:ListItem>
                            <asp:ListItem Selected="True">Educational</asp:ListItem>
                            <asp:ListItem>Entertainment</asp:ListItem>
                            <asp:ListItem>Technology</asp:ListItem>
                            <asp:ListItem>Health and Welness</asp:ListItem>
                            <asp:ListItem>Food</asp:ListItem>
                            <asp:ListItem>Fair</asp:ListItem>
                        </asp:DropDownList>
                        <%}
                            else if (category.Equals("Entertainment"))
                            {%>
                        <asp:DropDownList CssClass="list" ID="ddl5" runat="server">
                            <asp:ListItem></asp:ListItem>
                            <asp:ListItem>Social</asp:ListItem>
                            <asp:ListItem>Cultural</asp:ListItem>
                            <asp:ListItem>Sports</asp:ListItem>
                            <asp:ListItem>Educational</asp:ListItem>
                            <asp:ListItem Selected="True">Entertainment</asp:ListItem>
                            <asp:ListItem>Technology</asp:ListItem>
                            <asp:ListItem>Health and Welness</asp:ListItem>
                            <asp:ListItem>Food</asp:ListItem>
                            <asp:ListItem>Fair</asp:ListItem>
                        </asp:DropDownList>
                        <%}
                            else if (category.Equals("Technology"))
                            {%>
                        <asp:DropDownList CssClass="list" ID="ddl6" runat="server">
                            <asp:ListItem></asp:ListItem>
                            <asp:ListItem>Social</asp:ListItem>
                            <asp:ListItem>Cultural</asp:ListItem>
                            <asp:ListItem>Sports</asp:ListItem>
                            <asp:ListItem>Educational</asp:ListItem>
                            <asp:ListItem>Entertainment</asp:ListItem>
                            <asp:ListItem Selected="True">Technology</asp:ListItem>
                            <asp:ListItem>Health and Welness</asp:ListItem>
                            <asp:ListItem>Food</asp:ListItem>
                            <asp:ListItem>Fair</asp:ListItem>
                        </asp:DropDownList>
                        <%}
                            else if (category.Equals("Health and Welness"))
                            {%>
                        <asp:DropDownList CssClass="list" ID="ddl7" runat="server">
                            <asp:ListItem></asp:ListItem>
                            <asp:ListItem>Social</asp:ListItem>
                            <asp:ListItem>Cultural</asp:ListItem>
                            <asp:ListItem>Sports</asp:ListItem>
                            <asp:ListItem>Educational</asp:ListItem>
                            <asp:ListItem>Entertainment</asp:ListItem>
                            <asp:ListItem>Technology</asp:ListItem>
                            <asp:ListItem Selected="True">Health and Welness</asp:ListItem>
                            <asp:ListItem>Food</asp:ListItem>
                            <asp:ListItem>Fair</asp:ListItem>
                        </asp:DropDownList>
                        <%}
                             else if (category.Equals("Food"))
                        {%>
                        <asp:DropDownList CssClass="list" ID="ddl8" runat="server">
                            <asp:ListItem></asp:ListItem>
                            <asp:ListItem>Social</asp:ListItem>
                            <asp:ListItem>Cultural</asp:ListItem>
                            <asp:ListItem>Sports</asp:ListItem>
                            <asp:ListItem>Educational</asp:ListItem>
                            <asp:ListItem>Entertainment</asp:ListItem>
                            <asp:ListItem>Technology</asp:ListItem>
                            <asp:ListItem>Health and Welness</asp:ListItem>
                            <asp:ListItem Selected="True">Food</asp:ListItem>
                            <asp:ListItem>Fair</asp:ListItem>
                        </asp:DropDownList>
                        <%}     else if (category.Equals("Fair"))
{%>
<asp:DropDownList CssClass="list" ID="ddl9" runat="server">
    <asp:ListItem></asp:ListItem>
    <asp:ListItem>Social</asp:ListItem>
    <asp:ListItem>Cultural</asp:ListItem>
    <asp:ListItem>Sports</asp:ListItem>
    <asp:ListItem>Educational</asp:ListItem>
    <asp:ListItem>Entertainment</asp:ListItem>
    <asp:ListItem>Technology</asp:ListItem>
    <asp:ListItem>Health and Welness</asp:ListItem>
    <asp:ListItem >Food</asp:ListItem>
    <asp:ListItem Selected="True">Fair</asp:ListItem>
</asp:DropDownList>
<%}
                        %>
                        
                    </td>
                </tr>


                <tr>
                    <td>
                        <asp:Label CssClass="label" ID="lbEventOrganizer" runat="server" Text="Organizer : "></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox CssClass="input" ID="txtEventOrganizerUpdate" runat="server" Text='<%#Eval("eventOrganizer") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtEventOrganizerUpdate" ErrorMessage="Organizer cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtEventOrganizerUpdate" ErrorMessage="Organizer only can accept 5-100 character" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@&#.\s]{5,100}$" Text="*"></asp:RegularExpressionValidator>

                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label CssClass="label" ID="lblEventImage" runat="server" Text="Image :"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:FileUpload CssClass="upload" ID="fuImage" runat="server" />
                        &nbsp;<asp:Button CssClass="btnUpload" ID="btnImageUpload" runat="server" Text="UPLOAD" OnClick="btnImageUpload_Click" />
                        <br />
                        <br />
                        <asp:Image ID="imgEvent" runat="server" Height="86px" Width="119px" ImageUrl='<%# Eval("eventImage")%>' />

                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
            <HeaderTemplate>
                <table class="table" style="margin-top: 5%;">
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:Label CssClass="label" ID="Label4" runat="server" Text='<%#Eval("ticketCategoryName") %>'></asp:Label>
                        <asp:Label CssClass="label" ID="Label5" runat="server" Style="display: none;" Text='<%#Eval("ticketCategoryID") %>'></asp:Label>
                        <asp:Label CssClass="label" ID="Label1" runat="server" Style="display: none;" Text='<%#Eval("eventID") %>'></asp:Label>
                    </td>
                    <td class="qty">
                        <asp:Label CssClass="label" ID="Label13" runat="server" Text="Quantity: "></asp:Label>
                    </td>
                    <td>


                        <asp:TextBox CssClass="input" ID="seniorQty" runat="server" Text='<%#Eval("quantityLeft") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="seniorQty" ErrorMessage="Quantity cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ControlToValidate="seniorQty" ErrorMessage="Invalid Quantity" ForeColor="Red" ValidationExpression="^[0-9]+$|^0$ " Text="*"></asp:RegularExpressionValidator>

                    </td>
                    <td>
                        <asp:Label CssClass="label" ID="Label8" runat="server" Text="Price: "></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="input" ID="SeniorPrice" runat="server" Text='<%#Eval("price","{0:0.00}") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" ControlToValidate="SeniorPrice" ErrorMessage="Price cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator13" runat="server" ControlToValidate="SeniorPrice" ErrorMessage="Invalid Price" ForeColor="Red" ValidationExpression="^\d+(\.\d{1,2})?$" Text="*"></asp:RegularExpressionValidator>

                    </td>
                </tr>

            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        <asp:Button CssClass="btnUpdate" ID="btnEventUpdate" runat="server" Text="Update" OnClick="btnEventUpdate_Click" />
        <asp:ValidationSummary ShowMessageBox="true" ShowSummary="false" ForeColor="Red" runat="server" ID="validationSummary"></asp:ValidationSummary>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Event.eventID, Event.eventName, Event.eventDescription, Event.eventStatus, Event.eventStartTime, Event.eventEndTime, Event.eventImage, Event.eventVenue, Event.eventOrganizer, Category.category, Event.eventStartDate, Event.eventEndDate FROM Event INNER JOIN Category ON Event.categoryID = Category.categoryID WHERE (Event.eventID = @eventID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="eventID" QueryStringField="eventID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT * FROM Event INNER JOIN Category  ON Event.categoryID = Category.categoryID INNER JOIN TicketPrice ON Event.eventID = TicketPrice.eventID INNER JOIN TicketCategory ON TicketPrice.ticketCategoryID = TicketCategory.ticketCategoryID WHERE (Event.eventID = @eventID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="eventID" QueryStringField="eventID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>

</asp:Content>

