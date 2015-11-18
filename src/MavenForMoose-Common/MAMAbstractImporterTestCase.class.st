"
A PAIAAbstractImporterTestCase is an abstract class to do complete tests. It's using some file system mocking to emulates a real one to runs the tests.

Instance Variables
	fileSystemMock:		aFile system
	model:		aMooseModel

fileSystemMock
	- a file system virtualized in the memory where the files of the projet are stored.

model
	- the model created by the importers

"
Class {
	#name : #MAMAbstractImporterTestCase,
	#superclass : #TestCase,
	#instVars : [
		'model',
		'fileSystemMock'
	],
	#category : #'MavenForMoose-Common-Tests'
}

{ #category : #'as yet unclassified' }
MAMAbstractImporterTestCase class >> loadFileNamed: aString inMethod: aSelector [
	| stream |
	stream := ReadWriteStream with: aSelector.
	stream << String crlf.
	stream << '^ '.
	(StandardFileStream readOnlyFileNamed: aString) contents asByteArray printOn: stream.
	self compile: stream contents
]

{ #category : #mockery }
MAMAbstractImporterTestCase >> createDirectory: aString [
	fileSystemMock createDirectory: (fileSystemMock pathFromString: aString)
]

{ #category : #mockery }
MAMAbstractImporterTestCase >> createFile: aString [ 
	fileSystemMock store createFile: (fileSystemMock store pathFromString: aString)
]

{ #category : #'as yet unclassified' }
MAMAbstractImporterTestCase >> createFiles: aCollection [
	self shouldBeImplemented.
	aCollection do: [ :association | association halt ]
]

{ #category : #mockery }
MAMAbstractImporterTestCase >> fileNamed: aFilePath [
	^ (fileSystemMock entryAt: aFilePath)
]

{ #category : #mockery }
MAMAbstractImporterTestCase >> fileSystemMockInMemory [
	fileSystemMock := FileSystem memory.
 
]

{ #category : #accessing }
MAMAbstractImporterTestCase >> model [
	^ model
]

{ #category : #accessing }
MAMAbstractImporterTestCase >> model: anObject [
	model := anObject
]

{ #category : #accessing }
MAMAbstractImporterTestCase >> pomRootDocument [
^ '<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
	<modelVersion>4.0.0</modelVersion>

	<parent>
		<groupId>org.kazansource</groupId>
		<artifactId>kazan-parent</artifactId>
		<version>3.1</version>
	</parent>

	<groupId>net.atos.awl.ri.damart</groupId>
	<artifactId>damartex</artifactId>
	<version>1.2.3</version>
	<packaging>pom</packaging>
	<name>damartex parent project</name>

	<properties>
		<!-- For damartex-orderComparioConnector & sharedContext -->
		<!-- <massilia-context-version>0.5.0-SNAPSHOT</massilia-context-version> -->
		<massilia-context-version>0.8.0</massilia-context-version>
		<massilia-version>2.1.2</massilia-version>
		<!-- Common dependencies versions -->
		<spring-version>3.0.5.RELEASE</spring-version>
		<project.wod.version>4.0.19</project.wod.version>
		<slf4j-version>1.6.1</slf4j-version>
		<junit-version>4.9</junit-version>
		<project-build-sourceEncoding>UTF-8</project-build-sourceEncoding>
		<common-io-version>1.4</common-io-version>
		<h2_version>1.3.171</h2_version>
	</properties>


	<modules>
		<module>damartex-front</module>
		<module>damartex-batch</module>
		<module>damartex-integration</module>
		<module>damartex-shopzilla</module>
		<module>damartex-shopzilla-batch</module>
		<module>damartex-utils</module>
		<module>damartex-compario</module>
		<module>damartex-orderComparioConnector</module>
		<module>damartex-sharedcontext</module>
		<module>damartex-custom-salespromotion</module>
		<module>damartex-salespromotion-connector-contract</module>
		<module>damartex-salespromotion-payment-connector</module>
<!-- 		<module>damartex-email</module> -->
		<module>massilia-webservice-checkout</module>
		<module>damartex-order-service</module>
		<module>damartex-order-webservice</module>
		<module>damartex-webservice-checkout-client</module>
		<module>damartex-payment-service</module>
		<module>massilia-admin-portlets</module>
	</modules>

	<!-- following scm entries are used to allow jenkins to release your project -->
	<!-- replace ${personal-repo-name} by the name of your kazan repo hg mercurial-repo-url 
		comes from continuous integration server -->
	<scm>
		<connection>scm:svn:http://kazan.priv.atos.fr/svn/damart-next-svnrepository-1/tags/damartex-1.2.3</connection>
	</scm>

	<repositories>
		<repository>
			<id>kazan-public</id>
			<name>Kazan Public</name>
			<url>http://kazan.priv.atos.fr/nexus/content/groups/public</url>
			<releases>
				<enabled>true</enabled>
			</releases>
			<snapshots>
				<enabled>false</enabled>
			</snapshots>
		</repository>
		<repository>
			<id>kazan-release</id>
			<name>Kazan Release</name>
			<url>http://kazan.priv.atos.fr/nexus/content/repositories/releases</url>
			<releases>
				<enabled>true</enabled>
			</releases>
			<snapshots>
				<enabled>false</enabled>
			</snapshots>
		</repository>
		<repository>
			<id>kazan-snapshot</id>
			<name>Kazan Snapshot</name>
			<url>http://kazan.priv.atos.fr/nexus/content/repositories/snapshots/</url>
			<releases>
				<enabled>false</enabled>
			</releases>
			<snapshots>
				<enabled>true</enabled>
			</snapshots>
		</repository>
	</repositories>
	<!--repositories>
		<repository>
			<id>kazan-public</id>
			<name>Kazan Public</name>
			<url>http://kazan.priv.atos.fr/nexus/content/groups/public</url>
		</repository>
		<repository>
			<id>ganesh</id>
			<name>Kazan ganesh</name>
			<url>http://kazan.priv.atos.fr/nexus/content/repositories/ganesh-hosted-releases</url>
		</repository>
		<repository>
			<id>ganesh-nexus</id>
			<name>ganesh-nexus</name>
			<url>http://ganesh-code.mpht.priv.atos.fr/nexus/content/groups/public</url>
		</repository>
		<repository>
			<id>devlab</id>
			<name>devlab</name>
			<url>http://nexus.devlab722.net/nexus/content/repositories/snapshots</url>
		</repository>
	</repositories-->



	<profiles>
		<profile>
			<id>local</id>
			<activation>
				<activeByDefault>true</activeByDefault>
			</activation>
			<properties>
				<bdd>h2</bdd>
				<env>local</env>
			</properties>
		</profile>
		<profile>
			<id>qualif</id>
			<properties>
				<bdd>mysql</bdd>
				<env>qualif</env>
			</properties>
		</profile>
	</profiles>


	<!-- Common dependencies -->
	<dependencies>
		<!-- Test -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-test</artifactId>
			<version>${spring-version}</version>
			<scope>test</scope>
		</dependency>
		<dependency>
			<groupId>org.slf4j</groupId>
			<artifactId>slf4j-api</artifactId>
			<version>${slf4j-version}</version>
			<scope>compile</scope>
		</dependency>
		<dependency>
			<groupId>org.slf4j</groupId>
			<artifactId>slf4j-log4j12</artifactId>
			<version>${slf4j-version}</version>
			<scope>compile</scope>
		</dependency>

		<dependency>
			<groupId>junit</groupId>
			<artifactId>junit</artifactId>
			<version>${junit-version}</version>
			<scope>test</scope>
		</dependency>
		<dependency>
			<groupId>commons-io</groupId>
			<artifactId>commons-io</artifactId>
			<version>${common-io-version}</version>
		</dependency>
		<dependency>
			<groupId>com.h2database</groupId>
			<artifactId>h2</artifactId>
			<version>${h2_version}</version>
			<scope>test</scope>
		</dependency>

	</dependencies>
	
	<dependencyManagement>
		<dependencies>
			<dependency>
			<groupId>massilia.utils</groupId>
			<artifactId>massilia-core-utils</artifactId>
			<version>${massilia-context-version}</version>
		</dependency>
		</dependencies>
	
	</dependencyManagement>

</project>'
]

{ #category : #mockery }
MAMAbstractImporterTestCase >> populateFile: filePath with: aString [
	(fileSystemMock entryAt: filePath) writeStream nextPutAll: aString
]

{ #category : #running }
MAMAbstractImporterTestCase >> setUp [
	super setUp.
	model := MooseModel new.
	self fileSystemMockInMemory
]
