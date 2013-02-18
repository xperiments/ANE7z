package es.xperiments.ane.ane7z
{

	import flash.events.Event;
	import flash.utils.ByteArray;

	public class ANE7zEvent extends Event
	{

		public static const UN7Z_START:String = "7Z_START";
		public static const UN7Z_END:String = "7Z_END";
		public static const UN7Z_PROGRESS:String = "UN7Z_PROGRESS";
		public static const UN7Z_ENTRY_START:String = "UN7Z_ENTRY_START";
		public static const UN7Z_ENTRY_END:String = "UN7Z_ENTRY_END";
		public var eventInfo:Object;

		public function ANE7zEvent(type:String, eventData:String ="", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			if( eventData!="" ) eventInfo = JSON.parse( eventData );
		}

	
	}
	
}
