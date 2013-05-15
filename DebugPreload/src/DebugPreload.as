package 
{
	
	import com.road7.debugtool.DebugTracer;
	
	import flash.debugger.enterDebugger;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.ProgressEvent;
	import flash.net.SharedObject;
	import flash.utils.getQualifiedClassName;
	
	import yzhkof.debug.DebugSystem;
	
	/**
	 * flash调试工具 
	 * @author xijie.ding
	 * 
	 */
	[SWF(backgroundColor="#c7edcc")]
	public class DebugPreload extends Sprite
	{
		private static const DDT:String = "DDT";
		private static const DDT_CLIENT:String = "DDT_Startup";
		private var _loadSwf:Sprite;
//		private var _fpsContainer:FlashStateView;
		private var _mStage:Stage;
		private var _ddtLoaderInfo:LoaderInfo;
		public function DebugPreload()
		{
			if(stage)
			{
				initStage();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE,initStage);
			}
		}
		
		private function initStage(evt:Event = null):void
		{
			SharedObject.getLocal("road").clear();//艹艹艹艹艹艹艹艹艹艹,不要问我为什么,老子调了一个月
			removeEventListener(Event.ADDED_TO_STAGE,initStage);
			root.addEventListener("allComplete", __allCompleteHandler);
//			loaderInfo.addEventListener(ProgressEvent.PROGRESS,__traceProgress);
		}
		
//		protected function __traceProgress(event:ProgressEvent):void
//		{
//			trace(event.bytesLoaded,event.bytesTotal);
//		}
		private function __allCompleteHandler(event:Event):void
		{
			_ddtLoaderInfo = event.target as LoaderInfo;
			var className:String = getQualifiedClassName(_ddtLoaderInfo.content);
//			if (className != DDT && className!= DDT_CLIENT)
//			{
//				return;
//			}
			
			_loadSwf = _ddtLoaderInfo.content.root as Sprite;
			if(_loadSwf)
			{
				root.removeEventListener("allComplete", __allCompleteHandler);
				initDebug();
			}
		}
		
		private function initDebug():void
		{
			if(_loadSwf.stage)
			{
				__addToStage();
			}
			else
			{
				_loadSwf.addEventListener(Event.ADDED_TO_STAGE,__addToStage);
			}
		}
		
		protected function __addToStage(event:Event = null):void
		{
			_loadSwf.removeEventListener(Event.ADDED_TO_STAGE,__addToStage);
			DebugSystem.init(_loadSwf,_ddtLoaderInfo.applicationDomain);
			DebugTracer.setup(_ddtLoaderInfo.applicationDomain);
//			debugStateSetup();
		}
		
//		private function debugStateSetup():void
//		{
//			if(_fpsContainer)
//			{
//				_loadSwf.stage.removeEventListener(Event.ADDED,__stageAdd);
//				_loadSwf.stage.removeEventListener(KeyboardEvent.KEY_DOWN,__keyPress);
//			}
//			_fpsContainer = FlashStateView.instance;
//			_fpsContainer.visible = false;
//			_fpsContainer.x = _loadSwf.stage.stageWidth - _fpsContainer.width;
//			
//			_loadSwf.stage.addChild(_fpsContainer);
//			_loadSwf.stage.addEventListener(Event.ADDED,__stageAdd);
//			_loadSwf.stage.addEventListener(KeyboardEvent.KEY_DOWN,__keyPress);
//		}
		
//		private function __stageAdd(event:Event):void
//		{
//			_loadSwf.stage.setChildIndex(_fpsContainer,_loadSwf.stage.numChildren-1);
//		}
//		
//		protected function __keyPress(event:KeyboardEvent):void
//		{
//			// TODO Auto-generated method stub
//			if(event.shiftKey)
//			{
//				switch(event.keyCode)
//				{
//					case 192:
//						_fpsContainer.visible = !_fpsContainer.visible;
//				}
//			}
//		}
	}
}