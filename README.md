# Driving Organizational Choice in the Right Direction with Hashicorp Sentinel


# Choice Architecture

>“Decision makers do not make choices in a vacuum. They make them in an environment where many features, noticed and unnoticed, can influence their decisions. The Person who creates that environment is, in our terminology, a choice architect.”
Richard Thaler
Cass Sunstein
John Balz

Choice architecture is about considering, and creating, an environment that guides those who choose into the desired choices of the architect. 

There are a number of ways to accomplish this architecture, of which, two are explored in this repo:

- Default Choices
- Nudges

## Default Choice

> “For reasons of laziness, fear, and distraction, many people will take whatever option requires the least effort, or path of least resistance. All these forces imply that if, for a given choice, there is a default option - an option that will obtain if the chooser does nothing - then we can expect a large number of people to end up with that option, whether or not it is good for them.” 
Richard Thaler
Cass Sunstein
John Balz




## Problem:

Too many organizations today have Policies written in Wikis, on paper, or are just tribal knowledge that is shared by team members on a case-to-case basis. This presents the following issues:

- New employees have a hard time getting up to speed on the ins and outs of certain decisions made by the organization
- Costly errors result in down-time across production services
- Documentation becomes rampant with out-dated information
- Cloud services become more expensive due to the o

### Solution

The solution to such problems isn't found in controlled IaM policies (some is better than none of course) but rather in the tools that can guide desired behavior in the right direction either nudgingly, or by default.

## Policy As Code

What is Policy As Code?

Policy as Code is an implementation of organizational policies (such as no use of AWS' EC2 instances) in code form. If you're familiar with Infrastructure As Code (IaC), Policy as Code provides all the same benefits. Namely:

- Codification
- Version Control
- Testing
- Automation

### Hashicorp Sentinel

Sentinel is a high-level language built to manage and automate policies by incorporating all of the above benefits into simple text files.

| Problem                                 | Tool                          | Recommended Sentinel Policy Actions                                                                                                                                                            |   |   |
|-----------------------------------------|-------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---|---|
| Getting Started / Too many alternatives | Reduce number of Alternatives | Use a list of approved services/methods of deployment for the proposed solution with the commons module  of filter_attribute_not_in_list to restrict choices                                   |   |   |
| Decision Inertia                        | Use Defaults                  | Coupling the above of limiting alternatives, restrict deployment policies to Soft-Mandatory enforcements allowing the team to deliberate on the actual usefulness of proposed services/methods |   |   |
|                                         |                               |         