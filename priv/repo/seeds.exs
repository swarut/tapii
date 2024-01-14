# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tapii.Repo.insert!(%Tapii.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Tapii.Repo.delete_all(Tapii.QueryEngines.QueryTemplateGroup)

{:ok, tpg} = Tapii.QueryEngines.create_query_template_group(%{
  name: "Tenjin - elearning SLO"
})

{:ok, tp} = Tapii.QueryEngines.create_query_template(%{
  name: "Tenjin - role_assignment_elearning queue size",
  query_template_group_id: tpg.id,
  query: """
  "tenjin-production" "[SIDEKIQ_CLOUDWATCH_HELPER]" "role_assignment_elearning"
  | parse "'role_assignment_elearning': *" as queue_size
  | timeslice 1m
  | max(queue_size) as mq by _timeslice
  | order by _timeslice desc
  """
})

{:ok, tp2} = Tapii.QueryEngines.create_query_template(%{
  name: "Tenjin - course_mapping_elearning queue size",
  query_template_group_id: tpg.id,
  query: """
  "tenjin-production" "[SIDEKIQ_CLOUDWATCH_HELPER]" "course_mapping_elearning"
  | parse "'course_mapping_elearning': *" as queue_size
  | timeslice 1m
  | max(queue_size) as mq by _timeslice
  | order by _timeslice desc
  """
})

{:ok, tp3} = Tapii.QueryEngines.create_query_template(%{
  name: "Tenjin - course_mapping_elearning queue size",
  query_template_group_id: tpg.id,
  query: """
  "tenjin-production"
  "eLearning Calculation finished successfully"
  | json "data.context_uri" as context_uri
  | timeslice 1m
  | count by _timeslice, context_uri
  """
})

Tapii.Schedulers.create_scheduler(%{
  active: true,
  query_template_id: tp.id,
  occurence: 1,
  schedule_time: "19:30:00"
})

Tapii.Schedulers.create_scheduler(%{
  active: true,
  query_template_id: tp2.id,
  occurence: 1,
  schedule_time: "19:30:00"
})

Tapii.Schedulers.create_scheduler(%{
  active: true,
  query_template_id: tp3.id,
  occurence: 1,
  schedule_time: "19:30:00"
})
