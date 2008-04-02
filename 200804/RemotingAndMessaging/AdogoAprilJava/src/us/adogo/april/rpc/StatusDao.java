package us.adogo.april.rpc;

import java.util.List;

public class StatusDao {

	private DataSourceStub datasource;
	
	public StatusDao(){
		this.datasource = new DataSourceStub();
	}
	
	public List<Status> fetchAll(){
		return this.datasource.getListOfAllStatuses();
	}
}
