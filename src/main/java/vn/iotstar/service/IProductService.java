package vn.iotstar.service;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import vn.iotstar.entity.Product;

public interface IProductService {
    List<Product> findAll();
    Page<Product> findAll(Pageable pageable);
    Optional<Product> findById(Long id);
    <S extends Product> S save(S entity);
    void deleteById(Long id);
    void delete(Product entity);
    Optional<Product> findByProductName(String name);
    Optional<Product> findByCreateDate(Date createAt);
    List<Product> findByProductNameContaining(String name);
    Page<Product> findByProductNameContaining(String name, Pageable pageable);
}
