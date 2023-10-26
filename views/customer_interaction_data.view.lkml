# The name of this view in Looker is "Customer Interaction Data"
view: customer_interaction_data {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `cdp-demo-395508.retail_analytic.customer_interaction_data` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Campaign ID" in Explore.

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.Campaign_ID ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.Clicks ;;
  }

  dimension: conversions {
    type: number
    sql: ${TABLE}.Conversions ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.Customer_ID ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.Product_ID ;;
  }

  dimension: transaction_amount {
    type: number
    sql: ${TABLE}.Transaction_Amount ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_transaction_amount {
    type: sum
    sql: ${transaction_amount} ;;  }
  measure: average_transaction_amount {
    type: average
    sql: ${transaction_amount} ;;  }

  measure: count {
    type: count
    drill_fields: [customer_id, customer_demographic_data.first_name, customer_demographic_data.last_name, customer_demographic_data.age, customer_demographic_data.location, transaction_amount,  customer_demographic_data.email]
  }

  measure: total_conversions {
    type: sum
    sql: ${conversions} ;;  }

  measure: total_clicks {
    type: sum
    sql: ${clicks} ;;  }
}
