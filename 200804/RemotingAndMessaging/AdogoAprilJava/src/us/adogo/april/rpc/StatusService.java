package us.adogo.april.rpc;

import java.util.List;

public class StatusService {

	private StatusFactory factory;
	
	public StatusService(){
		this.factory = new StatusFactory();
	}
	
	public List<Status> getAllStatuses(){
		return this.factory.getAllInstances();
	}
}
