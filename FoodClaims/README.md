# Purpose of Report
A report shows how long it takes to reply to customers and close claims compesation about food poisoning of a Brazillian fast food chain

# Background
Vivendo is a fast food chain in Brazil with over 200 outlets.
Customers often claim compensation from the company for food poisoning.
The legal team processes these claims. The legal team has offices in four locations.
The legal team wants to improve how long it takes to reply to customers and close claims.
The head of the legal department wants a report on how each location differs in the time it
takes to close claims.

# Data
claim_id :       Nominal. The unique identifier of the claim.
                 Missing values are not possible due to the database structure.

time_to_close:   Discrete. The number of days to close the claim. Any positive
                 value. Replace missing values with the overall median time to close.
claim_amount:    Continuous. The initial claim requested in the currency of Brazil, rounded to 2 decimal places.
                 Replace missing values with the overall median claim amount.
amount_paid:     Continuous. Final amount paid. In the currency of Brazil. Rounded to 2 decimal places.
                 Replace missing values with the overall median amount paid.
location:        Nominal. Location of the claim, one of “RECIFE”, “SAO LUIS”, “FORTALEZA”, or “NATAL”.
                 Remove missing values.
individuals_on_claim: Discrete. Number of individuals on this claim. Minimum 1 person. Replace missing value with 0.
linked_cases:    Nominal. Whether this claim is linked to other cases. Either TRUE or FALSE. Replace missing values with FALSE.
cause:           Nominal. Cause of the food poisoning. One of “vegetable”, “meat” or “unknown”. Replace missing values with ‘unknown’.
