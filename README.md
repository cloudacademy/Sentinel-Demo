# Driving Organizational Choice in the Right Direction with Hashicorp Sentinel

This repo accompanies a webinar given for CloudOps Summit on 2/10/21

This talk was given as an introductory glance at Hashicorp's Policy as Code tool, Sentinel.


## Problem:

Too many organizations today have Policies written in Wikis, on paper, or are just tribal knowledge that is shared by team members on a case-to-case basis. This presents the following issues:

- New employees have a hard time getting up to speed on the ins and outs of certain decisions made by the organization
- Costly errors result in down-time across production services
- Documentation becomes rampant with out-dated information, or no information at all
- Cloud services become more expensive due to the over abundance of services to solve business problems

### Solution

The solution to such problems isn't found in controlled IaM policies (some is better than none of course) but rather in the tools that can guide desired behavior in the right direction either nudgingly, or by default. Of which Sentinel deploys the default choice rather well, and leaves the nudges up to the policy designer.

## Policy As Code

What is Policy As Code?

Policy as Code is an implementation of organizational policies (such as no use of AWS' EC2 instances) in code form. If you're familiar with Infrastructure As Code (IaC), Policy as Code provides all the same benefits. Namely:

- Codification
- Version Control
- Testing
- Automation

### Hashicorp Sentinel

Sentinel is a high-level language built to manage and automate policies by incorporating all of the above benefits into simple text files.

Example Policies can be found in /policies/sentinel/example_policies 
Comments include explanations.

# Choice Architecture

Choice architecture is about considering, and creating, an environment that guides those who choose into the desired choices of the architect. 

There are a number of ways to accomplish this architecture, of which, two are explored:

- Default Choices
- Nudges

## Default Choice (considered a nudge)

> “For reasons of laziness, fear, and distraction, many people will take whatever option requires the least effort, or path of least resistance. All these forces imply that if, for a given choice, there is a default option - an option that will obtain if the chooser does nothing - then we can expect a large number of people to end up with that option, whether or not it is good for them.” 
Richard Thaler
Cass Sunstein
John Balz

## Nudges 

>“Decision makers do not make choices in a vacuum. They make them in an environment where many features, noticed and unnoticed, can influence their decisions. The Person who creates that environment is, in our terminology, a choice architect.”
Richard Thaler
Cass Sunstein
John Balz

- Expectation of Errors
  - Common mistakes people might make when committing an action. The expectation of an error is such that no matter what mistake they make, they make the desired outcome.
  - Often employs a _forcing function_ causing the person to do something before moving on to the desired state.
- Mappings
  - A way for people to make decisions by making information easier to  understand for their use case.
  - Internet companies often do this when explaining data caps to consumers. E.g. "You have a cap of 200 high-def movies"
- Complex Choice Structuring
  - The strategy involved in taking larger sample sizes of choices and continuously boiling them down through to a substrate of choices.
  - E.g. Mobile apps often ask you what you're looking for in the app when you install, slowly putting you into the category they, and you, want to be in.

### Common Issues and Sentinel Policy Suggestions

These are simply suggestions, at the end of the day, designing a policy to best fit your organization's goals is always the recommended action.

| Problem                                 | Tool                          | Recommended Sentinel Policy Actions                                                                                                                                                            |   |   |
|-----------------------------------------|-------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---|---|
| Getting Started / Too many alternatives | Reduce number of Alternatives | Use a list of approved services/methods of deployment for the proposed solution with the commons module  of filter_attribute_not_in_list to restrict choices                                   |   |   |
| Decision Inertia                        | Use Defaults                  | Coupling the above of limiting alternatives, restrict deployment policies to Soft-Mandatory enforcements allowing the team to deliberate on the actual usefulness of proposed services/methods |   |   |
| Procrastination                         | Satisfice                     | Have a standard of testing the bare minimum Sentinel policy actions that allow teams to still move forward in their deliverance                                                                |   |   |

### Examples

If you'd like to see a pure example of a Sentinel Policy in action, download the Sentinel CLI:

- Mac: https://releases.hashicorp.com/sentinel/0.17.4/sentinel_0.17.4_darwin_amd64.zip
- Windows: https://releases.hashicorp.com/sentinel/0.17.4/sentinel_0.17.4_windows_amd64.zip
- Linux: https://releases.hashicorp.com/sentinel/0.17.4/sentinel_0.17.4_linux_amd64.zip
- FreeBSD: https://releases.hashicorp.com/sentinel/0.17.4/sentinel_0.17.4_freebsd_amd64.zip
- NetBSD: https://releases.hashicorp.com/sentinel/0.17.4/sentinel_0.17.4_netbsd_amd64.zip
- OpenBSD: https://releases.hashicorp.com/sentinel/0.17.4/sentinel_0.17.4_openbsd_amd64.zip
- Solaris: https://releases.hashicorp.com/sentinel/0.17.4/sentinel_0.17.4_solaris_amd64.zip

Extract it and put it in your path.

Ensure it is installed:

```
sentinel --version
```

Clone this Repo and navigate to /policies/sentinel
```
git clone https://github.com/tsarlewey/Sentinel-Demo
```

Execute the sentinel test command with the following arguments to see what the policy looks like with proper testing conditions
```
sentinel test --run=kubernetes --verbose
```

Examine the output:

```
Installing test modules for test/kubernetes_namespace_check/fail.json
  - Module tfplan-functions marked for installation
Installation complete for test/kubernetes_namespace_check/fail.json
Installing test modules for test/kubernetes_namespace_check/pass.json
  - Module tfplan-functions marked for installation
Installation complete for test/kubernetes_namespace_check/pass.json

PASS - kubernetes_namespace_check.sentinel
  PASS - test/kubernetes_namespace_check/fail.json


    logs:
      kubernetes_deployment.webserver-fail has metadata.0.namespace with value testing-server that does not have the prefix prod-
    trace:
      Print messages:

      kubernetes_deployment.webserver-fail has metadata.0.namespace with value testing-server that does not have the prefix prod-

      kubernetes_namespace_check.sentinel:29:1 - Rule "main"
        Description:
          Ensure the violations are zero

        Value:
          false

    legacy warning:
      test case uses legacy config, please migrate it to an HCL configuration.
  PASS - test/kubernetes_namespace_check/pass.json

    trace:
      kubernetes_namespace_check.sentinel:29:1 - Rule "main"
        Description:
          Ensure the violations are zero

        Value:
          true

    legacy warning:
      test case uses legacy config, please migrate it to an HCL configuration.
```


You'll notice that it installs modules first that were specified for the policy and the mock files. Includes the passing conditions for the fail.json and pass.json
Finally it prints out any log messages and the Value of the fail.json or pass.json testing conditions.

The description for these policies is a poor description, try altering it and running the above command again to see a different output. It only says that it ensures violations are zero, and we would have to examine the print messages in detail
to understand why the policy is failing/passing.

(It's the top comment above the main variable in the policy)