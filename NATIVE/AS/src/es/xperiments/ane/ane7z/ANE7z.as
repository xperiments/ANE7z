//
//  ANE7z.as
//
//  Created by ANEBridgeCreator on 18/02/2013.
//  Copyright (c)2013 ANEBridgeCreator. All rights reserved.
//
package es.xperiments.ane.ane7z
{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.filesystem.File;
	
	public class ANE7z
	{
		/**
		 * Declare static context
		 */
		private static var __context:ExtensionContext = null;
		
		/**
		 * Declare private accesors vars
		 */
		
		/**
		 * ANE7z Static Constructor / Initializer
		 */
		{
			if ( !__context )
			{
				__context = ExtensionContext.createExtensionContext("es.xperiments.ane.ane7z.ANE7z","es.xperiments.ane.ane7z.ANE7z");
				__context.addEventListener(StatusEvent.STATUS,onContextStatusEvent);
			}
		}
		



		/**
		* @param source:File
		* @param destination:File
		* @return Array
		*/
		public static function decompress( source:File, destination:File ):Array
		{
			if( !source.exists || source.isDirectory )
			{
				throw new Error("ANE7z.decompress source file not exists or is a directory");
			}
			if( !destination.exists ) destination.createDirectory();

			return	( __context.call( 'decompress',source.nativePath, destination.nativePath ) as String ).split(',');
		};
		
		/**
		* @param source:File
		* @param destination:File
		* @return void
		*/
		public static function decompressAsync( source:File, destination:File ):void
		{
			if( !source.exists || source.isDirectory )
			{
				throw new Error("ANE7z.decompressAsync source file not exists or is a directory");
			}
			if( !destination.exists ) destination.createDirectory();

			__context.call( 'decompressAsync',source.nativePath, destination.nativePath ) ;
		};
		
		/**
		* @param source:File
		* @param destination:File
		* @param entry:String
		* @return Boolean
		*/
		public static function extractEntry( source:File, destination:File, entry:String ):Boolean
		{
			if( !source.exists || source.isDirectory )
			{
				throw new Error("ANE7z.extractEntry source file not exists or is a directory");
			}			
			return	__context.call( 'extractEntry',source.nativePath, destination.nativePath, entry ) as Boolean;
		};
		
		/**
		* @param source:File
		* @param destination:File
		* @param entry:String
		* @return void
		*/
		public static function extractEntryAsync( source:File, destination:File, entry:String ):void
		{
			if( !source.exists || source.isDirectory )
			{
				throw new Error("ANE7z.extractEntry source file not exists or is a directory");
			}		
			__context.call( 'extractEntryAsync',source.nativePath, destination.nativePath, entry ) ;
		};
		
		/**
		 * Check if the extension is supported
		 * @return Boolean
		 */
		public static function get isSupported():Boolean
		{
			return true;
		}
		
		/**
		 * Dispose the ANE7z extension
		 */
		public static function dispose():void
		{
			if( __context.hasEventListener(StatusEvent.STATUS) ) __context.removeEventListener(StatusEvent.STATUS,onContextStatusEvent);
			__context.dispose();
			__context = null;
		}
		
		/**
		 * Main Native Event Listener
		 */
		private static function onContextStatusEvent( e:StatusEvent ):void
		{
			switch( e.code )
			{
				case ANE7zEvent.UN7Z_START:
				case ANE7zEvent.UN7Z_END:
				case ANE7zEvent.UN7Z_ENTRY_START:
					dispatchEvent( new ANE7zEvent( e.code ) );
				break;		
				case ANE7zEvent.UN7Z_PROGRESS:
				case ANE7zEvent.UN7Z_ENTRY_END:
					dispatchEvent( new ANE7zEvent( e.code, e.level ) );
				break;						
			}
		}

        private static var _dispatcher:EventDispatcher = new EventDispatcher();
 
        public static function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void {
            _dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }
        public static function dispatchEvent(event:Event):Boolean {
            return _dispatcher.dispatchEvent(event);
        }
        public static function hasEventListener(type:String):Boolean {
            return _dispatcher.hasEventListener(type);
        }
        public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
            _dispatcher.removeEventListener(type, listener, useCapture);
        }
        public static function willTrigger(type:String):Boolean {
            return _dispatcher.willTrigger(type);
        }

	}
	
}
