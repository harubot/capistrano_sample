json.array!(@my_models) do |my_model|
  json.extract! my_model, :id, :field1, :field2, :field3, :field4
  json.url my_model_url(my_model, format: :json)
end
