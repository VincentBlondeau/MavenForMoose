Class {
	#name : #MavenXMLInjector,
	#superclass : #Object,
	#classVars : [
		'cachePoms'
	],
	#category : #'Maven-XMLInjector'
}

{ #category : #'as yet unclassified' }
MavenXMLInjector class >> run [
	^ self new basicRun
]

{ #category : #'as yet unclassified' }
MavenXMLInjector >> basicRun [
	| modifiedXmlDocument stream |
	cachePoms
		ifNil:
			[ cachePoms := MavenXMLRetriver
				runOn: 'D:\TestsExperiements\massilia-core-repository' asFileReference ].
	cachePoms allButFirst
		do:
			[ :aPomFile | 
			modifiedXmlDocument := self injectDataIntoPomFile: aPomFile readStream contents.
			[ stream := aPomFile writeStream.
			modifiedXmlDocument
				writeXMLOn:
					((XMLWriter on: stream)
						enablePrettyPrinting;
						yourself) ]
				ensure: [ stream close ] ]
]

{ #category : #'as yet unclassified' }
MavenXMLInjector >> injectBuildPluginsNodeIn: aXMLDocument [
	| path build plugins |
	build := XMLElement name: 'build'.
	plugins := XMLElement name: 'plugins'.
	path := XPath for: 'project/build'.
	(path in: aXMLDocument)
		ifEmpty:
			[ (aXMLDocument elementAt: 'project') addNode: build.
			build addNode: plugins.
			self injectPluginInNode: plugins ]
		ifNotEmpty:
			[ :aCollectionOfNode | 
			aCollectionOfNode first addNode: plugins.
			self injectPluginInNode: plugins ]
]

{ #category : #'as yet unclassified' }
MavenXMLInjector >> injectDataIntoPomFile: aPomFile [
	| xmlDocument path |
	xmlDocument := XMLDOMParser parse: aPomFile.
	path := XPath for: 'project/dependencies'.
	(path in: xmlDocument)
		ifEmpty: [ self injectDependenciesNodeIn: xmlDocument ]
		ifNotEmpty:
			[ :aCollectionOfNode | self injectDependencyInNode: aCollectionOfNode first ].
	path := XPath for: 'project/build/plugins'.
	(path in: xmlDocument)
		ifEmpty: [ self injectBuildPluginsNodeIn: xmlDocument ]
		ifNotEmpty: [ :aCollectionOfNode | self injectPluginInNode: aCollectionOfNode first ].
	^ xmlDocument
]

{ #category : #'as yet unclassified' }
MavenXMLInjector >> injectDependenciesNodeIn: aXMLDocument [
	| dependenciesNode |
	dependenciesNode := XMLElement name: 'dependencies'.
	(aXMLDocument elementAt: 'project') addNode:  dependenciesNode.
	self injectDependencyInNode: dependenciesNode.
	"<!-- VBU: end plugin adding -->
		<dependency>
			<groupId>aa.worldline.vbu.Jacoco</groupId>
			<artifactId>aspect</artifactId>
			<version>0.0.1-SNAPSHOT</version>
		</dependency>
		<!-- VBU: end plugin adding -->"
		
	
"<build>
		<plugins>
			<!-- VBU: end plugin adding -->
			<plugin>
				<groupId>org.codehaus.mojo</groupId>
				<artifactId>aspectj-maven-plugin</artifactId>
				<version>1.5</version>
				<executions>
					<execution>
						<goals>
							<goal>compile</goal><!-- to weave all your main classes -->
							<goal>test-compile</goal><!-- to weave all your test classes -->
						</goals>
					</execution>
				</executions>
				<configuration>
					<sources>
						<source>
							<basedir>src/test</basedir>
							<includes>
								<include>**/Jacoco.java</include>
							</includes>
						</source>
					</sources>
					<complianceLevel>1.6</complianceLevel>
					<outxml>false</outxml>
					<verbose>true</verbose>
					<showWeaveInfo>true</showWeaveInfo>
					<source>1.6</source>
					<target>1.6</target>
				</configuration>
			</plugin>

			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-surefire-plugin</artifactId>
			</plugin>
			<!-- VBU: end plugin adding -->
		</plugins>
	</build>"
]

{ #category : #'as yet unclassified' }
MavenXMLInjector >> injectDependencyInNode: aXMLElement [
	| newDependencyNode |
	newDependencyNode := XMLElement new name: 'dependency'.
	aXMLElement addNode: newDependencyNode.
	newDependencyNode
		innerXML:
			'<!-- VBU: end plugin adding -->
			<groupId>aa.worldline.vbu.Jacoco</groupId>
			<artifactId>aspect</artifactId>
			<version>0.0.1-SNAPSHOT</version>
			<!-- VBU: end plugin adding -->'

	"
		<dependency>
		<!-- VBU: end plugin adding -->
			<groupId>aa.worldline.vbu.Jacoco</groupId>
			<artifactId>aspect</artifactId>
			<version>0.0.1-SNAPSHOT</version>
					<!-- VBU: end plugin adding -->
		</dependency>"
]

{ #category : #'as yet unclassified' }
MavenXMLInjector >> injectPluginInNode: aXMLElement [
	| newNode |
	newNode := XMLElement new name: 'plugin'.
	aXMLElement addNode: newNode.
	newNode
		innerXML:
			'<groupId>org.codehaus.mojo</groupId>
				<artifactId>aspectj-maven-plugin</artifactId>'.
	"newNode := XMLElement new name: 'plugin'.
	aXMLElement addNode: newNode.
	newNode
		innerXML:
			'<groupId>org.apache.maven.plugins</groupId>
					<artifactId>maven-surefire-plugin</artifactId>
					<version>2.6</version>
					<configuration>
						<includes>
							<include>**/*Test.java</include>
							<include>**/*TestCase.java</include>
						</includes>
						<encoding>UTF-8</encoding>
						<inputEncoding>UTF-8</inputEncoding>
						<outputEncoding>UTF-8</outputEncoding>
						<argLine>-Dfile.encoding=UTF-8 -XX:MaxPermSize=256m -Xmx1024m</argLine>
						<skipTests>false</skipTests>
						<!-- Add VBU code -->
						<argLine>-javaagent:${jacocoagentLocation}=jmx=true,output=none,exclclassloader=sun.reflect.DelegatingClassLoader</argLine>
						<!-- END Add VBU code -->
					</configuration>
					<executions>
						<execution>
							<id>default-test</id>
							<phase>test</phase>
							<goals>
								<goal>test</goal>
							</goals>
						</execution>
					</executions>'"
]
