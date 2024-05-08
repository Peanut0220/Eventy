<%@ Page Title="" Language="C#" MasterPageFile="~/user.Master" AutoEventWireup="true" CodeBehind="userFAQ.aspx.cs" Inherits="Assignment.userFAQ" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        @keyframes fadeIn {
            0% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }

        body {
            font-family: "kanit";
            background: black;
            color: #fff;
            animation: 2s fadeIn;
        }

        section {
            min-height: 100vh;
            width: 80%;
            margin: 0px auto 10% auto;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .title {
            font-size: 3rem;
            margin: 2rem 0rem;
        }

        .faq {
            width: 1000px;
            margin-top: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #fff;
            cursor: pointer;
            margin-bottom:5px;
        }

        .question {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

            .question .h3 {
                font-size: 25px;
                transition: all 0.5s;
            }

        .answer {
            max-height: 0;
            overflow: hidden;
            transition: max-height 1s ease;
        }

            .answer p {
                padding-top: 1rem;
                line-height: 1.6;
                font-size: 20px;
            }

        .faq.active .question .h3 {
            transition: all 0.5s;
            color: blue;
        }

        .faq.active .answer {
            max-height: 300px;
            animation: fade 1s ease-in-out;
        }

        .faq.active svg {
            transform: rotate(180deg);
        }

        svg {
            transition: transform 0.5s ease-in;
        }

        @keyframes fade {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
        <h2 class="title">FAQs</h2>

        <div class="faq">
            <div class="question">
                <asp:Label CssClass="h3" ID="Label1" runat="server" Text="Q: What events are scheduled for the upcoming months?"></asp:Label>
                <svg width="15" height="10" viewBox="0 0 42 25">
                    <path d="M3 3L21 21L39 3" stroke="white" stroke-width="7" stroke-linecap="round" />
                </svg>
            </div>
            <div class="answer">
                <p>
                    A: You can find a list of upcoming events on our website's event calendar.
                </p>
            </div>
        </div>

        <div class="faq">
            <div class="question">
                  <asp:Label CssClass="h3" ID="Label2" runat="server" Text="Q: Do I need to pay to register for events?"></asp:Label>
              
                <svg width="15" height="10" viewBox="0 0 42 25">
                    <path d="M3 3L21 21L39 3" stroke="white" stroke-width="7" stroke-linecap="round" />
                </svg>
            </div>
            <div class="answer">
                <p>
                    A: Event registration fees vary. Check the specific event details for registration costs.
                </p>
            </div>
        </div>

        <div class="faq">
            <div class="question">
                 <asp:Label CssClass="h3" ID="Label3" runat="server" Text="Q: Can I transfer my event registration to someone else?"></asp:Label>
                
                <svg width="15" height="10" viewBox="0 0 42 25">
                    <path d="M3 3L21 21L39 3" stroke="white" stroke-width="7" stroke-linecap="round" />
                </svg>
            </div>
            <div class="answer">
                <p>
                    A: Generally, event registrations are non-transferable. Contact support for special cases.
                </p>
            </div>
        </div>

        <div class="faq">
            <div class="question">
                 <asp:Label CssClass="h3" ID="Label4" runat="server" Text="Q: Are there age restrictions for event participation?"></asp:Label>
         
                <svg width="15" height="10" viewBox="0 0 42 25">
                    <path d="M3 3L21 21L39 3" stroke="white" stroke-width="7" stroke-linecap="round" />
                </svg>
            </div>
            <div class="answer">
                <p>
                    A: Event age restrictions, if any, are specified in the event details. Check before registering.
                </p>
            </div>
        </div>

        <div class="faq">
            <div class="question">
                 <asp:Label CssClass="h3" ID="Label5" runat="server" Text="Q: How can I receive updates about event changes or cancellations?"></asp:Label>
               
                <svg width="15" height="10" viewBox="0 0 42 25">
                    <path d="M3 3L21 21L39 3" stroke="white" stroke-width="7" stroke-linecap="round" />
                </svg>
            </div>
            <div class="answer">
                <p>
                    A: Event updates will be communicated through email and posted on our website and social media channels.
                </p>
            </div>
        </div>
        <div class="faq">
            <div class="question">
                 <asp:Label CssClass="h3" ID="Label6" runat="server" Text="Q: Is there parking available at the event venue?"></asp:Label>
              
                <svg width="15" height="10" viewBox="0 0 42 25">
                    <path d="M3 3L21 21L39 3" stroke="white" stroke-width="7" stroke-linecap="round" />
                </svg>
            </div>
            <div class="answer">
                <p>
                   A: Information about parking facilities can be found in the event details or on the venue's website.
                </p>
            </div>
        </div>
        <div class="faq">
            <div class="question">
                 <asp:Label CssClass="h3" ID="Label7" runat="server" Text="Q: How do I download Virtual Pass for the event?"></asp:Label>
           
                <svg width="15" height="10" viewBox="0 0 42 25">
                    <path d="M3 3L21 21L39 3" stroke="white" stroke-width="7" stroke-linecap="round" />
                </svg>
            </div>
            <div class="answer">
                <p>
                    A: Event Pass can usually be downloaded from your account on our website after successful registration.
                </p>
            </div>
        </div>
    </section>





    <script>
        const faqs = document.querySelectorAll(".faq");

        faqs.forEach(faq => {
            faq.addEventListener("click", () => {
                faq.classList.toggle("active");
            })
        })
    </script>
</asp:Content>
