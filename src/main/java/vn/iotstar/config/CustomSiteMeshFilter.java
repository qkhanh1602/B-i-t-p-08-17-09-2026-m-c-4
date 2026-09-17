package vn.iotstar.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class CustomSiteMeshFilter extends ConfigurableSiteMeshFilter {
    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        // Map decorators to specific path patterns (đặt /admin/* trước /* để ưu tiên decorator admin)
        builder.addDecoratorPath("/admin/*", "admin.jsp")
               .addDecoratorPath("/admin/*", "/admin.jsp")
               .addDecoratorPath("/*", "web.jsp")
               .addDecoratorPath("/*", "/web.jsp")
               // Exclude paths
               .addExcludedPath("/login*").addExcludedPath("/login/*")
               .addExcludedPath("/alogin*").addExcludedPath("/alogin/*")
               .addExcludedPath("/api/**")
               .addExcludedPath("/swagger-ui*").addExcludedPath("/swagger-ui/**")
               .addExcludedPath("/v3/api-docs*").addExcludedPath("/v3/api-docs/**")
               .addExcludedPath("/admin/categories/images/**")
               .addExcludedPath("/admin/products/images/**")
               .addExcludedPath("/h2-console/**")
               .addExcludedPath("/static/**");
    }
}
