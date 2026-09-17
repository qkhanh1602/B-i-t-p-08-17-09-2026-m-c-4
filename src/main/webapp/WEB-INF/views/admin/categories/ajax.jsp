<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<div class="card shadow-sm border-0">
    <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center py-3">
        <h4 class="card-title mb-0"><i class="fas fa-list me-2"></i>Quản Lý Danh Mục (Category) - AJAX RESTful API</h4>
        <button class="btn btn-success" onclick="showCreateNewCategoryModal()">
            <i class="fas fa-plus me-1"></i>Thêm Category Ajax
        </button>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-hover table-striped align-middle" id="categoryTable">
                <thead class="table-dark">
                    <tr>
                        <th style="width: 100px;">Id</th>
                        <th style="width: 120px;">Icon</th>
                        <th>Tên Danh Mục</th>
                        <th style="width: 150px;" class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody id="categoryTableBody">
                    <!-- Dữ liệu được nạp bằng AJAX -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- ========================= MODAL THÊM CATEGORY ========================= -->
<div class="modal fade" tabindex="-1" role="dialog" id="createCategoryModal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <form id="addCategory" method="post" onsubmit="return false;" enctype="multipart/form-data">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title"><i class="fas fa-plus-circle me-1"></i>Thêm Mới Category</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" data-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="new_categoryname" class="form-label fw-bold">Tên Danh Mục (Category Name)</label>
                        <input type="text" class="form-control" id="new_categoryname" name="categoryName" required placeholder="Nhập tên category...">
                    </div>
                    <div class="mb-3">
                        <label for="new_icon" class="form-label fw-bold">File Icon / Ảnh đại diện</label>
                        <input type="file" class="form-control" id="new_icon" name="icon" accept="image/*">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" data-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-success"><i class="fas fa-save me-1"></i>Thêm</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- ========================= MODAL CẬP NHẬT CATEGORY ========================= -->
<div class="modal fade" tabindex="-1" role="dialog" id="updateCategoryInfoModal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header bg-warning text-dark">
                <h5 class="modal-title"><i class="fas fa-edit me-1"></i>Cập Nhật Category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="card mb-3 bg-light border-0">
                    <div class="card-header bg-secondary text-white py-1">
                        <small><i class="far fa-address-card me-1"></i>Thông tin hiện tại</small>
                    </div>
                    <div class="card-body py-2">
                        <p class="mb-1" id="updateCategoryInfoModalId"><strong>ID:</strong> </p>
                        <p class="mb-1" id="updateCategoryInfoModalName"><strong>Tên:</strong> </p>
                        <p class="mb-0" id="updateCategoryInfoModalIcon"><strong>Icon:</strong> </p>
                    </div>
                </div>

                <form id="updateCategory" method="post" onsubmit="return false;" enctype="multipart/form-data">
                    <input type="hidden" id="categoryId_up" name="categoryId">
                    <div class="mb-3">
                        <label for="categoryName_up" class="form-label fw-bold">Tên Danh Mục Mới</label>
                        <input type="text" class="form-control" id="categoryName_up" name="categoryName" required>
                    </div>
                    <div class="mb-3">
                        <label for="icon_up" class="form-label fw-bold">Đổi Icon (để trống nếu giữ nguyên)</label>
                        <input type="file" class="form-control" id="icon_up" name="icon" accept="image/*">
                    </div>
                    <div class="text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" data-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-warning"><i class="fas fa-check me-1"></i>Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- ========================= JAVASCRIPT XỬ LÝ AJAX ========================= -->
