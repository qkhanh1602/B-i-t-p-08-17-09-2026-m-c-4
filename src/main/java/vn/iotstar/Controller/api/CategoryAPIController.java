package vn.iotstar.Controller.api;

import java.util.Optional;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import vn.iotstar.entity.Category;
import vn.iotstar.model.Response;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IStorageService;

@RestController
@RequestMapping(path = "/api/category")
@Tag(name = "Category API", description = "Các API thao tác CRUD trên Category")
public class CategoryAPIController {

    @Autowired
    private ICategoryService categoryService;

    @Autowired
    private IStorageService storageService;

    @GetMapping
    @Operation(summary = "Lấy danh sách tất cả category")
    public ResponseEntity<?> getAllCategory() {
        return new ResponseEntity<Response>(
                new Response(true, "Thành công", categoryService.findAll()),
                HttpStatus.OK);
    }

    @PostMapping(path = "/getCategory")
    @Operation(summary = "Lấy category theo ID bằng POST param")
    public ResponseEntity<?> getCategory(@Validated @RequestParam("id") Long id) {
        Optional<Category> category = categoryService.findById(id);
        if (category.isPresent()) {
            return new ResponseEntity<Response>(
                    new Response(true, "Thành công", category.get()),
                    HttpStatus.OK);
        } else {
            return new ResponseEntity<Response>(
                    new Response(false, "Thất bại", null),
                    HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping(path = "/{id}")
    @Operation(summary = "Lấy category theo ID bằng PathVariable")
    public ResponseEntity<?> getCategoryById(@PathVariable("id") Long id) {
        Optional<Category> category = categoryService.findById(id);
        if (category.isPresent()) {
            return new ResponseEntity<Response>(
                    new Response(true, "Thành công", category.get()),
                    HttpStatus.OK);
        } else {
            return new ResponseEntity<Response>(
                    new Response(false, "Thất bại", null),
                    HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping(path = "/addCategory", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @Operation(summary = "Thêm mới category kèm file ảnh icon")
    public ResponseEntity<?> addCategory(
            @Validated @RequestParam("categoryName") String categoryName,
            @RequestParam(value = "icon", required = false) MultipartFile icon) {
        Optional<Category> optCategory = categoryService.findByCategoryName(categoryName);
        if (optCategory.isPresent()) {
            return new ResponseEntity<Response>(
                    new Response(false, "Category đã tồn tại trong hệ thống", null),
                    HttpStatus.BAD_REQUEST);
        } else {
            Category category = new Category();
            if (icon != null && !icon.isEmpty()) {
                UUID uuid = UUID.randomUUID();
                String uuString = uuid.toString();
                category.setIcon(storageService.getSorageFilename(icon, uuString));
                storageService.store(icon, category.getIcon());
            }
            category.setCategoryName(categoryName);
            categoryService.save(category);
            return new ResponseEntity<Response>(
                    new Response(true, "Thêm Thành công", category),
                    HttpStatus.OK);
        }
    }

    @PutMapping(path = "/updateCategory", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @Operation(summary = "Cập nhật category kèm file ảnh icon")
    public ResponseEntity<?> updateCategory(
            @Validated @RequestParam("categoryId") Long categoryId,
            @Validated @RequestParam("categoryName") String categoryName,
            @RequestParam(value = "icon", required = false) MultipartFile icon) {
        Optional<Category> optCategory = categoryService.findById(categoryId);
        if (optCategory.isEmpty()) {
            return new ResponseEntity<Response>(
                    new Response(false, "Không tìm thấy Category", null),
                    HttpStatus.BAD_REQUEST);
        } else {
            Category category = optCategory.get();
            if (icon != null && !icon.isEmpty()) {
                UUID uuid = UUID.randomUUID();
                String uuString = uuid.toString();
                category.setIcon(storageService.getSorageFilename(icon, uuString));
                storageService.store(icon, category.getIcon());
            }
            category.setCategoryName(categoryName);
            categoryService.save(category);
            return new ResponseEntity<Response>(
                    new Response(true, "Cập nhật Thành công", category),
                    HttpStatus.OK);
        }
    }

    @DeleteMapping(path = "/deleteCategory")
    @Operation(summary = "Xóa category theo ID")
    public ResponseEntity<?> deleteCategory(@Validated @RequestParam("categoryId") Long categoryId) {
        Optional<Category> optCategory = categoryService.findById(categoryId);
        if (optCategory.isEmpty()) {
            return new ResponseEntity<Response>(
                    new Response(false, "Không tìm thấy Category", null),
                    HttpStatus.BAD_REQUEST);
        } else {
            categoryService.delete(optCategory.get());
            return new ResponseEntity<Response>(
                    new Response(true, "Xóa Thành công", optCategory.get()),
                    HttpStatus.OK);
        }
    }
}
