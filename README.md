# Driving Organizational Choice in the Right Direction with Hashicorp Sentinel

## Problem:

Too many organizations today have Policies written in Wikis, on paper, or are just tribal knowledge that is shared by team members on a case-to-case basis. This presents the following issues:

- New employees have a hard time getting up to speed on the ins and outs of certain decisions made by the organization
- Costly errors result in down-time across production services
- Documentation becomes rampant with out-dated information
- Cloud services become more expensive due to the over abundance of options to complete organizational deliverables



| Problem                                 | Tool                          | Recommended Sentinel Policy Actions                                                                                                                                                            |   |   |
|-----------------------------------------|-------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---|---|
| Getting Started / Too many alternatives | Reduce number of Alternatives | Use a list of approved services/methods of deployment for the proposed solution with the commons module  of filter_attribute_not_in_list to restrict choices                                   |   |   |
| Decision Inertia                        | Use Defaults                  | Coupling the above of limiting alternatives, restrict deployment policies to Soft-Mandatory enforcements allowing the team to deliberate on the actual usefulness of proposed services/methods |   |   |
|                                         |                               |         