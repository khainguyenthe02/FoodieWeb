<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="FoodieWeb.User.Registration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>

        //Disappearing alert massage
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID%>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
    <script>
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                render.onload = function (e) {
                    $('#<%= imgUser.ClientID%>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                render.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                </div>
                <asp:Label ID="lblHeaderMsg" runat="server" Text="<h2>Đăng ký tài khoản</h2>"></asp:Label>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">

                        <div>
                            <asp:RequiredFieldValidator ID="sfvName" runat="server" ErrorMessage="Nhập tên bắt buộc" ControlTovalidate="txtName"
                               ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revName" runat="server" ForeColor="Red" ErrorMessage="Tên chỉ chứa kí tự chữ"
                               ControlToValidate="txtName" ValidationExpression="^[\sa-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ]+$" ></asp:RegularExpressionValidator>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Nhập tên của bạn" ToolTip="Full Name" ></asp:TextBox>
                        </div>

                        <div>   
                            <asp:RequiredFieldValidator ID="srvUsername" runat="server" ErrorMessage="Nhập tên tài khoản bắt buộc" ControlTovalidate="txtName"
                               ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" placeholder="Nhập tài khoản của bạn" ToolTip="Username" ></asp:TextBox>
                        </div>
                         <div>
                            <asp:RequiredFieldValidator ID="sfvPassword" runat="server" ErrorMessage="Nhập mật khẩu bắt buộc" ControlTovalidate="txtPassword"
                               ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ></asp:RequiredFieldValidator>   
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Nhập mật khẩu của bạn" ToolTip="Địa chỉ"
                               TextMode="Password" ></asp:TextBox>                           
                        </div>
                        <div>
                           
                            <asp:RequiredFieldValidator ID="srvEmail" runat="server" ErrorMessage="Nhập Email bắt buộc" ControlTovalidate="txtEmail"
                               ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ></asp:RequiredFieldValidator>
                             <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" placeholder="Nhập email của bạn" ToolTip="Email" ></asp:TextBox>
                        </div>                        
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form_container">
                         <div>                            
                            <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ErrorMessage="Nhập sdt bắt buộc" ControlTovalidate="txtMobile"
                               ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revMobile" runat="server" ErrorMessage="Số điện thoại chỉ chứa 10 số"
                               ControlToValidate="txtMobile" ValidationExpression="[0-9]{10}$" ></asp:RegularExpressionValidator>
                             <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Nhập sdt của bạn" ToolTip="Số điện thoại" ></asp:TextBox>
                        </div>
                        <div>
                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Nhập địa chỉ bắt buộc" ControlTovalidate="txtAddress"
                               ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ></asp:RequiredFieldValidator>   
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Nhập địa chỉ của bạn" ToolTip="Địa chỉ"
                               TextMode="MultiLine" ></asp:TextBox>
                        </div>
                        <div>
                           <asp:FileUpload ID="fuUserImage" runat="server" CssClass="form-control" ToolTip="Ảnh người dùng" onchange="ImagePreview(this);" /> 
                        </div>
                    </div>
                </div>

                <div class="row pl-4">
                    <div class="btn-box">
                        <asp:Button ID="btnRegister" runat="server" Text="Đăng ký"
                            OnClick="btnRegister_Click" CssClass="btn btn-success rounded-pill pl-4 pr-4 text-white" />

                        <asp:Label ID="lblAlreadyUser" runat="server" CssClass="pl-3 text-black-100"
                            Text="Bạn đã có tài khoản? <a href='Login.aspx' class='badge badge-info'>Đăng nhập ngay</a>">
                        </asp:Label>
                    </div>
                </div>

                <div class="row p-5">
                    <div style="align-items:center">
                        <asp:Image ID="imgUser" runat="server" CssClass="img-thumbnail" />
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
