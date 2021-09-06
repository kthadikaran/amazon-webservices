# Cloudformation
CloudFormation is a service that allows you to model your entire infrastructure in a text file called a template. You can use JSON or YAML to describe what AWS resources(like Amazon EC2 instances or Amazon RDS DB instances) you want to create and configure. If you want to design visually, you can use AWS CloudFormation Designer.

# Features of Cloudformation
1. Simplify infrastructure management
2. Quickly replicate your infrastructure
3. Easily control and track changes to your infrastructure
4. Infrastructure consistency
5. Easy-to-read template

# CloudFormation concepts
When you use AWS CloudFormation, you work with templates and stacks.
1. Teamplates
2. Stacks
3. Change Sets

# Templates
A CloudFormation template is a JSON or YAML formatted text file. You can save these files with any extension, such as .json, .yaml, .template, or .txt. 
CloudFormation uses these templates as blueprints for building your AWS resources.

### Cloud Formation Template Structure

#### JSON

The following example shows a JSON-formatted template fragment.

{

  "AWSTemplateFormatVersion" : "version date",

  "Description" : "JSON string",

  "Metadata" :   {    
    template metadata  
  },

  "Parameters" :   {  
    set of parameters  
  },
  
  "Rules" :   {  
    set of rules    
  },

  "Mappings" :   {  
    set of mappings    
  },

  "Conditions" :   {  
    set of conditions   
  },

  "Transform" :   {  
    set of transforms    
  },

  "Resources" :   {  
    set of resources    
  },
  
  "Outputs" :   {  
    set of outputs    
    }  
}

#### YAML

The following example shows a YAML-formatted template fragment.

AWSTemplateFormatVersion: "version date"

Description:
  String

Metadata:
  template metadata

Parameters:
  set of parameters

Rules:
  set of rules

Mappings:
  set of mappings

Conditions:
  set of conditions

Transform:
  set of transforms

Resources:
  set of resources

Outputs:
  set of outputs
  
### Template sections
Templates include several major sections. The Resources section is the only required section. Some sections in a template can be in any order. However, as you build your template, it can be helpful to use the logical order shown in the following list because values in one section might refer to values from a previous section.

##### Format Version (optional)
The AWS CloudFormation template version that the template conforms to. The template format version isn't the same as the API or WSDL version. The template format version can change independently of the API and WSDL versions.

##### Description (optional)
A text string that describes the template. This section must always follow the template format version section.

##### Metadata (optional)
Objects that provide additional information about the template.

##### Parameters (optional)
Values to pass to your template at runtime (when you create or update a stack). You can refer to parameters from the Resources and Outputs sections of the template.

##### Rules (optional)
Validates a parameter or a combination of parameters passed to a template during a stack creation or stack update.

##### Mappings (optional)
A mapping of keys and associated values that you can use to specify conditional parameter values, similar to a lookup table. You can match a key to a corresponding value by using the Fn::FindInMap intrinsic function in the Resources and Outputs sections.

##### Conditions (optional)
Conditions that control whether certain resources are created or whether certain resource properties are assigned a value during stack creation or update. For example, you could conditionally create a resource that depends on whether the stack is for a production or test environment.

##### Transform (optional)
For serverless applications (also referred to as Lambda-based applications), specifies the version of the AWS Serverless Application Model (AWS SAM) to use. When you specify a transform, you can use AWS SAM syntax to declare resources in your template. The model defines the syntax that you can use and how it's processed.

You can also use AWS::Include transforms to work with template snippets that are stored separately from the main AWS CloudFormation template. You can store your snippet files in an Amazon S3 bucket and then reuse the functions across multiple templates.

##### Resources (required)
Specifies the stack resources and their properties, such as an Amazon Elastic Compute Cloud instance or an Amazon Simple Storage Service bucket. You can refer to resources in the Resources and Outputs sections of the template.

##### Outputs (optional)
Describes the values that are returned whenever you view your stack's properties. For example, you can declare an output for an S3 bucket name and then call the aws cloudformation describe-stacks AWS CLI command to view the name.


# Stacks
When you use CloudFormation, you manage related resources as a single unit called a stack. You create, update, and delete a collection of resources by creating, updating, and deleting stacks. All the resources in a stack are defined by the stack's CloudFormation template. To create those resources, you create a stack by submitting the template that you created, and CloudFormation provisions all those resources for you.

# Nested Stacks
Nested stacks are stacks created as part of other stacks. You create a nested stack within another stack by using the AWS::CloudFormation::Stack resource. As your infrastructure grows, common patterns can emerge in which you declare the same components in multiple templates.

# Change sets
If you need to make changes to the running resources in a stack, you update the stack. Before making changes to your resources, you can generate a change set, which is a summary of your proposed changes. Change sets allow you to see how your changes might impact your running resources, especially for critical resources, before implementing them

# Stack Sets

AWS CloudFormation StackSets extends the functionality of stacks by enabling you to create, update, or delete stacks across multiple accounts and Regions with a single operation. Using an administrator account, you define and manage an AWS CloudFormation template, and use the template as the basis for provisioning stacks into selected target accounts across specified AWS Regions.

# How does AWS CloudFormation work?

