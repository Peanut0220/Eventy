<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="staffDashboard.aspx.cs" Inherits="Assignment.staffDashboard" %>


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

        .cardBox {
            position: relative;
            width: 100%;
            padding: 20px;
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            grid-gap: 30px;
        }

            .cardBox .card {
                position: relative;
                background: var(--white);
                padding: 30px;
                border-radius: 20px;
                display: flex;
                justify-content: space-between;
                cursor: pointer;
                box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
            }

                .cardBox .card .numbers {
                    position: relative;
                    font-weight: 500;
                    font-size: 40px;
                    color: var(--blue);
                }

                .cardBox .card .cardName {
                    color: var(--black2);
                    font-size: 1.1rem;
                    margin-top: 5px;
                }

                .cardBox .card .iconBx {
                    font-size: 3.5rem;
                    color: var(--black2);
                }

                .cardBox .card:hover {
                    background: var(--blue);
                }

                    .cardBox .card:hover .numbers,
                    .cardBox .card:hover .cardName,
                    .cardBox .card:hover .iconBx {
                        color: var(--white);
                    }

        .details {
            position: relative;
            width: 100%;
            padding: 20px;
            display: grid;
            grid-template-columns: 2fr 1fr;
            grid-gap: 30px;
        }

            .details .recentEvents {
                position: relative;
                min-height: 500px;
                background: var(--white);
                padding: 20px;
                box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
                border-radius: 20px;
            }

            .details .cardHeader {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
            }

        .cardHeader h2 {
            font-weight: 600;
            color: var(--blue);
        }

        .cardHeader .btn {
            position: relative;
            padding: 5px 10px;
            background: var(--blue);
            text-decoration: none;
            color: var(--white);
            border-radius: 6px;
            font-size: 18px;
        }

        .details table {
            width: 100%;
            border-collapse: collapse;
            font-size: 18px;
            margin-top: 5%;
        }

            .details table thead td {
                font-weight: 600;
                text-align: center;
            }

        .details .recentEvents table tr {
            color: var(--black1);
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .details .recentEvents table tbody tr:hover {
            background: var(--blue);
            color: var(--white);
        }

        .details .recentEvents table tr td {
            padding: 10px;
            text-align: center;
        }

        .status.upcoming {
            padding: 2px 4px;
            background: #8de02c;
            color: var(--white);
            border-radius: 4px;
            font-size: 16px;
            font-weight: 500;
        }

        .status.register {
            padding: 2px 4px;
            background: #e9b10a;
            color: var(--white);
            border-radius: 4px;
            font-size: 16px;
            font-weight: 500;
        }

        .status.sold {
            padding: 2px 4px;
            background: #f00;
            color: var(--white);
            border-radius: 4px;
            font-size: 16px;
            font-weight: 500;
        }

        .status.close {
            padding: 2px 4px;
            background: #1795ce;
            color: var(--white);
            border-radius: 4px;
            font-size: 16px;
            font-weight: 500;
        }

        .recentMembers {
            position: relative;
            display: grid;
            min-height: 500px;
            padding: 20px;
            background: var(--white);
            box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
            border-radius: 20px;
        }

            .recentMembers .imgBx {
                position: relative;
                width: 40px;
                height: 40px;
                border-radius: 50px;
                overflow: hidden;
            }

                .recentMembers .imgBx img {
                    position: absolute;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }

            .recentMembers table tr td {
                padding: 12px 10px;
            }

                .recentMembers table tr td h4 {
                    font-size: 18px;
                    font-weight: 500;
                    line-height: 1.2rem;
                }

                    .recentMembers table tr td h4 span {
                        font-size: 16px;
                        color: var(--black2);
                    }

        .recentMemberstable tr:hover {
            background: var(--blue);
            color: var(--white);
        }

        .recentMembers table tr:hover td h4 span {
            color: var(--white);
        }
        .chart{
            color:white;
        }

        @media (max-width: 991px) {
            .cardBox {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .details {
                grid-template-columns: 1fr;
            }

            .recentEvents {
                overflow-x: auto;
            }

            .status.close {
                white-space: nowrap;
            }
        }

        @media (max-width: 480px) {
            .cardBox {
                grid-template-columns: repeat(1, 1fr);
            }

            .cardHeader h2 {
                font-size: 20px;
            }
        }
       
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP 10 * FROM Participate_Record INNER JOIN Payment ON Payment.paymentID = Participate_Record.paymentID INNER JOIN RecordEvent ON RecordEvent.recordID = Participate_Record.recordID INNER JOIN Event ON Event.eventID = RecordEvent.eventID INNER JOIN Member ON Participate_Record.memberID = Member.memberID ORDER BY Participate_Record.recordID DESC"></asp:SqlDataSource>
    <div class="cardBox">
        <div class="card">
            <div>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT AVG(totalPaid) as avg FROM Payment

"></asp:SqlDataSource>
                <div class="numbers">
                    <asp:Repeater ID="Repeater5" runat="server" DataSourceID="SqlDataSource2">
                        <ItemTemplate>
                            <%#Eval("avg","{0:0.00}")%>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="cardName">Avg Paid Per Purchase</div>
            </div>

            <div class="iconBx">
               <ion-icon name="receipt-outline"></ion-icon>
            </div>
        </div>

        <div class="card">
            <div>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT SUM([recordTotalQuantity]) as Quantity FROM [Participate_Record] "></asp:SqlDataSource>
                <div class="numbers">
                    <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource3">
                        <ItemTemplate>
                            <%#Eval("Quantity")%>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="cardName">Total Ticket Sales</div>
            </div>

            <div class="iconBx">
                <ion-icon name="ticket-outline"></ion-icon>

            </div>
        </div>

        <div class="card">
            <div>
                <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT AVG(recordTotalQuantity) as avg FROM Participate_Record"></asp:SqlDataSource>
                <div class="numbers">
                    <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource4">
                        <ItemTemplate>
                            <%#Eval("avg","{0:0.00}")%>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="cardName">Avg Quantity Per Purchase</div>
            </div>

            <div class="iconBx">
               <ion-icon name="cart-outline"></ion-icon>
            </div>
        </div>

        <div class="card">
            <div>
                <div class="numbers">
                    <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT SUM([totalPaid]) as paid FROM [Payment]"></asp:SqlDataSource>
                    <asp:Repeater ID="Repeater4" runat="server" DataSourceID="SqlDataSource5">
                        <ItemTemplate>
                            <%#Eval("paid","{0:0.00}")%>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="cardName">Earning</div>
            </div>

            <div class="iconBx">
                <ion-icon name="cash-outline"></ion-icon>
            </div>
        </div>
    </div>

    <div class="details">
        <div class="recentEvents">
            <div class="cardHeader">
                <h2>Recent Records</h2>
                <asp:Button ID="btnViewAll" CssClass="btn" Text="View All" runat="server" OnClick="btnViewAll_Click" PostBackUrl="~/staffParticipantHistory.aspx" />
            </div>
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <HeaderTemplate>
                    <table>
                        <thead>
                            <tr>
                                <td>#</td>
                                <td>Event Name</td>
                                <td>Price</td>
                                <td>Category</td>
                                <td>Member Name</td>
                            </tr>
                        </thead>
                </HeaderTemplate>
                <ItemTemplate>
                    <tbody>
                        <tr>
                            <td><%# Container.ItemIndex +1%></td>
                            <td><%#Eval("eventName") %></td>
                            <td><%#Eval("subtotal","{0:RM 0.00}") %></td>
                            <td><%#Eval("ticketCategory") %></td>
                            <td> <%#Eval("name") %></td>
                           
                        </tr>
                    </tbody>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>



        <!-- ================= New Customers ================ -->
        <div class="recentMembers">
            <div class="cardHeader">
                <h2>Ticket Category Sales Chart</h2>
            </div>
            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand=" SELECT ticketCategory, COUNT(*) as CategoryCount FROM RecordEvent GROUP BY ticketCategory"></asp:SqlDataSource>
            <asp:Chart CssClass="chart" ID="Chart2" runat="server" DataSourceID="SqlDataSource6" Width="400px">
                <Series>
                    <asp:Series Name="Series1" XValueMember="ticketCategory" YValueMembers="CategoryCount"></asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1" ></asp:ChartArea>
                </ChartAreas>
            </asp:Chart>
           

        </div>
    </div>
</asp:Content>
