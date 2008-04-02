package test.us.adogo.april.rpc;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Before;
import org.junit.Test;

import us.adogo.april.rpc.Status;
import us.adogo.april.rpc.StatusService;

public class StatusServiceTest {

	private StatusService service;
	
	@Before
	public void setUp() throws Exception {
		this.service = new StatusService();
	}

	@Test
	public void testListAllStatuses() {
		List<Status> statuses = this.service.getAllStatuses();
		
		assertTrue(statuses.size() > 0);
		assertTrue(statuses.size() == 3);
	}

}
