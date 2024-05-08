<%@ Page Title="" Language="C#" MasterPageFile="~/member.Master" AutoEventWireup="true" CodeBehind="memberParticipateRecordDetail.aspx.cs" Inherits="Assignment.memberParticipateRecordDetail" %>

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

        @keyframes slideinleft {
            0% {
                width: 0%;
            }

            100% {
                width: 5%;
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
        }

        .container {
            margin-left: 8%;
            margin-right: 8%;
        }

        h1 {
            border-bottom: 1px solid;
            border-color: blue;
            display: inline-block;
        }

        h2 {
            margin-bottom: 0;
        }

        .button {
            color: white;
            background-color: transparent;
            border: 3px rgba(0, 0, 255, 0.6) solid;
            border-radius: 20px;
            padding: 10px 20px;
            display: inline-block;
            font-size: 20px;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.25s;
        }

            .button:hover {
                background-color: rgba(0, 0, 255, 0.6);
                transition: all 0.25s;
                color: lightblue;
            }

        .number {
            width: 25%;
            height: 30px;
            border: 0px;
            border-radius: 40px;
            padding: 10px;
            background-color: rgb(7, 8, 50);
            color: white;
            font-size: 17px;
            line-height: 20px;
            margin-right: 5px;
            transition: all 0.6s;
        }

            .number::placeholder {
                color: gray;
            }

            .number:hover {
                background-color: rgb(7, 8, 50);
            }



        .img {
            border-radius: 8%;
            width: 300px;
            height: 170px;
        }

        .total-item {
            display: block;
            margin-bottom: 10px;
        }

        .item-container {
            margin-top: 30px;
            margin-bottom: 30px;
        }

        .btn {
            color: white;
            display: block;
            text-align: center;
            margin-top: 2%;
            font-size: 15px;
        }

            .btn:hover {
                color: blue;
                transition: all 0.75s;
            }

        .delete-btn {
            text-align: center;
        }

        .delete:hover .delete-btn {
            display: table-cell;
            background-color: red;
            animation: slideinleft 0.1s;
        }

        .delete-btn {
            display: none;
        }

        .total-left {
            display: inline-block;
            width: 90%;
        }

        .total-right {
            display: inline-block;
            width: 8%;
        }

        .clear {
            color: red;
            transition: all 0.5s;
        }

            .clear:hover {
                color: #a00909;
                transition: all 0.5s;
            }

        .item-nothing {
            text-align: center;
            margin: 10% 0 20% 0;
        }

            .item-nothing .fa {
                font-size: 100px;
            }

            .item-nothing p {
                font-size: 50px;
            }

        .payment-container {
            margin-top: 3%;
            margin-bottom: 5%;
        }

        .fa-commenting{
            
            transition:all 0.3s;
        }

        .fa-commenting:hover{
            color:blue;
            transition:all 0.3s;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT recordID FROM Participate_Record where recordID = @recordID">
        <SelectParameters>
            <asp:QueryStringParameter Name="recordID" QueryStringField="recordID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM Payment INNER JOIN Participate_Record ON Participate_Record.paymentID = Payment.paymentID INNER JOIN PromoCodeUsage ON PromoCodeUsage.paymentID = Participate_record.paymentID INNER JOIN PromoCode ON PromoCode.codeID = PromoCodeUsage.codeID where Participate_record.recordID=@recordID">
        <SelectParameters>
            <asp:Parameter Name="recordID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT COUNT(recordEventID) AS count FROM RecordEvent where recordID =@recordID">
        <SelectParameters>
            <asp:QueryStringParameter Name="recordID" QueryStringField="recordID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT(Event.eventID), Event.eventName, Event.eventImage FROM Event INNER JOIN RecordEvent ON RecordEvent.eventID = Event.eventID where recordID = @recordID">
        <SelectParameters>
            <asp:QueryStringParameter Name="recordID" QueryStringField="recordID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <div class="container">
        <div class="top">


            <asp:Repeater ID="Repeater5" runat="server" DataSourceID="SqlDataSource2">
                <ItemTemplate>
                    <h1>Record #<%# Eval("recordID")%></h1>
                </ItemTemplate>
            </asp:Repeater>
            <asp:Repeater ID="Repeater4" runat="server" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                    <h2>Events</h2>
                    <p style="margin-top: 0;"><%# Eval("count")%> Item(s)</p>
                </ItemTemplate>
            </asp:Repeater>

        </div>
        <hr />
        <table style="width: 100%; font-weight: bold;">
            <tr>
                <td style="width: 30%;">Event
                </td>
                <td style="width: 10%;">Ticket Category
                </td>
                <td style="width: 8%;">Ticket Price
                </td>
                <td style="width: 6%;">Quantity
                </td>
                <td style="width: 7%;">Subtotal
                </td>
                <td style="width: 7%;">Total
                </td>
                <td style="width: 7%;">Comment
                </td>
            </tr>
        </table>
        <hr />
        <div class="item-container">
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource3">

                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Style="display: none;" Text='<%# Eval("eventID")%>'></asp:Label>
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM RecordEvent INNER JOIN Event ON Event.eventID = RecordEvent.eventID INNER JOIN TicketPrice ON TicketPrice.eventID = Event.eventID INNER JOIN TicketCategory ON TicketCategory.ticketCategoryID = TicketPrice.ticketCategoryID where recordID =@recordID and RecordEvent.ticketCategory = TicketCategory.ticketCategoryName and Event.eventID = @eventID">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Label2" Name="eventID" PropertyName="Text" />
                            <asp:QueryStringParameter Name="recordID" QueryStringField="recordID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT SUM(RecordEvent.subtotal) AS total , eventID FROM RecordEvent where recordID=@recordID and eventID = @eventID GROUP BY eventID">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Label2" Name="eventID" PropertyName="Text" />
                            <asp:QueryStringParameter Name="recordID" QueryStringField="recordID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <div class="item-container">
                        <table style="width: 100%;">

                            <tr>
                                <td style="width: 27%;">
                                    <asp:Image CssClass="img" ID="Image1" runat="server" ImageUrl='<%# Eval("eventImage")%>' />
                                </td>
                                <td style="width: 13%;">
                                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("eventName")%>'></asp:Label></td>
                                <td style="width: 40%;">
                                    <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource4">
                                        <HeaderTemplate>
                                            <table style="width: 100%;">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr class="delete">
                                                <td style="width: 16%;">
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("ticketCategory")%>'></asp:Label>
                                                </td>
                                                <td style="width: 12%;">RM
                        <asp:Label ID="Label3" runat="server" Text='<%#Eval("price","{0:0.00}")%>'></asp:Label>
                                                </td>

                                                <td style="width: 7%;">
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("totalQuantity")%>'></asp:Label>
                                                </td>
                                                <td style="width: 9%;">RM
                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("subtotal","{0:0.00}")%>'></asp:Label>

                                                </td>

                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </td>
                                <td style="width: 20%;">

                                    <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource5">
                                        <HeaderTemplate>
                                            <table style="width: 100%;">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td style="width: 20%;">RM <%#Eval("total","{0:0.00}")%></td>

                                                <td style="width: 10%; cursor: pointer;" onclick="window.location.href = '/memberEventComment.aspx?eventID=<%#Eval("eventID")%>';"><i class="far fa-commenting"></i></td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table>
                                        </FooterTemplate>

                                    </asp:Repeater>

                                </td>
                            </tr>

                        </table>

                    </div>
                    <hr />
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM Payment INNER JOIN Participate_Record ON Participate_Record.paymentID = Payment.paymentID where Participate_record.recordID=@recordID">
            <SelectParameters>
                <asp:QueryStringParameter Name="recordID" QueryStringField="recordID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <h2>Payment Details</h2>
        <div class="payment-container">
            <asp:Repeater ID="Repeater6" runat="server" DataSourceID="SqlDataSource6">
                <ItemTemplate>
                    <table style="width: 80%">
                        <tr>
                            <td>
                                <asp:Label CssClass="finaltotal" ID="Label9" runat="server" Text="Payment Created Date"></asp:Label>
                            </td>
                            <td>:
                            </td>
                            <td class="finaltotal1">
                                <asp:Label CssClass="finaltotal" ID="Label12" runat="server" Text='<%#Eval("paymentCreatedDate","{0:dd/MM/yyyy}")%>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label CssClass="finaltotal" ID="Label15" runat="server" Text="Pay By"></asp:Label>
                            </td>
                            <td>:
                            </td>
                            <td class="finaltotal1">
                                <asp:Label CssClass="finaltotal" ID="Label16" runat="server" Text='<%#Eval("paymentMethod")%>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label CssClass="finaltotal" ID="Label6" runat="server" Text="Total "></asp:Label>
                            </td>
                            <td>:
                            </td>
                            <td class="finaltotal1">RM 
        <asp:Label CssClass="finaltotal" ID="Label4" runat="server" Text='<%#Eval("recordTotalPrice","{0:0.00}")%>'></asp:Label>
                            </td>

                        </tr>
                        <tr>
                            <td class="finaltotal1">
                                <asp:Label CssClass="finaltotal" ID="Label10" runat="server" Text="Discount"></asp:Label>
                            </td>
                            <td>:
                            </td>
                            <td class="finaltotal1">RM 
        <asp:Label CssClass="finaltotal" ID="Label11" runat="server" Text='<%#Eval("discount","{0:0.00}")%>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="finaltotal1">
                                <asp:Label CssClass="finaltotal" ID="Label13" runat="server" Text="After Discount"></asp:Label>
                            </td>
                            <td>:
                            </td>
                            <td class="finaltotal1">RM
        <asp:Label CssClass="finaltotal" ID="Label14" runat="server" Text='<%#(Convert.ToDouble(Eval("recordTotalPrice","{0:0.00}"))-Convert.ToDouble(Eval("discount","{0:0.00}")))%>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label CssClass="finaltotal" ID="Label7" runat="server" Text="Tax (6%) "></asp:Label>
                            </td>
                            <td>:
                            </td>
                            <td class="finaltotal1">RM 
        <asp:Label CssClass="finaltotal" ID="Label3" runat="server" Text='<%# Eval("tax","{0:0.00}")%>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label CssClass="finaltotal" ID="Label8" runat="server" Text="Grand Total "></asp:Label>
                            </td>
                            <td>:
                            </td>
                            <td class="finaltotal1">RM  
        <asp:Label CssClass="finaltotal" ID="Label5" runat="server" Text='<%#Eval("totalPaid","{0:0.00}")%>'></asp:Label>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:Repeater>
        </div>

    </div>
</asp:Content>
