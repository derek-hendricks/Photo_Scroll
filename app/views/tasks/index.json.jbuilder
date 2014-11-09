json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :description, :duration, :due_date, :complete
  json.url task_url(task, format: :json)
end
