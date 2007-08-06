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
			<value>adogo</value>
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
	<bean id="memberService" class="us.adogo.MemberService">
		<constructor-arg name="name">
			<value>member</value>
		</constructor-arg>
		<constructor-arg name="reactorFactory">
			<ref bean="reactorFactory" />
		</constructor-arg>
		<constructor-arg name="memberGateway">
			<ref bean="memberGateway" />
		</constructor-arg>
		<constructor-arg name="memberDAO">
			<ref bean="memberDAO" />
		</constructor-arg>
	</bean>
	
	<bean id="memberGateway" factory-bean="reactorFactory" factory-method="createGateway">
		<constructor-arg name="objectAlias">
			<value>member</value>
		</constructor-arg>
	</bean>
	
	<bean id="memberDAO" factory-bean="reactorFactory" factory-method="createDao">
		<constructor-arg name="objectAlias">
			<value>member</value>
		</constructor-arg>
	</bean>
	
	<!-- Generate remote facade for Member Service -->
	<bean id="memberServiceFlex" class="coldspring.aop.framework.RemoteFactoryBean" lazy-init="false">
		<property name="target">
			<ref bean="memberService" />
		</property>
		<property name="serviceName">
			<value>MemberServiceRemote</value>
		</property>
		<property name="relativePath">
			<value>/coldfusion/remote</value>
		</property>
		<property name="remoteMethodNames">
			<value>get*,create,update,read,delete</value>
		</property>
		<property name="beanFactoryName">
   			<value>ServiceFactory</value>
		</property>
	</bean>
	
	<bean id="memberServiceAjax" class="coldspring.aop.framework.RemoteFactoryBean" lazy-init="false">
		<property name="target">
			<ref bean="memberService" />
		</property>
		<property name="serviceName">
			<value>MemberServiceAjax</value>
		</property>
		<property name="relativePath">
			<value>/coldfusion/remote</value>
		</property>
		<property name="remoteMethodNames">
			<value>get*,create,update,read,delete</value>
		</property>
		<property name="beanFactoryName">
			<value>ServiceFactory</value>
		</property>
		<property name="interceptorNames">
			<list>
				<value>AJAXGridAdvisor</value>
			</list>
		</property>
		<!--
		<metadata>
			<methods>
				<method name="get*">
					<parameter name="cfgridpage" />
					<parameter name="cfgridpageSize" />
					<parameter name="cfgridpagesortcolumn" />
					<parameter name="cfgridpagesortdirection" />
				</method>
				<method name="update">
					<parameter name="gridaction" />
					<parameter name="gridrow" />
					<parameter name="gridchanged" />
				</method>
			</methods>
	   </metadata>
		-->
	</bean>
	
	<bean id="AJAXGridAdvisor" class="us.adogo.AJAXGridAdvisor" />
			
</beans>