<%@ Page Title="" Language="C#" MasterPageFile="~/member.Master" AutoEventWireup="true" CodeBehind="memberEventComment.aspx.cs" Inherits="Assignment.memberEventComment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
    <style>
    	@keyframes fadeIn {
    		0% {
    			opacity: 0;
    		}

    		100% {
    			opacity: 1;
    		}
    	}

    	@keyframes enter-animation {
    		0% {
    			transform: translateX(500px);
    		}

    		100% {
    			transform: translateX(0);
    		}
    	}

    	@font-face {
    		font-family: "Kanit";
    		src: url("Kanit-Regular.ttf");
    	}



    	* {
    		font-family: "Kanit";
    	}

    	:root {
    		--yellow: #FFBD13;
    		--blue: #4383FF;
    		--blue-d-1: #3278FF;
    		--light: #F5F5F5;
    		--grey: #AAA;
    		--white: #FFF;
    		--shadow: 8px 8px 30px rgba(0,0,0,.05);
    	}

    	body {
    		animation: 1.5s fadeIn;
    		background: var(--light);
    	}






    	.wrapper {
    		background: #151515;
    		padding: 2rem;
    		max-width: 576px;
    		width: 100%;
    		border-radius: .75rem;
    		box-shadow: var(--shadow);
    		text-align: center;
    		margin: 3% auto 3% auto;
    		color: white;
    		font-size: 25px;
    		animation: 1s enter-animation;
    	}

    		.wrapper ok {
    			font-size: 25px;
    			font-weight: 600;
    			margin-bottom: 1rem;
    		}

    	.rating {
    		display: flex;
    		justify-content: center;
    		align-items: center;
    		grid-gap: .5rem;
    		font-size: 2rem;
    		color: var(--yellow);
    		margin-bottom: 2rem;
    		margin-top: 10px;
    	}

    		.rating .bx, .bxs-star, .bxs-star::after, .bxs-star::before {
    			cursor: pointer;
    			transition: all 0.5s;
    		}

    		.rating .star.active {
    			opacity: 0;
    			animation: animate .5s calc(var(--i) * .1s) ease-in-out forwards;
    		}

    	@keyframes animate {
    		0% {
    			opacity: 0;
    			transform: scale(1);
    		}

    		50% {
    			opacity: 1;
    			transform: scale(1.2);
    		}

    		100% {
    			opacity: 1;
    			transform: scale(1);
    		}
    	}


    	.rating .bx:hover, .bxs-star:hover::after, .bxs-star:hover::before {
    		transform: translateY(-10px);
    		transition: all 0.5s;
    	}

    	.textarea {
    		width: 90%;
    		background: #5f5f5f;
    		padding: 1rem;
    		border-radius: .5rem;
    		border: none;
    		outline: none;
    		resize: none;
    		height: 100px;
    		margin-bottom: .5rem;
    		color: white;
    		font-size: 17px;
    	}

    	.texterea:hover {
    		background-color: blue;
    	}

    	.btn-group {
    		display: flex;
    		grid-gap: .5rem;
    		align-items: center;
    		margin-top: 10px;
    		margin-left: 10px;
    	}

    		.btn-group .btn {
    			padding: .75rem 1rem;
    			border-radius: .5rem;
    			border: none;
    			outline: none;
    			cursor: pointer;
    			font-size: .875rem;
    			font-weight: 500;
    		}

    			.btn-group .btn.submit {
    				background-color: #151e68;
    				color: var(--white);
    				opacity: 80%;
    				transition: all 0.5s;
                    text-decoration:none;
    			}

    				.btn-group .btn.submit:hover {
    					opacity: 100%;
    					transition: all 0.5s;
    				}

    			.btn-group .btn.cancel {
    				background: #830000;
    				color: white;
    				opacity: 80%;
    				transition: all 0.5s;
    			}

    				.btn-group .btn.cancel:hover {
    					opacity: 100%;
    					transition: all 0.5s;
    				}

    	.hidden {
    		display: none;
    	}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper">
        <asp:Label CssClass="ok" ID="Label1" runat="server" Text="Leave a Comment here"></asp:Label>

        <div class="rating">
            <asp:TextBox CssClass="hidden" ID="ratingTxt" runat="server" TextMode="Number" Name="rating" Text="5"></asp:TextBox>
            <i class='bx bxs-star star' style="--i: 0;"></i>
            <i class='bx bxs-star star' style="--i: 1;"></i>
            <i class='bx bxs-star star' style="--i: 2;"></i>
            <i class='bx bxs-star star' style="--i: 3;"></i>
            <i class='bx bxs-star star' style="--i: 4;"></i>
        </div>
        <asp:TextBox CssClass="textarea" ID="comment" runat="server" TextMode="MultiLine" placeholder="Type Something..."></asp:TextBox>

        <div class="btn-group">
            <asp:LinkButton CssClass="btn submit" ID="LinkButton1" runat="server" OnClientClick="return confirmSubmit()" OnClick="LinkButton1_Click">Submit</asp:LinkButton>
         
            <asp:Button CssClass="btn cancel" ID="Button2" runat="server" Text="Cancel" PostBackUrl="~/memberParticipateRecord.aspx"/>

        </div>

    </div>
    <script>
        const allStar = document.querySelectorAll('.rating .star')
        var ratingValue = document.getElementById("<%=ratingTxt.ClientID%>").value

        allStar.forEach((item, idx) => {
            item.addEventListener('click', function () {
                let click = 0
                ratingValue = idx + 1
                document.getElementById('<%=ratingTxt.ClientID%>').value = idx + 1
                allStar.forEach(i => {
                    i.classList.replace('bxs-star', 'bx-star')
                    i.classList.remove('active')
                })
                for (let i = 0; i < allStar.length; i++) {
                    if (i <= idx) {
                        allStar[i].classList.replace('bx-star', 'bxs-star')
                        allStar[i].classList.add('active')
                    } else {
                        allStar[i].style.setProperty('--i', click)
                        click++
                    }
                }
            })
        })

        
        function confirmSubmit() {
            if (document.getElementById('<%=comment.ClientID%>').value == "") {
                alert("Please Write Some Comment!");
                return false;
            }
                var x = confirm("Confirm To Submit?");
                if (x == true) {
                   
                    return x;
                }
            return x;

            }

    </script>
 
</asp:Content>
