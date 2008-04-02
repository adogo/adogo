package us.adogo.april.nvc
{
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import us.adogo.april.Status;
	
	public class StatusComponent
	{
		[Bindable]
		public var statuses : ArrayCollection;
		
		private const DESTINATION_ID : String = "statusService"; 
		private var statusService : RemoteObject;
		
		public function StatusComponent()
		{
			this.statusService = new RemoteObject(DESTINATION_ID);
			this.statusService.addEventListener(ResultEvent.RESULT, onResult);		
			this.statusService.addEventListener(FaultEvent.FAULT, onFault); 
			
			//Fill in possible statuses
			this.statusService.getAllStatuses();
		}
		
		private function onResult(event : ResultEvent) : void {
			this.statuses = event.result as ArrayCollection;
		}
		
		private function onFault(event : FaultEvent) : void {
			this.statuses = this.createDefaultStatuses();
			Alert.show("The list of possible statuses could not be loaded, defaults have been loaded.");
		}
		
		private function createDefaultStatuses() : ArrayCollection {
			var statuses : ArrayCollection = new ArrayCollection();
			var status1 : Status = new Status();

			status1.name = "Available";
			status1.message = "I'm available now ...";
			status1.code = 0;
			
			statuses.addItem(status1);
			
			return statuses;
		}
	}
}