<?xml version="1.0" encoding="UTF-8"?>

<beans>
	
	<!-- Setup Reactor Configuration -->
	<bean id="reactorConfiguration" class="reactor.config.Config">
		<constructor-arg name="pathToConfigXml">
			<value>/adogo/bin/coldfusion/config/reactor.xml.cfm</value>
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
			<value>/adogo/bin/coldfusion/reactor</value>
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
	
	
	<!-- Setup Member-related components -->
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
	<!-- ColdSpring can use other factories to instaniate objects. In this case, ColdSpring
		 will call the createGateway method on the reactorFactory object with this value.
		 The end result is a call equivalent to...
		 'beanFactory.getBean("reactorFactory").createGateway(objectAlias="member")' -->
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
	

	<!-- Generate remote facade for Member Service to be used by Flex -->
	<bean id="memberService_flex" class="coldspring.aop.framework.RemoteFactoryBean" lazy-init="false">

		<!-- The bean id that will be extended -->
		<property name="target">
			<ref bean="memberService" />
		</property>

		<!-- The filename of the generated file -->
		<property name="serviceName">
			<value>MemberServiceFlex</value>
		</property>

		<!-- The path this file will be generated at -->
		<property name="relativePath">
			<value>/adogo/bin/coldfusion/remote</value>
		</property>

		<!-- Which methods should be made available? -->
		<property name="remoteMethodNames">
			<value>get*,create,update,read,delete</value>
		</property>

		<!-- ColdSpring will look in application.ServiceFactory for a ColdSpring Bean Factory -->
		<property name="beanFactoryName">
   			<value>ServiceFactory</value>
		</property>
	</bean>

	<!-- Generate remote facade for Member Service to be used by Ajax -->
	<bean id="memberService_ajax" class="coldspring.aop.framework.RemoteFactoryBean" lazy-init="false">
		<property name="target">
			<ref bean="memberService" />
		</property>
		<property name="serviceName">
			<value>MemberServiceAjax</value>
		</property>
		<property name="relativePath">
			<value>/adogo/bin/coldfusion/remote</value>
		</property>
		<property name="remoteMethodNames">
			<value>get*</value>
		</property>
		<property name="beanFactoryName">
			<value>ServiceFactory</value>
		</property>
		<!-- An interceptor is a form of AOP advice. This one adds specific behavior for 
			 ColdFusion 8's new Ajax Grid component -->
		<property name="interceptorNames">
			<list>
				<!-- This should point to valid bean id -->
				<value>AJAXGridAdvisor</value>
			</list>
		</property>
		<!-- This is proposed change to ColdSpring that would modify the method signatures
			 for those that match. There is both the ability to add or remove method signatures,
 			 as well as control which methods are affected.
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
	
	<!-- AjaxGridAdvisor is a form of ColdSpring advice -->
	<bean id="AJAXGridAdvisor" class="us.adogo.AJAXGridAdvisor" />
		
</beans>