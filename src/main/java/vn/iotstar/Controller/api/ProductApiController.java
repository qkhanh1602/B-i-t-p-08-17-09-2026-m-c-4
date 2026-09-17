package vn.iotstar.Controller.api;

import java.sql.Timestamp;
import java.util.Date;
import java.util.Optional;
import java.util.UUID;
import org.springframework.beans.BeanUtils;
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
import vn.iotstar.entity.Product;
import vn.iotstar.model.ProductModel;
import vn.iotstar.model.Response;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.IStorageService;

@RestController
@RequestMapping(path = "/api/product")
@Tag(name = "Product API", description = "Các API thao tác CRUD trên Product")
public class ProductApiController {

    @Autowired
    private IProductService productService;

    @Autowired
    private ICategoryService categoryService;

    @Autowired
    private IStorageService storageService;

    @GetMapping
    @Operation(summary = "Lấy danh sách tất cả sản phẩm")
    public ResponseEntity<?> getAllProduct() {
        return new ResponseEntity<Response>(
                new Response(true, "Thành công", productService.findAll()),
                HttpStatus.OK);
    }

    @PostMapping(path = "/getProduct")
    @Operation(summary = "Lấy chi tiết sản phẩm theo ID")
    public ResponseEntity<?> getProduct(@Validated @RequestParam("id") Long id) {
        Optional<Product> opt = productService.findById(id);
        if (opt.isPresent()) {
            return new ResponseEntity<Response>(
                    new Response(true, "Thành công", opt.get()),
                    HttpStatus.OK);
        } else {
            return new ResponseEntity<Response>(
                    new Response(false, "Không tìm thấy sản phẩm", null),
                    HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping(path = "/{id}")
    @Operation(summary = "Lấy chi tiết sản phẩm theo ID qua URL path")
    public ResponseEntity<?> getProductById(@PathVariable("id") Long id) {
        Optional<Product> opt = productService.findById(id);
        if (opt.isPresent()) {
            return new ResponseEntity<Response>(
                    new Response(true, "Thành công", opt.get()),
                    HttpStatus.OK);
        } else {
            return new ResponseEntity<Response>(
                    new Response(false, "Không tìm thấy sản phẩm", null),
                    HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping(path = "/addProduct", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @Operation(summary = "Thêm sản phẩm mới kèm tải lên file ảnh")
    public ResponseEntity<?> saveOrUpdate(
            @Validated @RequestParam("productName") String productName,
            @RequestParam(value = "imageFile", required = false) MultipartFile productImages,
            @Validated @RequestParam("unitPrice") Double productPrice,
            @Validated @RequestParam("discount") Double promotionalPrice,
            @Validated @RequestParam("description") String productDescription,
            @Validated @RequestParam("categoryId") Long categoryId,
            @Validated @RequestParam("quantity") Integer quantity,
            @Validated @RequestParam("status") Short status) {

        Optional<Product> optProduct = productService.findByProductName(productName);
        if (optProduct.isPresent()) {
            return new ResponseEntity<Response>(
                    new Response(false, "Sản phẩm này đã tồn tại trong hệ thống", optProduct.get()),
                    HttpStatus.BAD_REQUEST);
        } else {
            Product product = new Product();
            Timestamp timestamp = new Timestamp(new Date(System.currentTimeMillis()).getTime());
            try {
                ProductModel proModel = new ProductModel();
                proModel.setProductName(productName);
                proModel.setUnitPrice(productPrice);
                proModel.setDiscount(promotionalPrice);
                proModel.setDescription(productDescription);
                proModel.setCategoryId(categoryId);
                proModel.setQuantity(quantity);
                proModel.setStatus(status);
                proModel.setImageFile(productImages);

                BeanUtils.copyProperties(proModel, product);

                // Gán category liên quan
                Optional<Category> optCat = categoryService.findById(categoryId);
                if (optCat.isPresent()) {
                    product.setCategory(optCat.get());
                } else {
                    Category cateEntity = new Category();
                    cateEntity.setCategoryId(categoryId);
                    product.setCategory(cateEntity);
                }

                // Lưu ảnh nếu có
                if (productImages != null && !productImages.isEmpty()) {
                    UUID uuid = UUID.randomUUID();
                    String uuString = uuid.toString();
                    product.setImages(storageService.getSorageFilename(productImages, uuString));
                    storageService.store(productImages, product.getImages());
                }

                product.setCreateDate(timestamp);
                productService.save(product);
                optProduct = productService.findByCreateDate(timestamp);
            } catch (Exception e) {
                e.printStackTrace();
                return new ResponseEntity<Response>(
                        new Response(false, "Lỗi khi lưu sản phẩm: " + e.getMessage(), null),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            return new ResponseEntity<Response>(
                    new Response(true, "Thêm sản phẩm thành công", optProduct.orElse(product)),
                    HttpStatus.OK);
        }
    }

    @PutMapping(path = "/updateProduct", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @Operation(summary = "Cập nhật sản phẩm kèm tải lên file ảnh")
    public ResponseEntity<?> updateProduct(
            @Validated @RequestParam("productId") Long productId,
            @Validated @RequestParam("productName") String productName,
            @RequestParam(value = "imageFile", required = false) MultipartFile productImages,
            @Validated @RequestParam("unitPrice") Double productPrice,
            @Validated @RequestParam("discount") Double promotionalPrice,
            @Validated @RequestParam("description") String productDescription,
            @Validated @RequestParam("categoryId") Long categoryId,
            @Validated @RequestParam("quantity") Integer quantity,
            @Validated @RequestParam("status") Short status) {

        Optional<Product> optProduct = productService.findById(productId);
        if (optProduct.isEmpty()) {
            return new ResponseEntity<Response>(
                    new Response(false, "Không tìm thấy sản phẩm cần cập nhật", null),
                    HttpStatus.BAD_REQUEST);
        }

        Product product = optProduct.get();
        try {
            product.setProductName(productName);
            product.setUnitPrice(productPrice);
            product.setDiscount(promotionalPrice);
            product.setDescription(productDescription);
            product.setQuantity(quantity);
            product.setStatus(status);

            Optional<Category> optCat = categoryService.findById(categoryId);
            if (optCat.isPresent()) {
                product.setCategory(optCat.get());
            }

            if (productImages != null && !productImages.isEmpty()) {
                UUID uuid = UUID.randomUUID();
                String uuString = uuid.toString();
                product.setImages(storageService.getSorageFilename(productImages, uuString));
                storageService.store(productImages, product.getImages());
            }

            productService.save(product);
            return new ResponseEntity<Response>(
                    new Response(true, "Cập nhật sản phẩm thành công", product),
                    HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<Response>(
                    new Response(false, "Lỗi khi cập nhật sản phẩm: " + e.getMessage(), null),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @DeleteMapping(path = "/deleteProduct")
    @Operation(summary = "Xóa sản phẩm theo ID")
    public ResponseEntity<?> deleteProduct(@Validated @RequestParam("productId") Long productId) {
        Optional<Product> opt = productService.findById(productId);
        if (opt.isEmpty()) {
            return new ResponseEntity<Response>(
                    new Response(false, "Không tìm thấy sản phẩm để xóa", null),
                    HttpStatus.BAD_REQUEST);
        }
        productService.delete(opt.get());
        return new ResponseEntity<Response>(
                new Response(true, "Xóa sản phẩm thành công", opt.get()),
                HttpStatus.OK);
    }
}
