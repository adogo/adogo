package us.adogo.lunchchooser
{
	import flash.desktop.DockIcon;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindowDisplayState;
	import flash.events.Event;
	import flash.events.InvokeEvent;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowDisplayStateEvent;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
	import mx.core.WindowedApplication;
	import mx.events.CloseEvent;
	
	public class DesktopManager
	{

		private var dockImage:BitmapData;
		private var application:WindowedApplication;
		
		public function DesktopManager(_application:WindowedApplication)
		{
			this.application = _application;
			
			// Setup everything we'll need to set the dock/system tray icon
			var loader:Loader = new Loader();
      		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, prepareForSystray);
      		loader.load(new URLRequest("http://adogo.us/wp-content/themes/InSense/InSense/images/adogo.gif")); 
      		
			// Whenever this Air Application is closed, let the application manager know
			this.application.addEventListener(Event.CLOSING, onApplicationClose);

		}
		
		// Called the user quits or closes the application
		public function onApplicationClose(evt:Event):void
		{
			// Stop the close action so we can close manually 
			evt.preventDefault();

			// Check what the user really want's to do       
			Alert.buttonWidth = 110; 
			Alert.yesLabel = "Close";
			Alert.noLabel = "Minimize";
			Alert.show("Close or minimize?", "Close?", 3, this.application, alertCloseHandler);
		}

		// Event handler function for displaying the selected Alert button. 
		private function alertCloseHandler(event:CloseEvent):void
		{
			if (event.detail==Alert.YES) {
				closeApp(event);
			} else {
				// Call our custom function to dock the app
				dock();
			}
		}
   
   
		public function prepareForSystray(event:Event):void
		{
			dockImage = event.target.content.bitmapData;
		
			// Is this a Mac?	
			if(NativeApplication.supportsDockIcon)
			{
				var dockIcon:DockIcon = NativeApplication.nativeApplication.icon as DockIcon;
				NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, undock);
				dockIcon.menu = createSystrayRootMenu();
				NativeApplication.nativeApplication.icon.bitmaps = [dockImage];
			}
			// Is this a PC?
			else if (NativeApplication.supportsSystemTrayIcon)
			{
				var sysTrayIcon:SystemTrayIcon = NativeApplication.nativeApplication.icon as SystemTrayIcon;
				sysTrayIcon.tooltip = "LuncChooser";
				sysTrayIcon.addEventListener(MouseEvent.CLICK, undock);
				sysTrayIcon.menu = createSystrayRootMenu();

				//Listen to the display state changing of the window, so that we can catch the minimize       
				this.application.stage.nativeWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING, nwMinimized); //Catch the minimize event 
			}
			
		}

		private function createSystrayRootMenu():NativeMenu
		{
			// Create the menu when the user right clicks on it 
			var menu:NativeMenu = new NativeMenu();
			var openNativeMenuItem:NativeMenuItem = new NativeMenuItem("Open");
			var exitNativeMenuItem:NativeMenuItem = new NativeMenuItem("Exit");
			var somethingelseNativeMenuItem:NativeMenuItem = new NativeMenuItem("Do Something Else...");

			// What should happen when the user clicks on something...       
			openNativeMenuItem.addEventListener(Event.SELECT, undock);
			exitNativeMenuItem.addEventListener(Event.SELECT, closeApp);
			somethingelseNativeMenuItem.addEventListener(Event.SELECT, something);
			
			//Add the menuitems to the menu 
			menu.addItem(openNativeMenuItem);
			menu.addItem(somethingelseNativeMenuItem);
			menu.addItem(new NativeMenuItem("",true)); //separator
			menu.addItem(exitNativeMenuItem);

			return menu;
		}

		// Handle minimizing on the PC. Instead of minimizing, hide the app and show it in the system tray
		private function nwMinimized(displayStateEvent:NativeWindowDisplayStateEvent):void
		{
			// Is it being minimized?
			if(displayStateEvent.afterDisplayState == NativeWindowDisplayState.MINIMIZED)
			{
				//Prevent the windowedapplication minimize action from happening and implement our own minimize          //The reason the windowedapplication minimize action is caught, is that if active we're not able to          //undock the application back neatly. The application doesn't become visible directly, but only after clicking          //on the taskbars application link. (Not sure yet what happens exactly with standard minimize) 
				displayStateEvent.preventDefault();
          
				//Dock (our own minimize) 
				dock();
			}
		}

		// Handle hiding the application.
		public function dock():void
		{
	      // Hide the applcation 
	      this.application.stage.nativeWindow.visible = false;
	       
	      // Setting the bitmaps array will show the application icon in the systray 
	      if (NativeApplication.supportsSystemTrayIcon) {
	      	NativeApplication.nativeApplication.icon.bitmaps = [dockImage];
	      }
		}

		// Handle showing the application
		public function undock(evt:Event):void
		{
			// After setting the window to visible, make sure that the application is ordered to the front, or 
			// else in Windows we'll still need to click on the application on the taskbar to make it visible 
			this.application.stage.nativeWindow.visible = true;
			this.application.stage.nativeWindow.orderToFront();

			// Clearing the bitmaps array so windows doesn't store it in the tray while it's open. 
			// Could remove this if we wanted the icon to always be in the system tray. 
			if (NativeApplication.supportsSystemTrayIcon) {
				NativeApplication.nativeApplication.icon.bitmaps = [];
			}
		}
		
		// Handle closing the app
   		private function closeApp(evt:Event):void
		{
			this.application.stage.nativeWindow.close();
		}
		
		// Custom method
		private function something(evt:Event):void
		{
			Alert.show("Something else was clicked!");
		}
	}
}