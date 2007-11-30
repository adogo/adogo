package com.freebase.services
{
import com.cynergysystems.tango.ServiceLocator;
import flash.accessibility.*;
import flash.debugger.*;
import flash.display.*;
import flash.errors.*;
import flash.events.*;
import flash.external.*;
import flash.filters.*;
import flash.geom.*;
import flash.media.*;
import flash.net.*;
import flash.printing.*;
import flash.profiler.*;
import flash.system.*;
import flash.text.*;
import flash.ui.*;
import flash.utils.*;
import flash.xml.*;
import mx.binding.*;
import mx.core.ClassFactory;
import mx.core.DeferredInstanceFromClass;
import mx.core.DeferredInstanceFromFunction;
import mx.core.IDeferredInstance;
import mx.core.IFactory;
import mx.core.IPropertyChangeNotifier;
import mx.core.mx_internal;
import mx.rpc.http.mxml.HTTPService;
import mx.rpc.remoting.mxml.RemoteObject;
import mx.styles.*;
import com.cynergysystems.tango.ServiceLocator;

public class Services extends com.cynergysystems.tango.ServiceLocator
{
	public function Services() {}

	[Bindable]
	public var httpService : mx.rpc.http.mxml.HTTPService;
	[Bindable]
	public var remoteObject : mx.rpc.remoting.mxml.RemoteObject;

	public var _bindingsByDestination : Object;
	public var _bindingsBeginWithWord : Object;

include "C:/Users/ryan/Desktop/cruisecontrol/projects/sample/working/flex/com/freebase/services/Services.mxml:7,18";

}}
