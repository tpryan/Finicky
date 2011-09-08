package com.terrenceryan.finicky.util
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	
	import mx.events.FlexEvent;
	
	import spark.core.DisplayObjectSharingMode;
	import spark.primitives.BitmapImage;
	
	public class AppStorageBitmapImage extends BitmapImage
	{
		
		private var loadedContent:DisplayObject;
		private var imageWidth:Number = NaN;
		private var imageHeight:Number = NaN;
		private var _trustedSource:Boolean = true;
		private var _bitmapData:BitmapData;
		private var bitmapDataCreated:Boolean;
		
		public function AppStorageBitmapImage()
		{
			super();
		}
		
		/**
		 * @private
		 * Invoked upon completion of a load request.
		 */
		override protected function contentComplete(content:Object):void
		{
			if (content is LoaderInfo)
			{
				// Clear any previous bitmap data or loader instance.
				setBitmapData(null);
				removePreviousContent();
				
				var loaderInfo:LoaderInfo = content as LoaderInfo;
				
				if (loaderInfo.childAllowsParent) 
				{
					// For trusted content we adopt the loaded BitmapData.
					//var image:Bitmap = Bitmap(loaderInfo.content);
					var bitmapData:BitmapData = new BitmapData(loaderInfo.width, loaderInfo.height);
					bitmapData.draw(loaderInfo.content);
					
					
					setBitmapData(bitmapData);
				} 
				else 
				{
					// For untrusted content we must host the acquired Loader
					// instance directly as our DisplayObject. 
					displayObjectSharingMode = DisplayObjectSharingMode.OWNS_UNSHARED_OBJECT;
					invalidateDisplayObjectSharing();
					
					// Create a content holder to use as our display object.
					var contentHolder:Sprite = new Sprite();
					setDisplayObject(contentHolder);    
					loadedContent = loaderInfo.loader;
					contentHolder.addChild(loadedContent);
					
					// Retain our source image width and height.
					imageWidth = loaderInfo.width; 
					imageHeight = loaderInfo.height ;
					
					// Update
					if (!explicitHeight || !explicitWidth)
						invalidateSize();
					invalidateDisplayList(); 
					
					// Denote that we are hosting an untrusted image and as such some
					// features requiring access to the bitmap data will no longer
					// function.
					_trustedSource = false; 
					
					// Dispatch ready event
					dispatchEvent(new FlexEvent(FlexEvent.READY));          
				}
			}
			else
			{
				if (content is BitmapData)
					setBitmapData(content as BitmapData);
			}
		}
		
		private function removePreviousContent():void
		{
			if (loadedContent && loadedContent.parent)
			{
				displayObjectSharingMode = DisplayObjectSharingMode.USES_SHARED_OBJECT;
				invalidateDisplayObjectSharing();
				loadedContent.parent.removeChild(loadedContent);
				loadedContent = null;
				setDisplayObject(null);
				imageWidth = imageHeight = NaN;
			}
			else if (drawnDisplayObject)
			{
				Sprite(drawnDisplayObject).graphics.clear();
				clearBitmapData();
			}
		}
		
		private function clearBitmapData():void
		{
			if (_bitmapData)
			{
				// Dispose the bitmap if we created it
				if (bitmapDataCreated) 
					_bitmapData.dispose();
				_bitmapData = null;
			}
		}
		
		
		
		
	}
}