package us.adogo.april.rpc;

import java.util.ArrayList;
import java.util.List;

public class DataSourceStub {

	public List<Status> getListOfAllStatuses(){
		Status status1 = new Status();
		status1.setName("Available");
		status1.setMessage("Send me a message, I'm online ....");
		status1.setCode(0);
		
		Status status2 = new Status();
		status2.setName("Away");
		status2.setMessage("I'm leaving....");
		status2.setCode(1);
		
		Status status3 = new Status();
		status3.setName("Busy");
		status3.setMessage("Don't think about bothering me....");
		status3.setCode(2);
		
		List<Status> statuses = new ArrayList<Status>();
		statuses.add(status1);
		statuses.add(status2);
		statuses.add(status3);
		
		return statuses;
	}
}
