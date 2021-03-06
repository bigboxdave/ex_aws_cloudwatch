defmodule ExAws.Cloudwatch.IntegrationTest do
  use ExUnit.Case, async: true

  test "check describe_alarams is successful" do
    {:ok, %{body: %{alarms: alarms}}} = ExAws.Cloudwatch.describe_alarms() |> ExAws.request
    assert is_list(alarms)
  end

  test "check put_metric_data is successful" do
    metric_data = [
      %{
        metric_name: "My Metric Name",
        value: 1,
        timestamp: DateTime.utc_now(),
        dimensions: %{
          "MyDim1" => "DimValue1",
          "MyDim2" => "DimValue2"
        },
        unit: "Count"
      }
    ]

    {:ok, result} = metric_data
                 |> ExAws.Cloudwatch.put_metric_data("Test Namespace")
                 |> ExAws.request()
    assert %{body: %{request_id: _}} = result
  end

  test "check list_metric is successful" do
    {:ok, %{body: %{metrics: metrics}}} = ExAws.Cloudwatch.list_metrics() |> ExAws.request()
    assert is_list(metrics)
  end
end
