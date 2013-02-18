<extension xmlns="http://ns.adobe.com/air/extension/3.3">
	<id>es.xperiments.ane.ane7z.ANE7z</id>
	<versionNumber>@majorVersion@.@minorVersion@.@buildNumber@</versionNumber>
		<platforms>
			<platform name="iPhone-x86">
				<applicationDeployment>
					<nativeLibrary>libANE7z.a</nativeLibrary>
					<initializer>ANE7zExtensionInitializer</initializer>
					<finalizer>ANE7zExtensionFinalizer</finalizer>
				</applicationDeployment>
			</platform>		 
			<platform name="iPhone-ARM">
				<applicationDeployment>
					<nativeLibrary>libANE7z.a</nativeLibrary>
					<initializer>ANE7zExtensionInitializer</initializer>
					<finalizer>ANE7zExtensionFinalizer</finalizer>
				</applicationDeployment>
			</platform>
	</platforms>
</extension>
			