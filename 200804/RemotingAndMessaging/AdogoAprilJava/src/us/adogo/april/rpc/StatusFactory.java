package us.adogo.april.rpc;

import java.util.List;

public class StatusFactory {

	private StatusDao dao;
	
	public StatusFactory(){
		this.dao = new StatusDao();
	}
	
	public List<Status> getAllInstances(){
		return this.dao.fetchAll();
	}
}
