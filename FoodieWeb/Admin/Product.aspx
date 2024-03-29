﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="FoodieWeb.Admin.Product" %>
<%@ Import Namespace="FoodieWeb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>

        //Disappearing alert masage
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
                    $('#<%= imgProduct.ClientID%>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                render.readAsDataURL(input.files[0]);
            }
        }
    </script>

        
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="pcoded-inner-content pt-0">
        <div class="align-align-self-end">
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        </div>
        <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header">
                                </div>
                                <div class="card-block">
                                    <div class="row">

                                        <div class="col-sm-6 col-md-4 col-lg-3">
                                            <h4 class="sub-title">Sản phẩm</h4>
                                            <div>
                                                <div class="form-group">
                                                    <label>Tên</label>
                                                    <div>
                                                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control"
                                                            placeholder="Vui lòng nhập tên sản phẩm"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                                            ErrorMessage="Tên bắt buộc" ForeColor="Red" Display="Dynamic"
                                                            SetFocusOnError="true" ControlToValidate="txtName" >
                                                        </asp:RequiredFieldValidator>
                                                        <asp:HiddenField ID="hdnId" runat="server" Value="0" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Mô tả</label>
                                                    <div>
                                                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control"
                                                            placeholder="Vui lòng nhập mô tả" textMode="MultiLine"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                                            ErrorMessage="Phần mô tả bắt buộc" ForeColor="Red" Display="Dynamic"
                                                            SetFocusOnError="true" ControlToValidate="txtDescription" >
                                                        </asp:RequiredFieldValidator>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Giá bán</label>
                                                    <div>
                                                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control"
                                                            placeholder="Vui lòng nhập giá bán" ></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                                            ErrorMessage="Phần giá bán bắt buộc" ForeColor="Red" Display="Dynamic"
                                                            SetFocusOnError="true" ControlToValidate="txtPrice" >
                                                        </asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                                            ErrorMessage="RegularExpressionValidator" ForeColor="Red" Display="Dynamic"
                                                            SetFocusOnError="true" ControlToValidate="txtPrice"
                                                            ValidationExpression="^\d{0,8}(\.\d{1,4})?$" ></asp:RegularExpressionValidator>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Số lượng</label>
                                                    <div>
                                                        <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control"
                                                            placeholder="Vui lòng nhập số lượng" ></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                                            ErrorMessage="Phần giá bán bắt buộc" ForeColor="Red" Display="Dynamic"
                                                            SetFocusOnError="true" ControlToValidate="txtQuantity" >
                                                        </asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                                                            ErrorMessage="RegularExpressionValidator" ForeColor="Red" Display="Dynamic"
                                                            SetFocusOnError="true" ControlToValidate="txtQuantity"
                                                            ValidationExpression="^([1-9]\d*|0)$" ></asp:RegularExpressionValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Hình ảnh</label>
                                                    <div>
                                                        <asp:FileUpload ID="fuProductImage" runat="server" CssClass="form-control"
                                                            onchange="ImagePreview(this);"></asp:FileUpload>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Thể loại sản phẩm</label>
                                                    <div>
                                                        <asp:DropDownList ID="ddlCategories" runat="server" CssClass="form-control" 
                                                            DataSourceID="SqlDataSource1" DataTextField="CategoryName" DataValueField="CategoryID" 
                                                            OnSelectedIndexChanged="ddlCategories_SelectedIndexChanged"
                                                            AppendDataBoundItems="true">
                                                            <asp:ListItem Value="0" >Lựa chọn thể loại</asp:ListItem>
                                                        </asp:DropDownList>    
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                                            ErrorMessage="Phần thể loại bắt buộc" ForeColor="Red" Display="Dynamic"
                                                            SetFocusOnError="true" ControlToValidate="ddlCategories" InitialValue="0" >
                                                        </asp:RequiredFieldValidator>
                                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:con %>" SelectCommand="SELECT [CategoryID], [CategoryName] FROM [CATEGORY]"></asp:SqlDataSource>
                                                    </div>
                                                </div>

                                                <div class="form-check pl-4">
                                                    <asp:CheckBox ID="cbIsActive" runat="server" Text="&nbsp; Khả dụng"
                                                        CssClass="form-check-input" />
                                                </div>

                                                <div class="pb-5">
                                                    <asp:Button ID="btnAddOrUpdate" runat="server" Text="Thêm" CssClass="btn btn-primary"
                                                       onClick="btnAddOrUpdate_Click" />
                                                    &nbsp;
                                                    <asp:Button ID="btnClear" runat="server" Text="Xóa" CssClass="btn btn-primary" 
                                                        CausesValidation="false" OnClick="btnClear_Click" />
                                                </div>
                                            </div>
                                            <asp:Image ID="imgProduct" runat="server" CssClass="img-thumbnail" />
                                        </div>

                                        <div class="col-sm-6 col-md-8 col-lg-9 mobile-inputs">
                                            <h4 class="sub-title">Danh sách sản phẩm</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">
                                                    <asp:Repeater ID="rProduct" runat="server" OnItemCommand="rProduct_ItemCommand"
                                                        OnItemDataBound="rProduct_ItemDataBound" >
                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">Tên</th>
                                                                        <th>Hình ảnh</th>
                                                                        <th>Giá bán</th>
                                                                        <th>Số lượng</th>
                                                                        <th>Thể loại</th>                                                                        
                                                                        <th>Trạng thái</th>
                                                                        <th>Mô tả</th>
                                                                        <th>Ngày tạo</th>
                                                                        <th class="datatable-nosort">Hành động</th>
                                                                    </tr>
                                                                </thead>                                                              
                                                        <tbody>   
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td> <%# Eval("ProductName") %></td>
                                                                <td> 
                                                                    <img alt="" width="40px" src="<%# Utils.GetImgUrl( Eval("ImgUrl")) %>" />
                                                                </td>
                                                                <td> <%# Eval("Price") %></td>
                                                                <td>
                                                                    <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                                                                </td>
                                                                <td> <%# Eval("CategoryName") %></td>
                                                                <td>
                                                                    <asp:Label ID="lblIsActive" runat="server" Text='<%# Eval("IsActive") %>'></asp:Label>
                                                                </td>
                                                                <td> <%# Eval("ProductDescription") %></td>
                                                                <td> <%# Eval("CreatedDate") %></td>
                                                                <td>
                                                                    <asp:LinkButton ID="lnkEdit" Text="Sửa" runat="server"
                                                                        CssClass="badge badge-primary"
                                                                        CommandArgument='<%# Eval("ProductID") %>' CommandName="Edit" CausesValidation="false">
                                                                        <i class="ti-pencil"></i>
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkDelete" Text="Xóa" runat="server"
                                                                        CssClass="badge badge-danger"
                                                                        CommandArgument='<%# Eval("ProductID") %>' CommandName="Delete"
                                                                        OnClientClick="return confirm('Bạn xác nhận xóa sản phẩm này?');">
                                                                        <i class="ti-trash"></i>
                                                                    </asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </tbody>
                                                            </table>
                                                        </FooterTemplate>
                                                        
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>


        
</asp:Content>
