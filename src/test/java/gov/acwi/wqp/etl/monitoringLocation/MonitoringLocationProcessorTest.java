package gov.acwi.wqp.etl.monitoringLocation;

import gov.acwi.wqp.etl.biodata.domain.BiodataMonitoringLocation;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

public class MonitoringLocationProcessorTest {
	
	public MonitoringLocationProcessorTest() {
	}
	
	@BeforeClass
	public static void setUpClass() {
	}
	
	@AfterClass
	public static void tearDownClass() {
	}
	
	@Before
	public void setUp() {
	}
	
	@After
	public void tearDown() {
	}

	/**
	 * Test of process method, of class MonitoringLocationProcessor.
	 */
	@Test
	public void testProcess() throws Exception {
		System.out.println("process");
		BiodataMonitoringLocation biodataML = null;
		MonitoringLocationProcessor instance = new MonitoringLocationProcessor();
		MonitoringLocation expResult = null;
		MonitoringLocation result = instance.process(biodataML);
		assertEquals(expResult, result);
		// TODO review the generated test code and remove the default call to fail.
		fail("The test case is a prototype.");
	}
	
}
