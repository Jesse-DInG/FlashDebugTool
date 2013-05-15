package yzhkof.guxi
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class GraphicArea extends Sprite
	{
		public function GraphicArea()
		{
			super();
			init();
		}
		
		private var _text:TextField;
		
		private function init():void{
			_text = new TextField();
			var tf:TextFormat = new TextFormat();
			tf.font = "Arial";
			tf.bold =true;
			_text.defaultTextFormat = tf;
			_text.multiline = false;
			_text.autoSize = "left";
			_text.height = 20;
			_text.background = true;
			_text.backgroundColor = 0xFF0000;
		}
		
		public function draw(display:DisplayObject):void{
			var rect:Rectangle = display.getRect(stage);
			var g:Graphics = this.graphics;
			g.lineStyle(2,0xff0000);
			g.drawRect(rect.x,rect.y,rect.width,rect.height);
			_text.text = "x=" + display.x.toString() + "  y=" + display.y.toString() + "   " + rect.width.toString() + " * " + rect.height.toString();
			
			if(display.hasOwnProperty("stylename")){
				_text.appendText(" stylename=" + display["stylename"]);
			}
			
			_text.x = rect.x;
			_text.y = rect.y - 20;
			addChild(_text);
		}
		
		public function clear():void{
			var g:Graphics = this.graphics;
			g.clear();
			if(_text){
				if(_text.parent)_text.parent.removeChild(_text);
			}
		}
	}
}