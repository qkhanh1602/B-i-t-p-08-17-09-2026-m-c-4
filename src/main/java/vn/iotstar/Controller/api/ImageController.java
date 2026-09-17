package vn.iotstar.Controller.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import vn.iotstar.service.IStorageService;

@RestController
@Tag(name = "Image Controller", description = "API phục vụ hiển thị hình ảnh Category và Product")
public class ImageController {

    @Autowired
    private IStorageService storageService;

    @GetMapping("/admin/categories/images/{filename:.+}")
    @ResponseBody
    @Operation(summary = "Xem ảnh category")
    public ResponseEntity<Resource> serveCategoryFile(@PathVariable String filename) {
        Resource file = storageService.loadAsResource(filename);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + file.getFilename() + "\"")
                .header(HttpHeaders.CONTENT_TYPE, MediaType.IMAGE_JPEG_VALUE)
                .body(file);
    }

    @GetMapping("/admin/products/images/{filename:.+}")
    @ResponseBody
    @Operation(summary = "Xem ảnh product")
    public ResponseEntity<Resource> serveProductFile(@PathVariable String filename) {
        Resource file = storageService.loadAsResource(filename);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + file.getFilename() + "\"")
                .header(HttpHeaders.CONTENT_TYPE, MediaType.IMAGE_JPEG_VALUE)
                .body(file);
    }
}
