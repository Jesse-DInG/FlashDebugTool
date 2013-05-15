package com.road7.debugtool
{
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	
	import yzhkof.debug.DebugSystem;

	public class DebugTracer
	{
		public static const TRACE_MANAGER:String = "road7th.manager.TraceManager";
		private static var _manager:*;
//		public function DebugTracer(domain:ApplicationDomain)
//		{
//			try
//			{
//			_manager = domain.getDefinition(TRACE_MANAGER);
//			_manager.Instance.addEventListener("trace",__onTrace);
//			}
//			catch(e:Error)
//			{
//				DebugSystem.traceTxt(e.message);
//			}
//		}
		
		public static function setup(domain:ApplicationDomain):void
		{
			try
			{
				_manager = domain.getDefinition(TRACE_MANAGER);
				_manager.Instance.addEventListener("trace",__onTrace);
			}
			catch(e:Error)
			{
				DebugSystem.traceTxt(e.message);
			}
		}
		
		private static function __onTrace(e:*):void
		{
			DebugSystem.traceTxt(e.data);
		}
	}
}