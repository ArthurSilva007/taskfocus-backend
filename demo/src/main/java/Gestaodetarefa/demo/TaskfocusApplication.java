package Gestaodetarefa.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EntityScan(basePackages = "Gestaodetarefa.demo")
@EnableJpaRepositories(basePackages = "Gestaodetarefa.demo")
public class TaskfocusApplication {

	public static void main(String[] args) {
		SpringApplication.run(TaskfocusApplication.class, args);
	}

}