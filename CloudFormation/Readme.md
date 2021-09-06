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

  "Metadata" : {
    template metadata
  },

  "Parameters" : {
    set of parameters
  },
  
  "Rules" : {
    set of rules
  },

  "Mappings" : {
    set of mappings
  },

  "Conditions" : {
    set of conditions
  },

  "Transform" : {
    set of transforms
  },

  "Resources" : {
    set of resources
  },
  
  "Outputs" : {
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

#### Format Version (optional)
The AWS CloudFormation template version that the template conforms to. The template format version isn't the same as the API or WSDL version. The template format version can change independently of the API and WSDL versions.

#### Description (optional)
A text string that describes the template. This section must always follow the template format version section.

#### Metadata (optional)
Objects that provide additional information about the template.

#### Parameters (optional)
Values to pass to your template at runtime (when you create or update a stack). You can refer to parameters from the Resources and Outputs sections of the template.

#### Rules (optional)
Validates a parameter or a combination of parameters passed to a template during a stack creation or stack update.

#### Mappings (optional)
A mapping of keys and associated values that you can use to specify conditional parameter values, similar to a lookup table. You can match a key to a corresponding value by using the Fn::FindInMap intrinsic function in the Resources and Outputs sections.

#### Conditions (optional)
Conditions that control whether certain resources are created or whether certain resource properties are assigned a value during stack creation or update. For example, you could conditionally create a resource that depends on whether the stack is for a production or test environment.

#### Transform (optional)
For serverless applications (also referred to as Lambda-based applications), specifies the version of the AWS Serverless Application Model (AWS SAM) to use. When you specify a transform, you can use AWS SAM syntax to declare resources in your template. The model defines the syntax that you can use and how it's processed.

You can also use AWS::Include transforms to work with template snippets that are stored separately from the main AWS CloudFormation template. You can store your snippet files in an Amazon S3 bucket and then reuse the functions across multiple templates.

#### Resources (required)
Specifies the stack resources and their properties, such as an Amazon Elastic Compute Cloud instance or an Amazon Simple Storage Service bucket. You can refer to resources in the Resources and Outputs sections of the template.

#### Outputs (optional)
Describes the values that are returned whenever you view your stack's properties. For example, you can declare an output for an S3 bucket name and then call the aws cloudformation describe-stacks AWS CLI command to view the name.


# Stacks
When you use CloudFormation, you manage related resources as a single unit called a stack. You create, update, and delete a collection of resources by creating, updating, and deleting stacks. All the resources in a stack are defined by the stack's CloudFormation template. To create those resources, you create a stack by submitting the template that you created, and CloudFormation provisions all those resources for you.

# Change sets
If you need to make changes to the running resources in a stack, you update the stack. Before making changes to your resources, you can generate a change set, which is a summary of your proposed changes. Change sets allow you to see how your changes might impact your running resources, especially for critical resources, before implementing them

# How does AWS CloudFormation work?

CloudFormation uploads it to an S3 bucket in your AWS account even if you stored template file in local system,. CloudFormation creates a bucket for each region in which you upload a template file. 

The buckets are accessible to anyone with Amazon Simple Storage Service (Amazon S3) permissions in your AWS account. If a bucket created by CloudFormation is already present, the template is added to that bucket.

You can use your own bucket and manage its permissions by manually uploading templates to Amazon S3. Then whenever you create or update a stack, specify the Amazon S3 URL of a template file.

![image](https://user-images.githubusercontent.com/41946619/132156847-71178fde-3509-4d7f-8e00-f87a09d225b0.png)
