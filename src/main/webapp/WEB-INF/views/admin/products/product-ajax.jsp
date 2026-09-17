<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<div class="card shadow-sm border-0">
    <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center py-3">
        <h4 class="card-title mb-0">
            <i class="fas fa-boxes me-2 text-warning"></i>Quản Lý Sản Phẩm (Product) - AJAX RESTful API
            <span class="badge bg-warning text-dark ms-2">Bài tập thêm</span>
        </h4>
        <button class="btn btn-success" onclick="showCreateNewProductModal()">
            <i class="fas fa-plus me-1"></i>Thêm Product Ajax
        </button>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-hover table-striped align-middle" id="productTable">
                <thead class="table-dark">
                    <tr>
                        <th style="width: 80px;">ID</th>
                        <th style="width: 100px;">Hình ảnh</th>
                        <th>Tên Sản Phẩm</th>
                        <th style="width: 120px;">Đơn giá</th>
                        <th style="width: 100px;">Giảm giá</th>
                        <th style="width: 100px;">Số lượng</th>
                        <th style="width: 150px;">Danh mục</th>
                        <th style="width: 120px;">Trạng thái</th>
                        <th style="width: 140px;" class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody id="productTableBody">
                    <!-- Dữ liệu được nạp bằng AJAX -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- ========================= MODAL THÊM PRODUCT ========================= -->
<div class="modal fade" tabindex="-1" role="dialog" id="createProductModal" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <form id="addProduct" method="post" onsubmit="return false;" enctype="multipart/form-data">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title"><i class="fas fa-plus-circle me-1"></i>Thêm Mới Sản Phẩm</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" data-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-8">
                            <label for="new_productName" class="form-label fw-bold">Tên Sản Phẩm</label>
                            <input type="text" class="form-control" id="new_productName" name="productName" required placeholder="Nhập tên sản phẩm...">
                        </div>
                        <div class="col-md-4">
                            <label for="new_categoryId" class="form-label fw-bold">Danh Mục</label>
                            <select class="form-select" id="new_categoryId" name="categoryId" required>
                                <option value="">-- Chọn danh mục --</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="new_unitPrice" class="form-label fw-bold">Đơn Giá (VNĐ)</label>
                            <input type="number" step="0.01" class="form-control" id="new_unitPrice" name="unitPrice" required value="100000">
                        </div>
                        <div class="col-md-4">
                            <label for="new_discount" class="form-label fw-bold">Giảm Giá (%)</label>
                            <input type="number" step="0.01" class="form-control" id="new_discount" name="discount" required value="0">
                        </div>
                        <div class="col-md-4">
                            <label for="new_quantity" class="form-label fw-bold">Số Lượng</label>
                            <input type="number" class="form-control" id="new_quantity" name="quantity" required value="10">
                        </div>
                        <div class="col-md-8">
                            <label for="new_imageFile" class="form-label fw-bold">File Hình Ảnh</label>
                            <input type="file" class="form-control" id="new_imageFile" name="imageFile" accept="image/*">
                        </div>
                        <div class="col-md-4">
                            <label for="new_status" class="form-label fw-bold">Trạng Thái</label>
                            <select class="form-select" id="new_status" name="status">
                                <option value="1">Đang bán</option>
                                <option value="0">Tạm dừng</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label for="new_description" class="form-label fw-bold">Mô Tả Sản Phẩm</label>
                            <textarea class="form-control" id="new_description" name="description" rows="3" required placeholder="Mô tả chi tiết sản phẩm..."></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" data-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-success"><i class="fas fa-save me-1"></i>Thêm Sản Phẩm</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- ========================= MODAL CẬP NHẬT PRODUCT ========================= -->
