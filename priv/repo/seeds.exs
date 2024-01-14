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
  name: "Tenjin"
})

{:ok, tp} = Tapii.QueryEngines.create_query_template(%{
  name: "Tenjin - role_assignment_elearning queue size",
  query_template_group_id: tpg.id,
  query: """
  (_sourceName=ecs-tenjin-production-*web* AND "\"New request from a remote host\"") OR _sourceName=ecs-tenjin-production-*web* and "request queue full"
  | json "data.remote_mauth_uuid" as service nodrop
  | parse "Returning HTTP * due to" as error nodrop
  | lookup mauth_app_name as app_name from path://"/Library/Users/sleeloy@mdsol.com/mauthapps" on mauth_app_uuid=service
  | if (isNull(app_name) and error = "503", "tenjin_req_queue_full", app_name) as app_name
  | where app_name <> "Checkmate" and !(isBlank(service) and isBlank(app_name))
  | timeslice 5m
  | count by _timeslice, app_name
  | transpose row _timeslice column app_name
  """
})
Tapii.Schedulers.create_scheduler(%{
  active: true,
  query_template_id: tp.id,
  occurence: 1,
  schedule_time: "19:30:00"
})

{:ok, tp} = Tapii.QueryEngines.create_query_template(%{
  name: "Incoming Request by Endpoints",
  query_template_group_id: tpg.id,
  query: """
  _sourceName=ecs-tenjin-production-*
  | parse "\"message\":\"Started * \\\"/v1/*\\\"" as action,url
  | if (url matches /assigned/, "assigned_courses",
    if (url matches /courses\/\w*/, "courses-show",
    if (url matches /course_completions/, "course_completions",
    if (url matches /course_compliance_calculations/, "course_compliance_calculations",
    if (url matches /course_mappings\/batch/, "course_mappings/batch",
    if (url matches /course_mappings\/update_by_context_and_course/, "course_mappings/update_by_context_and_course",
    if (url matches /course_mappings\/delete_by_app_role/, "course_mappings/delete_by_app_role",
    if (url matches /courses_client_division_schemes/, "courses_client_division_schemes",
    if (url matches /course_overrides/, "course_overrides",
    if (url matches /course_progress/, "course_progress",
    if (url matches /course_mappings/, "course_mappings",
    if (url matches /courses/, "courses", "N/A")))))))))))) as endpoint
  | timeslice 5m
  | count by _timeslice, endpoint
  | order _timeslice asc
  | transpose row _timeslice column endpoint
  """
})
Tapii.Schedulers.create_scheduler(%{
  active: true,
  query_template_id: tp.id,
  occurence: 1,
  schedule_time: "19:30:00"
})

{:ok, tp} = Tapii.QueryEngines.create_query_template(%{
  name: "Course mapping activities distribution (KTRP)",
  query_template_group_id: tpg.id,
  query: """
  ("Started POST \\\"/v1/course_mappings\\" AND _sourceName=ecs-tenjin-production-web-*) OR
  ("/v1/course_mappings/update_by_context_and_course" AND _sourceName=ecs-tenjin-production-web-*) OR
  ("/v1/course_mappings/delete_by_app_role" AND _sourceName=ecs-tenjin-production-web-*)
  | if (message matches /Started POST/, "create", if (message matches /update_by_context_and_course/, "update", if (message matches /delete_by_app_role/, "delete", "N/A")) ) as action
  | timeslice 5m
  | count by _timeslice, action
  | order _timeslice asc
  | transpose row _timeslice column action
  """
})
Tapii.Schedulers.create_scheduler(%{
  active: true,
  query_template_id: tp.id,
  occurence: 1,
  schedule_time: "19:30:00"
})

{:ok, tp} = Tapii.QueryEngines.create_query_template(%{
  name: "Course mapping activities distribution (new UI)",
  query_template_group_id: tpg.id,
  query: """
  _sourceName=ecs-tenjin-production-web-* ("Started POST \\\"/v1/course_mappings/batch\\") OR
  ("Started PUT \\\"/v1/course_mappings/batch\\") OR
  ("Started DELETE \\\"/v1/course_mappings/batch\\")
  | if (message matches /Started POST/, "create", if (message matches /Started PUT/, "update", if (message matches /Started DELETE/, "delete", "delete")) ) as action
  | timeslice 5m
  | count by _timeslice, action
  | order _timeslice asc
  | transpose row _timeslice column action
  """
})
Tapii.Schedulers.create_scheduler(%{
  active: true,
  query_template_id: tp.id,
  occurence: 1,
  schedule_time: "19:30:00"
})

{:ok, tp} = Tapii.QueryEngines.create_query_template(%{
  name: "Course Override activity distribution",
  query_template_group_id: tpg.id,
  query: """
  ("Started POST \\\"/v1/course_overrides" AND _sourceName=ecs-tenjin-production-web-*) OR
  ("Started DELETE \\\"/v1/course_overrides" AND _sourceName=ecs-tenjin-production-web-*)
  | if (message matches /Started POST/, "create", if (message matches /Started DELETE/, "delete", "N/A")) as action
  | timeslice 5m
  | count by _timeslice, action
  | order _timeslice asc
  | transpose row _timeslice column action
  """
})
Tapii.Schedulers.create_scheduler(%{
  active: true,
  query_template_id: tp.id,
  occurence: 1,
  schedule_time: "19:30:00"
})

{:ok, tp} = Tapii.QueryEngines.create_query_template(%{
  name: "Course Progress Activity",
  query_template_group_id: tpg.id,
  query: """
  "Started PUT \\\"/v1/course_progress\\" and "tenjin-production"
  | timeslice 5m
  | count by _timeslice
  """
})
Tapii.Schedulers.create_scheduler(%{
  active: true,
  query_template_id: tp.id,
  occurence: 1,
  schedule_time: "19:30:00"
})

{:ok, tp} = Tapii.QueryEngines.create_query_template(%{
  name: "Course Completion Activity",
  query_template_group_id: tpg.id,
  query: """
  "Started POST \\\"/v1/course_completions" and "tenjin-production"
  | if (message matches /Started POST/, "create", "N/A") as action
  | timeslice 5m
  | count by _timeslice, action
  | order _timeslice asc
  | transpose row _timeslice column action
  """
})
Tapii.Schedulers.create_scheduler(%{
  active: true,
  query_template_id: tp.id,
  occurence: 1,
  schedule_time: "19:30:00"
})

{:ok, tp} = Tapii.QueryEngines.create_query_template(%{
  name: "eLearning Compliance Activities",
  query_template_group_id: tpg.id,
  query: """
  ("course_compliance_calculation" and "tenjin-production")
  | timeslice 5m
  | count by _timeslice
  """
})
Tapii.Schedulers.create_scheduler(%{
  active: true,
  query_template_id: tp.id,
  occurence: 1,
  schedule_time: "19:30:00"
})
