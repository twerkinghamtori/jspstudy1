package sitemesh;
/*
 * sitemesh 기능 : 화면에 layout을 코딩한 jsp를 페이지에 적용해줌.
 * 
 * addDecoratorPath(URL, layout)
 *   url : /member/ 로 시작하는 모든 요청 url
 *   layout : 응답시 페이지 layout용으로 사용되는 jsp 페이지 설정.
 * 
 * addExcludedPath("/member/id*")
 *   url : /member/id 로 시작하는 모든 요청시 layout 제외*/
import javax.servlet.annotation.WebFilter;
import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

@WebFilter("/*") //모든 요청(/*)이 들어오면 이 필터를 실행한다.
public class SiteMeshFilter extends ConfigurableSiteMeshFilter {    
    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
    	builder.addDecoratorPath("/model1/*", "/layout/layout.jsp")
    	.addExcludedPath("/model1/member/id*")
    	.addExcludedPath("/model1/member/pw*")
    	.addExcludedPath("/model1/member/password*")
    	.addExcludedPath("/model1/member/picture*");
    }
} 


