package model {
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.system.Capabilities;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class StorageProxy extends Proxy implements IProxy {
		public static const NAME:String = "StorageProxy";
		// Instance Vars
		private static var _os:String;
		private static var _version:String;

		// Directories
		private static var _publicDir:File; // Documents can be made accessible in iTunes or backed up to iCloud in iOS 5.0.1
		private static var _privateDir:File; // This is critical data that the user expects to be reliably available when offline.
		private static var _cacheDir:File; // Cached data may be purged in low storage situations, and is not backed up by iTunes or iCloud.
		private static var _tempDir:File; // Files in this directory are not backed up by iTunes or iCloud.

		public function StorageProxy(data:Object = null) {
			super(NAME, data);
		}

		override public function onRegister():void {
			getDeviceInfo();
			configDataStorage();
		}

		// Get device info
		private function getDeviceInfo():void {
			_os = returnFirstWord(Capabilities.os);
			_version = returnFirstWord(Capabilities.version);
		}

		// String helper
		public function returnFirstWord(s:String):String {
			var i:int = s.indexOf(" ");
			var len:uint = (i > 0) ? i : s.length;
			return s.substring(0, len);
		}

		// Configure Data Storage for iOS 
		private function configDataStorage():void {
			// Shortcut to <Application_Home> location as listed on QA1719 Apple tech note
			var applicationHome:String = File.userDirectory.nativePath;
			// Shortcuts for Android, etc...
			var publicStorage:String = File.documentsDirectory.nativePath;
			var privateStorage:String = File.applicationStorageDirectory.nativePath;

			// Check for iOS and not Mac/PC Simulator.
			if (_version == "IOS" && (_os != "Mac" || _os != "Win")) {
				_publicDir = new File(applicationHome + '/Documents');
				_privateDir = new File(applicationHome + '/Library/PrivateDocuments');
				_cacheDir = new File(applicationHome + '/Library/Caches');
				_tempDir = new File(applicationHome + '/tmp');
				trace("iOS Data Storage");
			} else {
				_publicDir = new File(publicStorage);
				_privateDir = new File(privateStorage);
				_cacheDir = new File(privateStorage + '/Caches');
				_tempDir = new File(File.createTempDirectory().nativePath + '/tmp');
				trace("Data Storage");
			}
			trace("- Public: " + _publicDir.nativePath + "\n- Private: " + _privateDir.nativePath + "\n- Cache: " + _cacheDir.nativePath + "\n- Temp: " + _tempDir.nativePath);
		}

		// Getters
		public function get filePublic():File {
			return _publicDir;
		}

		public function get filePrivate():File {
			return _privateDir;
		}

		public function get fileCache():File {
			return _cacheDir;
		}

		public function get fileTemp():File {
			return _tempDir;
		}
		
		public function readData($destinationDirectory:File, $filename:String):String{
			try{
				var $file:File = $destinationDirectory.resolvePath($filename);
				var $fileStream:FileStream = new FileStream();
				$fileStream.open($file, FileMode.READ);
				trace($fileStream.readUTFBytes($fileStream.bytesAvailable));
				$fileStream.close();
				return $fileStream.readUTF();
			}catch(e:Error){
				trace("Read file error", e);
			}
			return null;
		}
		
		public function saveData($destinationDirectory:File, $filename:String, $data:String):Array{
			try{
				var saveFile: File = $destinationDirectory.resolvePath($filename);
				
				var saveStream:FileStream = new FileStream();
				saveStream.open(saveFile, FileMode.WRITE);
				saveStream.writeUTFBytes($data);
				saveStream.close();
				trace(saveFile.exists, saveFile.nativePath);
				return [saveFile.exists, saveFile.nativePath]; // Array( Boolean, String )
			}catch(e:Error){
				trace("Save file Error", e);
			}
			
			return null;
		}

		public function saveTest():void{
			saveData(fileCache, "FileName.dat", "FileData");
			saveData(filePrivate, "FileName.dat", "FileData");
			saveData(filePublic, "FileName.dat", "FileData");
			saveData(fileTemp, "FileName.dat", "FileData");
		}
		
		public function readTest():void{
			readData(fileCache, "FileName.dat");
			readData(filePrivate, "FileName.dat");
			readData(filePublic, "FileName.dat");
			readData(fileTemp, "FileName.dat");
		}


	}
}
