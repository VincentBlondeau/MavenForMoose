"
A MavenImporterTests is xxxxxxxxx.

Uses baby mock to support file system tests

Instance Variables
	importer:		<Object>
	model:		<Object>

importer
	- xxxxx

model
	- xxxxx

"
Class {
	#name : #MavenImporterTests,
	#superclass : #PAIAAbstractImporterTestCase,
	#instVars : [
		'importer',
		'rootFolder',
		'pomRoot',
		'pomSub',
		'pomSub2',
		'pomEmpty',
		'subFolder'
	],
	#category : #'Maven-Tests'
}

{ #category : #accessing }
MavenImporterTests >> filePomEmpty [
	^ self fileNamed: '/root/empty/pom.xml'
]

{ #category : #accessing }
MavenImporterTests >> filePomRoot [
	^ self fileNamed: '/root/pom.xml'
]

{ #category : #accessing }
MavenImporterTests >> filePomSub [
	^ self fileNamed: '/root/sub/pom.xml'
]

{ #category : #accessing }
MavenImporterTests >> filePomSub2 [
	^ self fileNamed: '/root/sub2/pom.xml'
]

{ #category : #mockery }
MavenImporterTests >> fileSystemMockInMemory [
	fileSystemMock := FileSystem memory.
	self
		createDirectory: '/root';
		createDirectory: '/root/sub';
		createDirectory: '/root/sub2';
		createDirectory: '/root/empty';
		createFile: '/root/pom.xml';
		createFile: '/root/sub/pom.xml';
		createFile: '/root/sub2/pom.xml';
		createFile: '/root/empty/pom.xml'.
	self populateFile: '/root/pom.xml' with: self pomRootDocument.
	self populateFile: '/root/sub/pom.xml' with: self pomSubDocument.
	self populateFile: '/root/sub2/pom.xml' with: self pomSubDocument2.
	self populateFile: '/root/empty/pom.xml' with: self pomEmptyDocument 
]

{ #category : #accessing }
MavenImporterTests >> pomEmptyDocument [
^ '<project
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://maven.apache.org/POM/4.0.0">
	<modelVersion>4.0.0</modelVersion>
	<groupId>com.example</groupId>
	<artifactId>quickstart</artifactId>
	<version>1.0-SNAPSHOT</version>
	<packaging>war</packaging>
	<name>quickstart 5 Application</name>

</project>
'
]

{ #category : #accessing }
MavenImporterTests >> pomSubDocument [
"damartex-1.2.3\damartex-orderComparioConnector\pom.xml"
^ '<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<parent>
		<artifactId>project</artifactId>
		<groupId>net.project</groupId>
		<version>1.2.3</version>
		<relativePath>..</relativePath>
	</parent>
	<artifactId>project-orderConnector</artifactId>

	<dependencies>

		<dependency>
			<groupId>net.project</groupId>
			<artifactId>project-utils</artifactId>
			<version>${project.version}</version>
		</dependency>

		<!-- project2 Order Dependency (used to get connector API) -->
		<dependency>
			<groupId>project2.order</groupId>
			<artifactId>project2-order-service-core-contract</artifactId>
			<version>${project2-version}</version>
		</dependency>

		<!-- Only brought to have MetadataKeyMappingDefinition... -->
		<dependency>
			<groupId>project2.order</groupId>
			<artifactId>project2-order-service-core</artifactId>
			<version>${project2-version}</version>
		</dependency>
		
		<!-- Dependency used to override Order id generation -->
		<dependency>
			<groupId>project2.customer</groupId>
			<artifactId>project2-customer-impl</artifactId>
			<version>${project2-version}</version>
		</dependency>
		
		<dependency>
			<groupId>project2.order</groupId>
			<artifactId>project2-order-service-delivery-connector</artifactId>
			<version>${project2-version}</version>
		</dependency>
		
		<!-- Shared Context (this library is shared between Front And Middle) -->
		<dependency>
			<groupId>net.atos.awl.ri.project</groupId>
			<artifactId>project-sharedcontext</artifactId>
			<version>${project.version}</version>
		</dependency>

		




		<!-- project3 Connector -->
		<dependency>
			<groupId>net.project-project3</groupId>
			<artifactId>project-project3</artifactId>
			<version>${project.version}</version>
		</dependency>


	</dependencies>


	<!--build>
		<filters>
			<filter>${project.basedir}/src/main/filters/${env}.properties</filter>
		</filters>
		<resources>
			<resource>
				<directory>src/main/resources</directory>
				<filtering>true</filtering>
			</resource>
		</resources>
		<testResources>
			<testResource>
				<directory>src/test/resources</directory>
				<filtering>true</filtering>
			</testResource>
		</testResources>
	</build-->



</project>'
]

{ #category : #accessing }
MavenImporterTests >> pomSubDocument2 [
^ '<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<parent>
		<groupId>net.project1</groupId>
		<artifactId>project1-webservice</artifactId>
		<version>1.2.3</version>
	</parent>

	<groupId>net.project1</groupId>
	<artifactId>project1-webservice-dto</artifactId>
	<name>project1-webservice-dto</name>
	<url>http://maven.apache.org</url>
	<packaging>jar</packaging>

	<dependencies>
		<dependency>
			<groupId>project2.test</groupId>
			<artifactId>project2-test</artifactId>
			<version>${project2-version}</version>
			<scope>test</scope>
		</dependency>
		<dependency>
			<groupId>project2.utils.webservice</groupId>
			<artifactId>project2-webservice-common</artifactId>
			</dependency>
		<dependency>
			<groupId>net.project1.service.core</groupId>
			<artifactId>project1-service-impl</artifactId>
			<version>${project.version}</version>
			<scope>test</scope>
		</dependency>
	</dependencies>
</project>
'
]
