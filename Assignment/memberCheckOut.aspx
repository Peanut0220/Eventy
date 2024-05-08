<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="memberCheckOut.aspx.cs" Inherits="Assignment.memberCheckOut" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.css" />
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
                transform: translateX(-500px);
            }

            100% {
                transform: translateX(0);
            }
        }

        @keyframes slideinright {
            0% {
                transform: translateX(500px);
            }

            100% {
                transform: translateX(0);
            }
        }

        @keyframes slideinright1 {
            0% {
                transform: translateX(500px);
            }

            100% {
                transform: translateX(291px);
            }
        }

        @font-face {
            font-family: "Kanit";
            src: url("Kanit-Regular.ttf");
        }

        * {
            box-sizing: border-box;
            font-family: "Kanit";
        }


        ul {
            padding-left: 10px;
        }

        body {
            color: white;
            line-height: 1.4;
            background-color: #151515;
            animation: 1.5s fadeIn;
        }

        a {
            color: #000;
        }

        .content {
            display: block;
            margin-bottom: 10%;
        }

        .secure,
        .backBtn {
            display: flex;
        }

            .secure span,
            .backBtn span {
                margin-left: 5px;
            }

        .backBtn {
            margin-top: 20px;
            text-decoration: underline;
            transition: all 0.5s;
            cursor: pointer;
            opacity: 70%;
            color: white;
        }

            .backBtn:hover {
                opacity: 100%;
                transition: all 0.5s;
            }


        .secure {
            color: #afb5c0;
            align-items: flex-end;
        }

            .secure .fa {
                font-size: 20px;
                line-height: 20px;
            }

        .logo {
            font-size: 20px;
            font-weight: bold;
            display: flex;
            justify-content: center;
            align-items: flex-end;
        }

            .logo .fa {
                font-size: 32px;
                line-height: 32px;
                margin-right: 5px;
            }

        img {
            width: 100%;
            border-radius: 8px 8px 8px 8px;
            animation: 2s slideinleft;
        }

        .details {
            background-color: black;
            margin-left: 15%;
            margin-right: 15%;
            border-radius: 20px;
            height: 350px;
        }

        .details__item {
        }

        .details__user {
        }

        .ticket_price {
            display: block;
        }

        .item__total {
            font-size: 20px;
            animation: 1.3s slideinright;
        }

        .item__image {
            display: inline-block;
            align-items: center;
            justify-content: center;
        }

        .image {
            margin-top: -50px;
            margin-left: -100px;
            width: 200px;
        }


        .item__details {
            vertical-align: top;
            display: inline-block;
            padding: 30px;
            animation: 1.3s slideinright;
            height: 280px;
        }

        .item__title {
            font-size: 28px;
            font-weight: 600;
            animation: 1.3s slideinright;
            padding-bottom: 20px;
        }

        .ticketCategory {
            font-size: 20px;
        }

        .subtotal {
            font-size: 20px;
        }

        .totalQuantity {
            font-size: 20px;
        }

        .total {
            font-size: 25px;
            float: right;
            padding-right: 20px;
        }

        .finaltotal {
            font-size: 25px;
            float: right;
        }

        .finaltotal1 {
            font-size: 25px;
        }


        .fa {
            font-size: 16px;
            vertical-align: middle;
        }

        .finalitem {
            text-align: center;
        }

        header {
            background-color: #121212;
            min-height: 350px;
        }

        .navigation {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 50px 0 80px 0;
            color: #246eea;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 700;
        }

        .container {
            width: 960px;
            margin: 0 auto;
        }

        .shadow {
            box-shadow: 0 15px 35px rgba(50, 50, 93, 0.1), 0 5px 15px rgba(0, 0, 0, 0.07);
        }

        .row {
            display: flex;
        }

        .txt {
            border-color: #e1e8ee;
            width: 100%;
        }

        .input {
            border-radius: 10px;
            border-style: solid;
            border-width: 2px;
            height: 48px;
            padding-left: 15px;
            font-weight: 600;
            font-size: 14px;
            color: #5e6977;
            transition: all 0.3s;
        }

            .input:hover {
                background-color: #e2e2e2;
                transition: all 0.3s;
            }



        .text-validated {
            border-color: #7dc855;
        }

        .ddl {
            border-color: #f0f4f7;
            background-color: #f0f4f7;
            width: 100px;
            margin-right: 10px;
        }

        .title {
            font-size: 14px;
            padding-bottom: 8px;
        }

        .field {
            padding-top: 15px;
            padding-right: 30px;
            width: 50%;
        }

            .field.small {
                width: auto;
            }

        .notification {
            text-align: center;
            font-size: 28px;
            font-weight: 600;
            display: flex;
            justify-content: center;
            color: white;
        }

            .notification .fa {
                font-size: 28px;
                color: #7dc855;
                line-height: 28px;
                margin-right: 10px;
            }

        .actions {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            padding: 60px 0 40px 0;
        }

        .payment {
            padding: 20px 0 0 0;
        }

        .payment__title {
            margin: 40px 0 20px 0;
            font-size: 18px;
            display: flex;
            text-align: left;
        }

            .payment__title .fa {
                margin-right: 10px;
            }

        .btn {
            border-radius: 15px;
            border: 0;
            letter-spacing: 1px;
            color: #fff;
            background: black;
            padding: 20px 60px;
            white-space: nowrap;
            font-size: 16px;
            line-height: 1;
            text-transform: uppercase;
            transition: all 0.3s ease;
            text-decoration: none;
        }

            .btn .fa {
                margin-left: 10px;
                font-size: 20px;
            }

            .btn:hover {
                -webkit-transform: translateY(-2px);
                transform: translateY(-2px);
                background: #232323;
                transition: all 0.3s ease;
            }

            .btn.action__back {
                background: transparent;
                color: #a0a0a0;
            }

        .action__submit {
            border-radius: 10px;
        }

        .payment__types {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .payment__info {
            display: flex;
        }

        .payment__cc {
            flex: 60%;
        }


        .payment__type {
            display: flex;
            border: 5px solid #d9d9d9;
            border-radius: 8px;
            padding: 20px 40px;
            width: 100%;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            color: black;
            transition: all 0.3s ease;
        }

            .payment__type:hover {
                -webkit-transform: translateY(-1px);
                transform: translateY(-1px);
                transition: all 0.3s ease;
            }

        .payment__type_active {
            color: #0a0a0a;
            background: #f6fcf7;
            border-color: #7dc855;
        }

        .payment__type .fa {
            font-size: 32px;
            margin-right: 10px;
        }

        .payment__type + .payment__type {
            margin-left: 10px;
        }


        .content {
            display: block;
        }

        .payment_container_left {
            display: inline-block;
            width: 35%;
            background-color: black;
            margin-left: 18%;
            padding: 30px;
            border-radius: 20px;
            margin-right: 10px;
        }


        .payment_container_right {
            display: inline-block;
            width: 30%;
            background-color: black;
            vertical-align: top;
            padding: 30px;
            border-radius: 20px;
        }

        .promoCode {
            display: block;
        }

        .promoCodeSearch {
            width: 80%;
            border-radius: 10px;
            margin-top: 10px;
            margin-right: 10px;
            text-transform:uppercase;
        }

        .search {
        }

        .fa-search {
            color: white;
            transition: all 0.5s;
        }

            .fa-search:hover {
                color: blue;
                transition: all 0.5s;
            }

        .messageboxwrong {
            background-color: #ff7575;
            padding: 10px;
            margin: 10px 0 0 0;
            border-radius: 10px;
            animation: slideinleft 0.5s;
        }

        .messageboxcorrect {
            background-color: #6aff7f;
            padding: 10px;
            margin: 10px 0 0 0;
            border-radius: 10px;
            animation: slideinleft 0.5s;
            color: black;
        }

        .fa-check {
            color: green;
            font-size: 23px;
            margin-right: 2%;
            vertical-align: middle;
        }

        .fa-times {
            color: red;
            font-size: 23px;
            margin-right: 2%;
            vertical-align: middle;
        }
        .paypal{
            
           
        }
        .fa-paypal{
            font-size:30px;
             display:inline-block;
             margin-right:10px;
             color:#368fd1;
        }
        .payWord{
             display:inline-block;
             font-style:italic;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <header>
            <div class="container">
                <div class="navigation">

                    <div class="logo">
                        Eventy.
                    </div>
                    <div class="secure">
                        <i class="fa fa-shield" aria-hidden="true"></i>
                        <span>Secure Checkout</span>
                    </div>
                </div>
                <div class="notification">
                    Complete Your Purchase
                </div>
            </div>
        </header>
        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP 1 * FROM Payment ORDER BY paymentID DESC"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT cartTotal, (cartTotal*0.06) AS tax, cartTotal+(cartTotal*0.06) AS afterTax FROM [Cart] WHERE ([cartID] = @cartID)">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="" Name="cartID" SessionField="cartID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT(Event.eventID), Event.eventName, Event.eventImage FROM Event INNER JOIN CartEvent ON CartEvent.eventID = Event.eventID where CartEvent.cartID = @cartID and Event.isArchive=0">
            <SelectParameters>
                <asp:SessionParameter Name="cartID" SessionField="cartID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource2">
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Style="display: none;" Text='<%# Eval("eventID")%>'></asp:Label>

                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT SUM(CartEvent.subtotal) AS total FROM CartEvent where cartID=@cartID and eventID = @eventID">
                    <SelectParameters>
                        <asp:SessionParameter Name="cartID" SessionField="cartID" />
                        <asp:ControlParameter ControlID="Label2" Name="eventID" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM CART INNER JOIN CartEvent ON Cart.cartID = CartEvent.cartID INNER JOIN Event ON Event.eventID = CartEvent.eventID INNER JOIN TicketPrice ON TicketPrice.eventID = Event.eventID INNER JOIN TicketCategory ON TicketCategory.ticketCategoryID = TicketPrice.ticketCategoryID where Cart.cartID = @cartID and CartEvent.ticketCategory = TicketCategory.ticketCategoryName and Event.eventID = @eventID">
                    <SelectParameters>
                         <asp:SessionParameter Name="cartID" SessionField="cartID" />
                        <asp:ControlParameter ControlID="Label2" Name="eventID" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <section class="content">


                    <div class="details shadow">
                        <div class="details__item">

                            <div class="item__image">
                                <asp:Image CssClass="image" ID="Image1" runat="server" ImageUrl='<%# Eval("eventImage")%>' Width="450" Height="250" />

                            </div>
                            <div class="item__details">
                                <div class="item__title">
                                    <asp:Label CssClass="eventName" ID="Label1" runat="server" Text='<%# Eval("eventName") %> '></asp:Label>
                                </div>
                                <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource1">
                                    <HeaderTemplate>
                                        <table style="width: 100%;">
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td style="width: 20%;">
                                                <asp:Label CssClass="ticketCategory" ID="Label2" runat="server" Text='<%# Eval("ticketCategory")%>'></asp:Label>
                                            </td>

                                            <td style="width: 20%;">

                                                <asp:Label CssClass="totalQuantity" ID="ticketNum" runat="server" Text='<%# "Quantity: " + Eval("totalQuantity")%>' />

                                            </td>
                                            <td style="width: 20%;">
                                                <asp:Label CssClass="subtotal" ID="Label4" runat="server" Text='<%#"RM "+ Eval("subtotal","{0:0.00}")%>'></asp:Label>

                                            </td>

                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </table>
                                    </FooterTemplate>
                                </asp:Repeater>



                            </div>
                        </div>

                        <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource3">
                            <ItemTemplate>

                                <asp:Label CssClass="total" ID="Label4" runat="server" Text='<%#"Total : RM "+ Eval("total","{0:0.00}")%>'></asp:Label>

                            </ItemTemplate>
                        </asp:Repeater>

                    </div>

                </section>
            </ItemTemplate>



        </asp:Repeater>
        <div class="payment_container">
            <div class="payment_container_left">
                <table style="width: 100%;">


                    <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource4">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:Label CssClass="finaltotal" ID="Label6" runat="server" Text="Total "></asp:Label>
                                </td>
                                <td>:
                                </td>
                                <td class="finaltotal1">RM 
                                    <asp:Label CssClass="finaltotal" ID="Label4" runat="server" Text='<%#Eval("cartTotal","{0:0.00}")%>'></asp:Label>
                                </td>

                            </tr>
                            <tr>
                                <td class="finaltotal1">
                                    <asp:Label CssClass="finaltotal" ID="Label10" runat="server" Text="Discount (%)"></asp:Label>
                                </td>
                                <td>:
                                </td>
                                <td class="finaltotal1">RM 
                                    <asp:Label CssClass="finaltotal" ID="Label11" runat="server" Text="0"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="finaltotal1">
                                    <asp:Label CssClass="finaltotal" ID="Label13" runat="server" Text="After Discount"></asp:Label>
                                </td>
                                <td>:
                                </td>
                                <td class="finaltotal1">RM 
                                    <asp:Label CssClass="finaltotal" ID="Label14" runat="server" Text="0"></asp:Label>
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
                                    <asp:Label CssClass="finaltotal" ID="Label5" runat="server" Text='<%#Eval("afterTax","{0:0.00}")%>'></asp:Label>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>



                </table>
            </div>
            <div class="payment_container_right">
                <asp:Label CssClass="promoCode" ID="Label9" runat="server" Text="Type In Your Promo Code!"></asp:Label>
                <asp:TextBox CssClass="promoCodeSearch" ID="TextBox7" runat="server"></asp:TextBox><asp:LinkButton CssClass="search" ID="LinkButton2" runat="server" OnClick="LinkButton2_Click"><i class="fa fa-search" aria-hidden="true"></i></asp:LinkButton>
                <asp:Label CssClass="promocodehidden" ID="Label12" runat="server" Text="" Style="display: none;"></asp:Label>
                <div class="messageboxcorrect" id="promoCodeCorrect1" runat="server" visible="false">
                    <i class="fa fa-check" aria-hidden="true"></i>

                    <asp:Label CssClass="promocode-correct" ID="promoCodeCorrect" runat="server" Text=""></asp:Label>
                </div>

                <div class="messageboxwrong" id="promoCodeWrong1" runat="server" visible="false">
                    <i class="fa fa-times" aria-hidden="true"></i>
                    <asp:Label CssClass="promocode-wrong" ID="promoCodeWrong" runat="server" Text="Invalid Code Found!"></asp:Label>
                </div>

            </div>
        </div>
        

        <div class="container">
            <div class="actions">
                <div class="paypal">
                   <i class="fa fa-paypal" aria-hidden="true"></i><p class="payWord">Powered By Paypal</p>
                </div>
                <asp:LinkButton CssClass="btn action__submit" ID="LinkButton1" runat="server" OnClientClick="return confirmPurchase()" OnClick="LinkButton1_Click"> <i class="fa fa fa-arrow-circle-o-right"></i> Pay</asp:LinkButton>

                <asp:HyperLink CssClass="backBtn" ID="HyperLink1" runat="server" NavigateUrl="~/memberEvent.aspx">Go Back to Browse Event</asp:HyperLink>

            </div>

        </div>

    </form>
    <script>
        function confirmPurchase() {
            var x = confirm("Confirm To Pay?");
            return x;

        }

    </script>
</body>
</html>