CloudFormation uploads it to an S3 bucket in your AWS account even if you stored template file in local system,. CloudFormation creates a bucket for each region in which you upload a template file. 

The buckets are accessible to anyone with Amazon Simple Storage Service (Amazon S3) permissions in your AWS account. If a bucket created by CloudFormation is already present, the template is added to that bucket.

You can use your own bucket and manage its permissions by manually uploading templates to Amazon S3. Then whenever you create or update a stack, specify the Amazon S3 URL of a template file.

![image](https://user-images.githubusercontent.com/41946619/132156847-71178fde-3509-4d7f-8e00-f87a09d225b0.png)


# Resource attribute reference

This section details the attributes that you can add to a resource to control additional behaviors and relationships.

### CreationPolicy
CreationPolicy only applies to three resources AWS::AppStream::Fleet, AWS::AutoScaling::AutoScalingGroup, AWS::EC2::Instance, AWS::CloudFormation::WaitCondition

Primary purpose of CreationPolicy is to wait for "signals" from instances. When you create an instance using CFN, you can add your bootstrap scripts to User Data. For example, install some packages, setup some config files. CFN does not check if the bootstrap script execute successful. This is problematic, because your bootstrap script may fail, and you will not know about this until too late. To overcome this issue you can add CreationPolicy to the instance so that it waits for cfn-signal from the instance. With this, your bootstrap script can signal to CFN that the script executed successful.

### DependsOn
Primary purpose of DependsOn is relative ordering of resource creation in CFN. By its nature, CFN attempts to creates resources in parallel. This can lead to issues, if for example your instance requires some other resource to be created beforehand (e.g. RDS database). In this case, you can tell CFN to create the instance only after the RDS database was successfully created.

### DeletionPolicy
Deleting a stack on CloudFormation also removes all the provisioned resources in it. In some cases, you want some resources to be retained even after deleting its stack. The good thing is that you can do this by defining its DeletionPolicy.

This is pretty straightforward – you just need to define DeletionPolicy with Retain value and for the resources that support snapshot, (like RDS databases) you can set Snapshot as its value. With DeletionPolicy: Snapshot, a snapshot is created before a resource is deleted. This allows you to have a backup of the resource that’s been deleted from the stack.

Let’s say for example that you want to delete a deployed application. This app uses S3 for storing its object and RDS as its database, and you want to keep a copy of this resource as your reference. You may want to update its stack and add DeletionPolicy: Retain for S3 and DeletionPolicy: Snapshot for RDS before deleting it.

### UpdatePolicy

Use the UpdatePolicy attribute to specify how AWS CloudFormation handles updates to the following resources:

AWS::AutoScaling::AutoScalingGroup,  
AWS::ElastiCache::ReplicationGroup  
AWS::Elasticsearch::Domain  
AWS::Lambda::Alias  

### UpdateReplacePolicy attribute:

When you initiate a stack update, AWS CloudFormation updates resources based on differences between what you submit and the stack's current template and parameters. If you update a resource property that requires that the resource be replaced, AWS CloudFormation recreates the resource during the update. Recreating the resource generates a new physical ID.

AWS CloudFormation creates the replacement resource first, and then changes references from other dependent resources to point to the replacement resource.
I.E. You can apply the UpdateReplacePolicy attribute to any resource. UpdateReplacePolicy is only executed if you update a resource property whose update behavior is specified as Replacement, thereby causing AWS CloudFormation to replace the old resource with a new one with a new physical ID. For example, if you update the Engine property of an AWS::RDS::DBInstance resource type, AWS CloudFormation creates a new resource and replaces the current DB instance resource with the new one. The UpdateReplacePolicy attribute would then dictate whether AWS CloudFormation deleted, retained, or created a snapshot of the old DB instance. The update behavior for each property of a resource is specified in the reference topic for that resource in the AWS Resource and Property Types Reference. For more information on resource update behavior, see Update Behaviors of Stack Resources.
BE AWARE OF the UpdateReplacePolicy is not a resource property but it is a parameter of the logic resource. ( it must not go under the property section)
The following snippet contains an Amazon RDS database instance resource with a Retain policy for replacement. When this resource is replaced with a new resource with a new physical ID, AWS CloudFormation leaves the old database instance without deleting it.
    AWSTemplateFormatVersion: 2010-09-09
    Resources:
      myDB:
        Type: 'AWS::RDS::DBInstance'
        DeletionPolicy: Retain
        UpdateReplacePolicy: Retain
        Properties: {} 
Options
Retain AWS CloudFormation keeps the resource without deleting the resource or its contents when the resource is replaced. You can add this policy to any resource type. Note that resources that are retained continue to exist and continue to incur applicable charges until you delete those resources.
If a resource is replaced, the UpdateReplacePolicy retains the old physical resource but removes it from AWS CloudFormation's scope.

# Authorization and Access Control
You can use IAM with AWS CloudFormation to control what users can do with AWS CloudFormation, such as whether they can view stack templates, create stacks, or delete stacks.

In addition to AWS CloudFormation actions, you can manage what AWS services and resources are available to each user.

That way, you can control which resources users can access when they use AWS CloudFormation.

For example, you can specify which users can create Amazon EC2 instances, terminate database instances, or update VPCs. Those same permissions are applied anytime they use AWS CloudFormation to do those actions.
