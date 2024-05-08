<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="staffParticipantView.aspx.cs" Inherits="Assignment.staffParticipantView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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

        .paymentTitle {
            font-size: 30px;
            text-align: center;
            width: 100%;
        }

        .h2 {
            text-align: center;
            width: 100%;
        }

        .table {
            width: 60%;
            margin: 2% 15% 5% 20%;
        }

        .label {
            font-size: 25px;
            width: 20%;
            margin-left: 10%;
        }


        .input {
            border-radius: 10px;
            font-size: 20px;
            text-align: center;
            width: 65%;
        }

            .input:hover {
                transform: scale(1.1);
                border: 3px solid rgba(0, 0, 255, 0.6);
                transition: all 0.5s ease-out;
            }

        .list {
            width: 30%;
            border-radius: 10px;
        }

        tr, td {
            padding: 2%;
            color: black;
        }

        th {
            border-bottom: 2px dotted;
            border-color: rgba(0, 0, 255, 0.6);
        }


        .btnAdd {
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

            .btnAdd:hover {
                background-color: rgba(0, 0, 255, 0.6);
                transition: all 0.25s;
                color: white;
            }

        .btnReset {
            width: 20%;
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


        .auto-style3 {
            height: 80px;
        }

        .auto-style4 {
            height: 9px;
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

        .table-content td {
            padding: 12px 15px;
        }

        .table-content th {
            padding: 12px 10px;
        }



        .btnBack {
            margin-left: -10%;
            margin-right: 8%;
        }


        .auto-style5 {
            width: 40%;
            font-size: 20px;
            margin-left: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div cssclass="content">
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [recordID] FROM [Participate_Record] WHERE ([recordID] = @recordID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="recordID" QueryStringField="recordID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT (Event.eventID), Event.eventName, Event.eventImage FROM Event  INNER JOIN RecordEvent ON RecordEvent.eventID = Event.eventID Where recordID = @recordID
">
            <SelectParameters>
                <asp:QueryStringParameter Name="recordID" QueryStringField="recordID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT (Member.memberID), Member.name FROM Member INNER JOIN Participate_Record ON Participate_Record.memberID = Member.memberID Where recordID = @recordID
">
            <SelectParameters>
                <asp:QueryStringParameter Name="recordID" QueryStringField="recordID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT *
FROM Participate_Record
INNER JOIN Payment ON Payment.paymentID = Participate_Record.paymentID
WHERE Participate_Record.recordID = @recordID;
">
            <SelectParameters>
                <asp:QueryStringParameter Name="recordID" QueryStringField="recordID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
            <HeaderTemplate>
                <table class="table">
                    <tr>
                        <th colspan="8" class="auto-style3">
                            <asp:LinkButton ID="btnBack" CssClass="btnBack" runat="server" OnClientClick='window.location.replace("/staffParticipantHistory.aspx");return false;'><i class="fa fa-angle-double-left" style="font-size:36px;color:black;"></i></asp:LinkButton>
                            <asp:Label ID="lblTitle" runat="server" CssClass="staffTitle" Text="Participant History"></asp:Label>
                        </th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td class="auto-style5">
                        <asp:Label CssClass="label" ID="Label5" runat="server" Text="Record ID : "></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox CssClass="input" ID="TextBox5" runat="server" Enabled="False" Text='<%#Eval("recordID") %>'></asp:TextBox>
                    </td>
                </tr>
                <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource3">
                    <ItemTemplate>
                        <tr>
                            <td class="auto-style6">
                                <asp:Label CssClass="label" ID="Label6" runat="server" Text="Member ID : "></asp:Label>
                            </td>
                            <td colspan="2">
                                <asp:TextBox CssClass="input" ID="TextBox6" runat="server" Enabled="False" Text='<%#Eval("memberID") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style6">
                                <asp:Label CssClass="label" ID="Label1" runat="server" Text="Member Name: "></asp:Label>
                            </td>
                            <td colspan="2">
                                <asp:TextBox CssClass="input" ID="TextBox1" runat="server" Enabled="False" Text='<%#Eval("name") %>'></asp:TextBox>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
            <ItemTemplate>
                <asp:Label ID="lblEvent" runat="server" Style="display: none;" Text='<%# Eval("eventID")%>'></asp:Label>
                <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM RecordEvent INNER JOIN Event ON Event.eventID = RecordEvent.eventID INNER JOIN TicketPrice ON TicketPrice.eventID = Event.eventID INNER JOIN TicketCategory ON TicketCategory.ticketCategoryID = TicketPrice.ticketCategoryID where recordID =@recordID and RecordEvent.ticketCategory = TicketCategory.ticketCategoryName and Event.eventID = @eventID">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblEvent" Name="eventID" PropertyName="Text" />
                        <asp:QueryStringParameter Name="recordID" QueryStringField="recordID" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <table class="table">
                    <th colspan="8" class="auto-style3">
                        <asp:Label ID="lblPaymentTitle" runat="server" CssClass="paymentTitle" Text="Event Details"></asp:Label>
                    </th>
                    <tr>
                        <td class="auto-style6">
                            <asp:Label CssClass="label" ID="Label7" runat="server" Text="Event : "></asp:Label>
                        </td>
                        <td colspan="2">
                            <asp:Image ID="imgEvent" runat="server" Height="86px" Width="119px" ImageUrl='<%# Eval("eventImage")%>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style6">
                            <asp:Label CssClass="label" ID="Label5" runat="server" Text="Event ID : "></asp:Label>
                        </td>
                        <td colspan="2">
                            <asp:TextBox CssClass="input" ID="TextBox5" runat="server" Enabled="False" Text='<%#Eval("eventID") %>'></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style6">
                            <asp:Label CssClass="label" ID="Label8" runat="server" Text="Event Name : "></asp:Label>
                        </td>
                        <td colspan="2">
                            <asp:TextBox CssClass="input" ID="TextBox7" runat="server" Enabled="False" Text='<%#Eval("eventName") %>'></asp:TextBox>
                        </td>
                    </tr>

                    <asp:Repeater ID="Repeater6" runat="server" DataSourceID="SqlDataSource5">
                        <HeaderTemplate>
                            <table class="table">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:Label CssClass="label" ID="Label4" runat="server" Text='<%#Eval("ticketCategoryName") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style6">
                                    <asp:Label CssClass="label" ID="Label13" runat="server" Text="Quantity: "></asp:Label>
                                </td>
                                <td colspan="2">
                                    <asp:TextBox CssClass="input" ID="TextBox8" runat="server" Enabled="False" Text='<%#Eval("totalQuantity") %>'></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style6">
                                    <asp:Label CssClass="label" ID="Label2" runat="server" Text="Price: "></asp:Label>
                                </td>
                                <td colspan="2">
                                    <asp:TextBox CssClass="input" ID="TextBox9" runat="server" Enabled="False" Text='<%#Eval("price","{0:RM 0.00}") %>'></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style6">
                                    <asp:Label CssClass="label" ID="Label14" runat="server" Text="Subtotal: "></asp:Label>
                                </td>
                                <td colspan="2">
                                    <asp:TextBox CssClass="input" ID="TextBox10" runat="server" Enabled="False" Text='<%#Eval("subtotal","{0:RM 0.00}") %>'></asp:TextBox>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </table>
            </ItemTemplate>
        </asp:Repeater>
        <asp:Repeater ID="Repeater4" runat="server" DataSourceID="SqlDataSource4">
            <HeaderTemplate>
                <table class="table">
                    <tr>
                        <th colspan="8" class="auto-style3">
                            <asp:Label ID="lblPaymentTitle" runat="server" CssClass="paymentTitle" Text="Payment Details"></asp:Label>
                        </th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td class="auto-style6">
                        <asp:Label CssClass="label" ID="Label10" runat="server" Text="Payment ID : "></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox CssClass="input" ID="TextBox9" runat="server" Enabled="False" Text='<%#Eval("paymentID") %>'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:Label CssClass="label" ID="Label12" runat="server" Text="Total Price : "></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox CssClass="input" ID="TextBox11" runat="server" Enabled="False" Text='<%#Eval("recordTotalPrice","{0:RM 0.00}") %>'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:Label CssClass="label" ID="Label9" runat="server" Text="Tax : "></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox CssClass="input" ID="TextBox8" runat="server" Enabled="False" Text='<%#Eval("tax","{0:RM 0.00}") %>'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:Label CssClass="label" ID="Label11" runat="server" Text="Total Paid : "></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox CssClass="input" ID="TextBox10" runat="server" Enabled="False" Text='<%#Eval("totalPaid","{0:RM 0.00}") %>'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:Label CssClass="label" ID="Label3" runat="server" Text="Payment Method : "></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox CssClass="input" ID="TextBox3" runat="server" Enabled="False" Text='<%#Eval("paymentMethod") %>'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:Label CssClass="label" ID="Label4" runat="server" Text="Payment Created Date : "></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox CssClass="input" ID="TextBox4" runat="server" Enabled="False" Text='<%#Eval("paymentCreatedDate") %>'></asp:TextBox>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
