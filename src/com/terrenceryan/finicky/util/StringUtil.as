package com.terrenceryan.finicky.util
{
	public class StringUtil
	{
		public function StringUtil()
		{
		}
		
		public  function toTitleCase( original:String ):String {
			var words:Array = original.split( " " );
			for (var i:int = 0; i < words.length; i++) {
				words[i] = toInitialCap( words[i] );
			}
			return ( words.join( " " ) );
		}
		
		public  function toInitialCap( original:String ):String {
			return original.charAt( 0 ).toUpperCase(  ) + original.substr( 1 ).toLowerCase(  );
		} 
	}
}