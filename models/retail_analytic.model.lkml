# Define the database connection to be used for this model.
connection: "cdp_demo_connection"

# include all the views
include: "/views/**/*.view.lkml"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: retail_analytic_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: retail_analytic_default_datagroup

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Retail Analytic"

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.

explore: campaign_data {}

explore: customer_data {}

explore: product_data {}

explore: customer_interaction_data {

  join: campaign_data {
    type: full_outer
    relationship: many_to_one
    sql_on: ${campaign_data.campaign_id}=${customer_interaction_data.campaign_id} ;;
  }

  join: customer_data {
    type: full_outer
    relationship: many_to_one
    sql_on: ${customer_data.customer_id}=${customer_interaction_data.customer_id} ;;
  }

  join: product_data {
    type: full_outer
    relationship: many_to_one
    sql_on: ${product_data.product_id}=${customer_interaction_data.product_id} ;;
  }

}