<div class="modal fade" tabindex="-1" role="dialog" id="updateProductModal" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <form id="updateProduct" method="post" onsubmit="return false;" enctype="multipart/form-data">
                <input type="hidden" id="update_productId" name="productId">
                <div class="modal-header bg-warning text-dark">
                    <h5 class="modal-title"><i class="fas fa-edit me-1"></i>Cập Nhật Sản Phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" data-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-8">
                            <label for="update_productName" class="form-label fw-bold">Tên Sản Phẩm</label>
                            <input type="text" class="form-control" id="update_productName" name="productName" required>
                        </div>
                        <div class="col-md-4">
                            <label for="update_categoryId" class="form-label fw-bold">Danh Mục</label>
                            <select class="form-select" id="update_categoryId" name="categoryId" required>
                                <option value="">-- Chọn danh mục --</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="update_unitPrice" class="form-label fw-bold">Đơn Giá</label>
                            <input type="number" step="0.01" class="form-control" id="update_unitPrice" name="unitPrice" required>
                        </div>
                        <div class="col-md-4">
                            <label for="update_discount" class="form-label fw-bold">Giảm Giá (%)</label>
                            <input type="number" step="0.01" class="form-control" id="update_discount" name="discount" required>
                        </div>
                        <div class="col-md-4">
                            <label for="update_quantity" class="form-label fw-bold">Số Lượng</label>
                            <input type="number" class="form-control" id="update_quantity" name="quantity" required>
                        </div>
                        <div class="col-md-8">
                            <label for="update_imageFile" class="form-label fw-bold">Thay Đổi Ảnh (để trống nếu giữ nguyên)</label>
                            <input type="file" class="form-control" id="update_imageFile" name="imageFile" accept="image/*">
                            <small class="text-muted" id="update_current_image_text"></small>
                        </div>
                        <div class="col-md-4">
                            <label for="update_status" class="form-label fw-bold">Trạng Thái</label>
                            <select class="form-select" id="update_status" name="status">
                                <option value="1">Đang bán</option>
                                <option value="0">Tạm dừng</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label for="update_description" class="form-label fw-bold">Mô Tả Sản Phẩm</label>
                            <textarea class="form-control" id="update_description" name="description" rows="3" required></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" data-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-warning"><i class="fas fa-check me-1"></i>Lưu Thay Đổi</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- ========================= JAVASCRIPT XỬ LÝ AJAX PRODUCT ========================= -->
