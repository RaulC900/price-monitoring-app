package raul.project.priceupdater.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import raul.project.priceupdater.models.Product;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProductsRepository extends JpaRepository<Product, Integer> {

    Optional<Product> findByName(String name);
    @Query(value = "SELECT * FROM product p WHERE p.productTypeId = (SELECT id FROM product_type pt WHERE pt.name = :productType)",
            nativeQuery = true)
    Optional<List<Product>> findByProductType(@Param("productType") String productType);
}
