package gov.acwi.wqp.etl.extract;

import org.springframework.batch.core.job.builder.FlowBuilder;
import org.springframework.batch.core.job.flow.Flow;
import org.springframework.batch.core.job.flow.support.SimpleFlow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ArsExtract {

	@Autowired
	@Qualifier("arsOrganizationPullFlow")
	private Flow arsOrganizationPullFlow;

	@Autowired
	@Qualifier("arsStationPullFlow")
	private Flow arsStationPullFlow;

	@Autowired
	@Qualifier("arsResultPullFlow")
	private Flow arsResultPullFlow;

	@Bean
	public Flow arsExtractFlow() {
		return new FlowBuilder<SimpleFlow>("arsExtractFlow")
				.start(arsOrganizationPullFlow)
				.next(arsStationPullFlow)
				.next(arsResultPullFlow)
				.build();
	}

}
