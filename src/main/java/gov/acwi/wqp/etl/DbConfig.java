package gov.acwi.wqp.etl;

import javax.sql.DataSource;

import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.Profile;
import org.springframework.jdbc.core.JdbcTemplate;

@Configuration
public class DbConfig {

	@Bean
	@ConfigurationProperties(prefix="spring.datasource-wqp")
	@Primary
	@Profile("default")
	public DataSourceProperties dataSourceWqpProperties() {
		return new DataSourceProperties();
	}
	
	@Bean
	@Primary
	@Profile("default")
	public DataSource dataSourceWqp() {
		return dataSourceWqpProperties().initializeDataSourceBuilder().build();
	}
	
	@Bean
	@Primary
	public JdbcTemplate jdbcTemplateWqp() {
		return new JdbcTemplate(dataSourceWqp());
	}

	@Bean
	@ConfigurationProperties(prefix="spring.datasource-biodata")
	public DataSourceProperties biodataDataSourceProperties() {
		return new DataSourceProperties();
	}
	
	@Bean
	public DataSource biodataDataSource() {
		return biodataDataSourceProperties().initializeDataSourceBuilder().build();
	}
	
	@Bean
	public JdbcTemplate jdbcTemplateBiodata() {
		return new JdbcTemplate(biodataDataSource());
	}
}