<script type="text/javascript">
    // Hàm tải danh sách Category từ API
    function loadCategories() {
        $.getJSON(contextPath + '/api/category', function(res) {
            var data = res.body ? res.body : res;
            var tr = [];
            $('#categoryTableBody').empty();

            if (!data || data.length === 0) {
                $('#categoryTableBody').append('<tr><td colspan="4" class="text-center text-muted py-4">Chưa có danh mục nào. Hãy bấm "Thêm Category Ajax"!</td></tr>');
                return;
            }

            for (var i = 0; i < data.length; i++) {
                var item = data[i];
                var imgTag = item.icon ? 
                    '<img src="' + contextPath + '/admin/categories/images/' + item.icon + '" style="width:60px; height:60px; object-fit:cover;" class="rounded border" alt="icon">' : 
                    '<span class="badge bg-secondary">No icon</span>';

                var safeName = (item.categoryName || '').replace(/'/g, "\\'").replace(/"/g, '&quot;');
                var safeIcon = (item.icon || '').replace(/'/g, "\\'");

                tr.push('<tr>');
                tr.push('<td><span class="badge bg-primary">#' + item.categoryId + '</span></td>');
                tr.push('<td>' + imgTag + '</td>');
                tr.push('<td><strong>' + item.categoryName + '</strong></td>');
                tr.push('<td class="text-center">' +
                    '<button type="button" class="btn btn-outline-warning btn-sm me-2" title="Chỉnh sửa" ' +
                    'onclick="showEditCategoryModal(' + item.categoryId + ', \'' + safeName + '\', \'' + safeIcon + '\')">' +
                    '<i class="fa fa-edit"></i></button>' +
                    '<button type="button" data-id="' + item.categoryId + '" class="btn btn-outline-danger btn-sm btn-delete-cat" title="Xóa">' +
                    '<i class="fa fa-trash"></i></button>' +
                    '</td>');
                tr.push('</tr>');
            }
            $('#categoryTableBody').append(tr.join(''));
        }).fail(function(err) {
            console.error("Lỗi khi tải categories:", err);
            $('#categoryTableBody').html('<tr><td colspan="4" class="text-center text-danger py-4">Không thể tải dữ liệu từ API.</td></tr>');
        });
    }

    $(document).ready(function() {
        loadCategories();

        // 1. Thêm mới Category bằng Ajax
        $("form#addCategory").submit(function(e) {
            e.preventDefault();
            var formData = new FormData(this);
            $.ajax({
                url: contextPath + '/api/category/addCategory',
                type: 'POST',
                dataType: "json",
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    $('#createCategoryModal').modal('hide');
                    $('form#addCategory')[0].reset();
                    alert("Thêm danh mục thành công!");
                    loadCategories();
                },
                error: function(err) {
                    var msg = (err.responseJSON && err.responseJSON.message) ? err.responseJSON.message : "Thêm danh mục thất bại!";
                    alert("Lỗi: " + msg);
                }
            });
        });

        // 2. Cập nhật Category bằng Ajax
        $("form#updateCategory").submit(function(e) {
            e.preventDefault();
            var formData = new FormData(this);
            $.ajax({
                url: contextPath + '/api/category/updateCategory',
                type: 'PUT',
                dataType: "json",
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    $('#updateCategoryInfoModal').modal('hide');
                    alert("Cập nhật danh mục thành công!");
                    loadCategories();
                },
                error: function(err) {
                    var msg = (err.responseJSON && err.responseJSON.message) ? err.responseJSON.message : "Cập nhật danh mục thất bại!";
                    alert("Lỗi: " + msg);
                }
            });
        });

        // 3. Xóa Category bằng Ajax
        $(document).delegate('.btn-delete-cat', 'click', function() {
            var id = $(this).data('id');
            if (confirm('Bạn có chắc chắn muốn xóa danh mục ID: ' + id + '?')) {
                var row = $(this).closest('tr');
                $.ajax({
                    type: "DELETE",
                    url: contextPath + '/api/category/deleteCategory?categoryId=' + id,
                    dataType: "json",
                    success: function() {
                        row.fadeOut('slow', function() {
                            $(this).remove();
                        });
                        alert("Xóa thành công!");
                    },
                    error: function() {
                        alert("Xóa danh mục thất bại (có thể danh mục này đang chứa sản phẩm)!");
                    }
                });
            }
        });
    });

    // Mở Modal Thêm mới
    function showCreateNewCategoryModal() {
        $('#new_categoryname').val('');
        $('#new_icon').val('');
        $('#createCategoryModal').modal('show');
    }

    // Mở Modal Chỉnh sửa
    function showEditCategoryModal(categoryId, categoryName, icon) {
        $('#updateCategoryInfoModalId').html('<strong>ID:</strong> ' + categoryId);
        $('#updateCategoryInfoModalName').html('<strong>Tên:</strong> ' + categoryName);
        $('#updateCategoryInfoModalIcon').html('<strong>Icon:</strong> ' + (icon ? icon : 'Không có'));
        $('#categoryName_up').val(categoryName);
        $('#categoryId_up').val(categoryId);
        $('#icon_up').val('');
        $('#updateCategoryInfoModal').modal('show');
    }
</script>
