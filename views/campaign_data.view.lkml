# The name of this view in Looker is "Campaign Data"
view: campaign_data {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `cdp-demo-395508.retail_analytic.campaign_data` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Budget" in Explore.

  dimension: budget {
    type: number
    sql: ${TABLE}.Budget ;;
  }

  dimension: campaign_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.Campaign_ID;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.Campaign_Name ;;
  }

  dimension: campaign_name_sorted {
    type: number
    sql:
      CASE
        WHEN ${TABLE}.Campaign_Name = 'Gebyar Promo 1' THEN 1
        WHEN ${TABLE}.Campaign_Name = 'Gebyar Promo 2' THEN 2
        WHEN ${TABLE}.Campaign_Name = 'Gebyar Promo 3' THEN 3
        WHEN ${TABLE}.Campaign_Name = 'Gebyar Promo 4' THEN 4
        WHEN ${TABLE}.Campaign_Name = 'Gebyar Promo 5' THEN 5
        WHEN ${TABLE}.Campaign_Name = 'Gebyar Promo 6' THEN 6
        WHEN ${TABLE}.Campaign_Name = 'Gebyar Promo 7' THEN 7
        WHEN ${TABLE}.Campaign_Name = 'Gebyar Promo 8' THEN 8
        WHEN ${TABLE}.Campaign_Name = 'Gebyar Promo 9' THEN 9
        ELSE 10
      END ;;
    hidden: yes
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.Clicks ;;
  }

  dimension: conversions {
    type: number
    sql: ${TABLE}.Conversions ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.Cost ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_cost {
    type: sum
    sql: ${cost} ;;  }
  measure: average_cost {
    type: average
    sql: ${cost} ;;  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.End_Date ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.Impressions ;;
  }


  dimension: revenue_generated {
    type: number
    sql: ${TABLE}.Revenue_Generated ;;
  }

  dimension_group: start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Start_Date ;;
  }

  dimension: ROI {
    type: number
    sql: (${revenue_generated} - ${cost}) / NULLIF(${cost}, 0) ;;
    value_format: "0.00%"
  }

  measure: count {
    type: count
    drill_fields: [campaign_name]
  }
  measure: total_revenue {
    type: sum
    sql: ${revenue_generated} ;;
  }

  measure: total_click {
    type: sum
    sql: ${clicks} ;;
  }

  measure: total_budget {
    type: sum
    sql: ${budget} ;;
  }
  measure: total_conversion {
    type: sum
    sql: ${conversions} ;;
  }

  dimension: ctr {
    type: number
    sql: (CAST(${clicks} AS float) / ${impressions}) * 100 ;;
  }
}
