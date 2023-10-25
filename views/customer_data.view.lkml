# The name of this view in Looker is "Customer Data"

map_layer: identifier {
  file: "/indonesia.geojson"
}

view: customer_data {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `cdp-demo-395508.retail_analytic.customer_data` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Age" in Explore.

  dimension: age {
    type: number
    sql: ${TABLE}.Age ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_age {
    type: sum
    sql: ${age} ;;  }
  measure: average_age {
    type: average
    sql: ${age} ;;  }

  dimension: customer_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.Customer_ID ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.Email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.First_Name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.Gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.Last_Name ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.Location ;;
  }

  dimension: location_geo {
    type: string
    map_layer_name: identifier    # this is your map layer
    sql: upper(${TABLE}.Location);;
  }

  measure: count {
    type: count
    drill_fields: [first_name, last_name]
  }

}