<script type="text/javascript">
    var categoriesList = [];

    // Tải danh sách Categories để đưa vào Dropdown
    function loadCategoriesDropdown() {
        $.getJSON(contextPath + '/api/category', function(res) {
            categoriesList = res.body ? res.body : res;
            var opts = '<option value="">-- Chọn danh mục --</option>';
            for (var i = 0; i < categoriesList.length; i++) {
                opts += '<option value="' + categoriesList[i].categoryId + '">' + categoriesList[i].categoryName + '</option>';
            }
            $('#new_categoryId').html(opts);
            $('#update_categoryId').html(opts);
        });
    }

    // Tải danh sách Product từ API
    function loadProducts() {
        $.getJSON(contextPath + '/api/product', function(res) {
            var data = res.body ? res.body : res;
            var tr = [];
            $('#productTableBody').empty();

            if (!data || data.length === 0) {
                $('#productTableBody').append('<tr><td colspan="9" class="text-center text-muted py-4">Chưa có sản phẩm nào. Hãy bấm "Thêm Product Ajax"!</td></tr>');
                return;
            }

            for (var i = 0; i < data.length; i++) {
                var item = data[i];
                var imgTag = item.images ? 
                    '<img src="' + contextPath + '/admin/products/images/' + item.images + '" style="width:60px; height:60px; object-fit:cover;" class="rounded border" alt="img">' : 
                    '<span class="badge bg-secondary">No image</span>';

                var catName = item.category ? item.category.categoryName : 'Chưa phân loại';
                var statusBadge = item.status === 1 ? 
                    '<span class="badge bg-success">Đang bán</span>' : 
                    '<span class="badge bg-danger">Tạm dừng</span>';

                tr.push('<tr>');
                tr.push('<td><span class="badge bg-dark">#' + item.productId + '</span></td>');
                tr.push('<td>' + imgTag + '</td>');
                tr.push('<td><strong>' + item.productName + '</strong></td>');
                tr.push('<td>' + Number(item.unitPrice).toLocaleString('vi-VN') + ' đ</td>');
                tr.push('<td>' + item.discount + '%</td>');
                tr.push('<td>' + item.quantity + '</td>');
                tr.push('<td><span class="badge bg-info text-dark">' + catName + '</span></td>');
                tr.push('<td>' + statusBadge + '</td>');
                tr.push('<td class="text-center">' +
                    '<button type="button" class="btn btn-outline-warning btn-sm me-2" title="Chỉnh sửa" onclick="showEditProductModal(' + item.productId + ')">' +
                    '<i class="fa fa-edit"></i></button>' +
                    '<button type="button" data-id="' + item.productId + '" class="btn btn-outline-danger btn-sm btn-delete-prod" title="Xóa">' +
                    '<i class="fa fa-trash"></i></button>' +
                    '</td>');
                tr.push('</tr>');
            }
            $('#productTableBody').append(tr.join(''));
        }).fail(function(err) {
            console.error("Lỗi khi tải products:", err);
            $('#productTableBody').html('<tr><td colspan="9" class="text-center text-danger py-4">Không thể tải danh sách sản phẩm.</td></tr>');
        });
    }

    $(document).ready(function() {
        loadCategoriesDropdown();
        loadProducts();

        // Thêm sản phẩm qua Ajax
        $("form#addProduct").submit(function(e) {
            e.preventDefault();
            var formData = new FormData(this);
            $.ajax({
                url: contextPath + '/api/product/addProduct',
                type: 'POST',
                dataType: "json",
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function(data) {
                    $('#createProductModal').modal('hide');
                    $('form#addProduct')[0].reset();
                    alert("Thêm sản phẩm thành công!");
                    loadProducts();
                },
                error: function(err) {
                    var msg = (err.responseJSON && err.responseJSON.message) ? err.responseJSON.message : "Thêm sản phẩm thất bại!";
                    alert("Lỗi: " + msg);
                }
            });
        });

        // Cập nhật sản phẩm qua Ajax
        $("form#updateProduct").submit(function(e) {
            e.preventDefault();
            var formData = new FormData(this);
            $.ajax({
                url: contextPath + '/api/product/updateProduct',
                type: 'PUT',
                dataType: "json",
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function(data) {
                    $('#updateProductModal').modal('hide');
                    alert("Cập nhật sản phẩm thành công!");
                    loadProducts();
                },
                error: function(err) {
                    var msg = (err.responseJSON && err.responseJSON.message) ? err.responseJSON.message : "Cập nhật sản phẩm thất bại!";
                    alert("Lỗi: " + msg);
                }
            });
        });

        // Xóa sản phẩm qua Ajax
        $(document).delegate('.btn-delete-prod', 'click', function() {
            var id = $(this).data('id');
            if (confirm('Bạn có chắc chắn muốn xóa sản phẩm ID: ' + id + '?')) {
                var row = $(this).closest('tr');
                $.ajax({
                    type: "DELETE",
                    url: contextPath + '/api/product/deleteProduct?productId=' + id,
                    dataType: "json",
                    success: function() {
                        row.fadeOut('slow', function() {
                            $(this).remove();
                        });
                        alert("Xóa sản phẩm thành công!");
                    },
                    error: function() {
                        alert("Xóa sản phẩm thất bại!");
                    }
                });
            }
        });
    });

    function showCreateNewProductModal() {
        loadCategoriesDropdown();
        $('form#addProduct')[0].reset();
        $('#createProductModal').modal('show');
    }

    function showEditProductModal(productId) {
        loadCategoriesDropdown();
        $.getJSON(contextPath + '/api/product/' + productId, function(res) {
            var item = res.body ? res.body : res;
            $('#update_productId').val(item.productId);
            $('#update_productName').val(item.productName);
            $('#update_unitPrice').val(item.unitPrice);
            $('#update_discount').val(item.discount);
            $('#update_quantity').val(item.quantity);
            $('#update_description').val(item.description);
            $('#update_status').val(item.status);
            if (item.category) {
                $('#update_categoryId').val(item.category.categoryId);
            }
            $('#update_current_image_text').text(item.images ? 'Ảnh hiện tại: ' + item.images : 'Chưa có ảnh');
            $('#update_imageFile').val('');
            $('#updateProductModal').modal('show');
        }).fail(function() {
            alert("Không lấy được dữ liệu sản phẩm!");
        });
    }
</script>
