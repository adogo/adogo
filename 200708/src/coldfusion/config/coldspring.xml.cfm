<?xml version="1.0" encoding="UTF-8"?>

<beans>
	
	<!-- Setup Reactor Configuration -->
	<bean id="reactorConfiguration" class="reactor.config.Config">
		<constructor-arg name="pathToConfigXml">
			<value>/coldfusion/config/reactor.xml.cfm</value>
		</constructor-arg>
		<property name="project">
			<value>AdogoColdspring</value>
		</property>
		<property name="dsn">
			<value>adogo1-1</value>
		</property>
		<property name="type">
			<value>mysql</value>
		</property>
		<property name="mapping">
			<value>/coldfusion/reactor</value>
		</property>
		<property name="mode">
			<value>development</value>
		</property>
	</bean>
	
	<!-- Setup Reactor -->
	<bean id="reactorFactory" class="reactor.ReactorFactory">
		<constructor-arg name="configuration">
			<ref bean="reactorConfiguration" />
		</constructor-arg>
	</bean>
	
	
	<!-- Setup Product-related components -->
	<bean id="authorService" class="us.adogo.AuthorService">
		<constructor-arg name="name">
			<value>author</value>
		</constructor-arg>
		<constructor-arg name="reactorFactory">
			<ref bean="reactorFactory" />
		</constructor-arg>
		<constructor-arg name="authorGateway">
			<ref bean="authorGateway" />
		</constructor-arg>
		<constructor-arg name="authorDAO">
			<ref bean="authorDAO" />
		</constructor-arg>
	</bean>
	
	<bean id="authorGateway" factory-bean="reactorFactory" factory-method="createGateway">
		<constructor-arg name="objectAlias">
			<value>author</value>
		</constructor-arg>
	</bean>
	
	<bean id="authorDAO" factory-bean="reactorFactory" factory-method="createDao">
		<constructor-arg name="objectAlias">
			<value>author</value>
		</constructor-arg>
	</bean>
	
	<!-- Generate remote facade for Author Service -->
	<bean id="authorService_Flex" class="coldspring.aop.framework.RemoteFactoryBean">
		<property name="target">
			<ref bean="authorService" />
		</property>
		<property name="serviceName">
			<value>RemoteAuthorService</value>
		</property>
		<property name="relativePath">
			<value>/flex/cfcs/remote</value>
		</property>
		<property name="remoteMethodNames">
			<value>get*</value>
		</property>
		<property name="beanFactoryName">
   			<value>ServiceFactory</value>
		</property>
	</bean>
	
	
</beans>