<%@ Page Title="" Language="C#" MasterPageFile="~/member.Master" AutoEventWireup="true" CodeBehind="memberCart.aspx.cs" Inherits="Assignment.memberCart" %>

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
            width: 350px;
            height: 200px;
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
            .item-nothing{
                text-align:center;
                margin:10% 0 20% 0;
            }
            .item-nothing .fa{
                font-size:100px;
            }

             .item-nothing p{
     font-size:50px;
 }
          
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT(Event.eventID), Event.eventName, Event.eventImage, Event.isArchive FROM Event INNER JOIN CartEvent ON CartEvent.eventID = Event.eventID where CartEvent.cartID = @cartID and isArchive=0">
        <SelectParameters>
            <asp:SessionParameter Name="cartID" SessionField="cartID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT COUNT(DISTINCT(CartEvent.eventID)) AS count, cartTotal FROM CartEvent INNER JOIN Cart ON Cart.cartID = CartEvent.cartID INNER JOIN Event ON Event.eventID = CartEvent.eventID where Cart.cartID = @cartID and Event.isArchive=0 GROUP BY cartTotal">
        <SelectParameters>
            <asp:SessionParameter Name="cartID" SessionField="cartID" />
        </SelectParameters>
    </asp:SqlDataSource>

    
    <div class="container">
        <div class="container-left">
           
              <div class="item-nothing" id="nothing" runat="server" visible="false">
      <i class="fa fa-shopping-basket" aria-hidden="true"></i>
                  <p>Seems like nothing here.... Time to add Some!</p>

                  
   
  </div>
           
            <asp:Repeater ID="Repeater4" runat="server" DataSourceID="SqlDataSource4" onprerender="Repeater4_PreRender" >
                <ItemTemplate>
                     <h1 style="font-size: 35px;">Event Cart</h1>
                    <div>

                       
                        <div class="total-left">Total Items: <asp:Label ID="Label1" runat="server" Text='<%# Eval("count")%>'></asp:Label></div>
                        <div class="total-right">
                            <asp:LinkButton CssClass="clear" ID="LinkButton3" runat="server" OnClick="LinkButton3_Click1" OnClientClick="return sureDeleteCart()">Clear Cart  <i class="fa fa-trash"></i></asp:LinkButton>

                        </div>
                    </div>


                    <hr />
                    <table style="width: 100%; font-weight: bold;">
                        <tr>
                            <td style="width: 50%;">Event
                            </td>
                            <td style="width: 8%;">Ticket Category
                            </td>
                            <td style="width: 10%;">Ticket Price
                            </td>
                            <td>Quantity
                            </td>
                            <td>Subtotal
                            </td>
                            <td style="width: 7%;">Total
                            </td>
                        </tr>
                    </table>
                    <hr />
                  
                 
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource2"   >

                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Style="display: none;" Text='<%# Eval("eventID")%>'></asp:Label>
                             <asp:Label ID="Label12" CssClass='<%# Eval("eventID")%>' runat="server" Style="display: none;" Text='<%# Eval("isArchive")%>'></asp:Label>
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

                            <div class='<%#"item-container "+ Eval("eventID")%>' id="itemmContainer" runat="server">
                                <table style="width: 100%;">

                                    <tr>
                                        <td style="width: 35%;">
                                            <asp:Image CssClass="img" ID="Image1" runat="server" ImageUrl='<%# Eval("eventImage")%>' />
                                        </td>
                                        <td style="width: 15%;"> <asp:Label CssClass='<%# "name " + Eval("eventID") %>' ID="Label6" runat="server" Text='<%# Eval("eventName")%>'></asp:Label></td>
                                        <td>
                                            <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource1"  >
                                                <HeaderTemplate>
                                                    <table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr class="delete">
                                                        <td style="width: 20%;">
                                                            <asp:Label CssClass='<%# "cat " + Eval("eventID") %>' ID="Label2" runat="server" Text='<%# Eval("ticketCategory")%>'></asp:Label>
                                                        </td>
                                                        <td style="width: 20%;">RM
                                                    <asp:Label ID="Label3" runat="server" Text='<%#Eval("price","{0:0.00}")%>'></asp:Label>
                                                     <asp:Label CssClass='<%# "left " + Eval("cartEventID") %>' ID="Label5" runat="server" Text='<%#Eval("quantityLeft")%>' style="display:none;"></asp:Label>
                                                        </td>
                                                        <td style="width: 30%;">
                                                            <asp:LinkButton CssClass='<%#Eval("cartEventID")%>' ID="LinkButton3" runat="server" CommandArgument='<%#Eval("cartEventID")%>' OnClick="LinkButton3_Click" ><i class='<%# "fa fa-minus " + Eval("cartEventID") %>' aria-hidden="true"></i></asp:LinkButton>
                                                            <asp:TextBox CssClass='<%# "number " + Eval("cartEventID") %>' ID="ticketNum" runat="server" type="number" value='<%# Eval("totalQuantity")%>' ReadOnly="True" />
                                                            <asp:LinkButton CssClass='<%#Eval("cartEventID")%>' ID="LinkButton2" runat="server" CommandArgument='<%#Eval("cartEventID")%>' OnClick="LinkButton2_Click" OnClientClick="return add1(event)" ><i class='<%# "fa fa-plus " + Eval("cartEventID") %>' aria-hidden="true"></i></asp:LinkButton>
                                                        </td>
                                                        <td>RM
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("subtotal","{0:0.00}")%>'></asp:Label>

                                                        </td>
                                                        <td class="delete-btn">
                                                            <asp:LinkButton ID="LinkButton4" runat="server" CommandArgument='<%#Eval("cartEventID")%>' OnClick="LinkButton4_Click" OnClientClick="return sureDelete()" ><i class="fa fa-times" style="color:white;" aria-hidden="true"></i> </asp:LinkButton>


                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    </table>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                        </td>
                                        <td>
                                            <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource3">
                                                <ItemTemplate>
                                                    RM <%#Eval("total","{0:0.00}")%>
                                                </ItemTemplate>
                                            </asp:Repeater>

                                        </td>
                                    </tr>

                                </table>

                            </div>
                            <hr />
      


                        </ItemTemplate>
                    </asp:Repeater>
                 
                                                <table style="width: 100%; font-size: 23px;">
    <tr>
        <td style="width: 75%;"></td>
        <td style="width: 15%;">Total Amount : 
        </td>
        <td>RM <%#Eval("cartTotal","{0:0.00}")%>
        </td>
    </tr>


