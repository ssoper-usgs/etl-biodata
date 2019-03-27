package gov.acwi.wqp.etl.biodata.domain;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "ResultLabInformation")
public class WqxResultLabInformation {
	private WqxResultDetectionQuantitationLimit resultDetectionQuantitationLimit;

	public WqxResultDetectionQuantitationLimit getResultDetectionQuantitationLimit() {
		return resultDetectionQuantitationLimit;
	}
	@XmlElement(name = "ResultDetectionQuantitationLimit")
	public void setResultDetectionQuantitationLimit(WqxResultDetectionQuantitationLimit resultDetectionQuantitationLimit) {
		this.resultDetectionQuantitationLimit = resultDetectionQuantitationLimit;
	}
}