</table>



                    <hr />
                    <div style="text-align: center; margin-top: 3%; margin-bottom: 3%;">
                        <asp:Button CssClass="button" ID="Button1" runat="server" Text="Checkout" PostBackUrl="~/memberCheckOut.aspx" OnClientClick="if(!validateQuantity()) return false;"  />
                        <asp:LinkButton CssClass="btn" ID="LinkButton1" runat="server" PostBackUrl="~/memberEvent.aspx">Back</asp:LinkButton>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
       
    </div>
    <script>
        function sureDelete() {
            var r = confirm("Are you sure you want to delete this ticket?");
            return r;
        }

        function sureDeleteCart() {
            var r = confirm("Are you sure you want to clear everything inside this cart?");
            return r;
        }

        function add1(e) {

            var elemArray = document.getElementsByClassName('number');
            var elemArray1 = document.getElementsByClassName('left');
            var clickedElement = e.target;
      
            for (var i = 0; i < elemArray.length; i++) {
    
                if (elemArray[i].className.replace('number ', '') == clickedElement.className.replace('fa fa-plus ', '')) {
                    if (elemArray1[i].className.replace('left ', '') == clickedElement.className.replace('fa fa-plus ', '')) {

                        if (Number(elemArray1[i].textContent) > elemArray[i].value) {
                       
                            return true;
                        } else {
                            alert('The Ticket Quantity Left is only ' + elemArray1[i].textContent);
                        }

                    }


                }
            }
            return false;
        }

        function validateQuantity() {
            var numberArray = document.getElementsByClassName('number');
            var leftArray = document.getElementsByClassName('left');
            var nameArray = document.getElementsByClassName('name');
            var catArray = document.getElementsByClassName('cat');

            for (var i = 0; i < numberArray.length; i++) {

                if (numberArray[i].className.replace('number ', '') == leftArray[i].className.replace('left ', '')) {
               

                    if (Number(leftArray[i].textContent) >= numberArray[i].value) {

                            return true;
                    } else {
                        alert('The ' + catArray[i].textContent + 'Ticket for ' + nameArray[i].textContent + '\'s Quantity is only ' + leftArray[i].textContent + ' left, Please adjust the quantity to continue to checkout.');
                        return false;
                        }

                    


                }
            }
          
        }
     

    </script>
</asp:Content>
