resource "aws_cloudwatch_dashboard" "shopizer_dashboard" {
  dashboard_name = "shopizer-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      # frontend graphs
      {
        type   = "text"
        x      = 0
        y      = 0
        width  = 24
        height = 1
        properties = {
          markdown = "## Frontend Metric"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [
            ["HTTP_Request", aws_cloudwatch_log_metric_filter.http_latency_fe.name, { "region" : "us-east-1" }]
          ]
          view     = "timeSeries"
          stacked  = false
          title    = "http_latency_FE"
          period   = 60
          stat     = "Average"
          width    = 1500
          height   = 200
          start    = "-PT3H"
          end      = "P0D"
          timezone = "+0700"
          region   = "us-east-1"
        }
      },
      {
        type   = "metric"
        x      = 8
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [
            [{ "expression" : "(m2+m3)/m1*100", "label" : "Expression1", "id" : "e1", "region" : "us-east-1" }],
            [{ "expression" : "m3/m1", "label" : "Expression2", "id" : "e2", "region" : "us-east-1", "visible" : false }],
            ["Frontend_Metric", aws_cloudwatch_log_metric_filter.http_200_fe.name, { "id" : "m1", "visible" : false, "region" : "us-east-1" }],
            [".", aws_cloudwatch_log_metric_filter.http_4xx_fe.name, { "id" : "m2", "visible" : false, "region" : "us-east-1" }],
            [".", aws_cloudwatch_log_metric_filter.http_5xx_fe.name, { "id" : "m3", "visible" : false, "region" : "us-east-1" }]
          ]
          sparkline = true
          view      = "timeSeries"
          stacked   = false
          stat      = "Sum"
          period    = 300
          yAxis = {
            left = {
              min = 0
              max = 100
            }
          }
          title    = "HTTP_Error_percent_FE"
          width    = 1500
          height   = 200
          start    = "-PT3H"
          end      = "P0D"
          timezone = "+0700"
          region   = "us-east-1"
        }
      },
      {
        type   = "metric"
        x      = 16
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [
            ["Frontend_Metric", aws_cloudwatch_log_metric_filter.http_request_fe.name, { "region" : "us-east-1" }]
          ]
          view     = "timeSeries"
          stacked  = false
          period   = 60
          stat     = "Sum"
          title    = "number_http_request_FE"
          width    = 1500
          height   = 200
          start    = "-PT3H"
          end      = "P0D"
          timezone = "+0700"
          region   = "us-east-1"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [for id in var.frontend_instance_ids :
          ["CWAgent", "mem_used_percent", "InstanceId", id, { "region" : "us-east-1" }]]
          view    = "timeSeries"
          stacked = false
          title   = "Mem_used_percent FE"
          period  = 300
          region  = "us-east-1"
        }
      },
      {
        type   = "metric"
        x      = 8
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [
            for instance_id in var.frontend_instance_ids :
            ["CWAgent", "disk_used_percent", "InstanceId", instance_id, { "region" : "us-east-1" }]
          ]
          view     = "timeSeries"
          stacked  = false
          title    = "Disk_used_percent FE"
          period   = 300
          width    = 1500
          height   = 200
          start    = "-PT3H"
          end      = "P0D"
          timezone = "+0700"
          region   = "us-east-1"
        }
      },
      {
        type   = "metric"
        x      = 16
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [
            for instance_id in var.frontend_instance_ids :
            ["AWS/EC2", "CPUUtilization", "InstanceId", instance_id, { "region" : "us-east-1" }]
          ]
          view     = "timeSeries"
          stacked  = false
          title    = "CPUUtilization FE"
          period   = 300
          width    = 1500
          height   = 200
          start    = "-PT3H"
          end      = "P0D"
          timezone = "+0700"
          region   = "us-east-1"
        }
      },
      # admin graphs
      {
        type   = "text"
        x      = 0
        y      = 0
        width  = 24
        height = 1
        properties = {
          markdown = "## Admin Metric"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [
            ["Frontend_Metric", aws_cloudwatch_log_metric_filter.http_latency_adm.name, { "region" : "us-east-1" }]
          ]
          view     = "timeSeries"
          stacked  = false
          title    = "http_latency_adm"
          period   = 60
          stat     = "Average"
          width    = 1500
          height   = 200
          start    = "-PT3H"
          end      = "P0D"
          timezone = "+0700"
          region   = "us-east-1"
        }
      },
      {
        type   = "metric"
        x      = 8
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [
            [{ "expression" : "(m2+m3)/m1*100", "label" : "Expression1", "id" : "e1", "region" : "us-east-1" }],
            [{ "expression" : "m3/m1", "label" : "Expression2", "id" : "e2", "region" : "us-east-1", "visible" : false }],
            ["Frontend_Metric", aws_cloudwatch_log_metric_filter.http_200_fe.name, { "id" : "m1", "visible" : false, "region" : "us-east-1" }],
            [".", aws_cloudwatch_log_metric_filter.http_4xx_adm.name, { "id" : "m2", "visible" : false, "region" : "us-east-1" }],
            [".", aws_cloudwatch_log_metric_filter.http_5xx_adm.name, { "id" : "m3", "visible" : false, "region" : "us-east-1" }]
          ]
          sparkline = true
          view      = "timeSeries"
          stacked   = false
          stat      = "Sum"
          period    = 300
          yAxis = {
            left = {
              min = 0
              max = 100
            }
          }
          title    = "HTTP_Error_percent_adm"
          width    = 1500
          height   = 200
          start    = "-PT3H"
          end      = "P0D"
          timezone = "+0700"
          region   = "us-east-1"
        }
      },
      {
        type   = "metric"
        x      = 16
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [
            ["Frontend_Metric", aws_cloudwatch_log_metric_filter.http_request_adm.name, { "region" : "us-east-1" }]
          ]
          view     = "timeSeries"
          stacked  = false
          period   = 60
          stat     = "Sum"
          title    = "number_http_request_adm"
          width    = 1500
          height   = 200
          start    = "-PT3H"
          end      = "P0D"
          timezone = "+0700"
          region   = "us-east-1"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [for id in var.admin_instance_ids :
          ["CWAgent", "mem_used_percent", "InstanceId", id, { "region" : "us-east-1" }]]
          view    = "timeSeries"
          stacked = false
          title   = "Mem_used_percent adm"
          period  = 300
          region  = "us-east-1"
        }
      },
      {
        type   = "metric"
        x      = 8
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [
            for instance_id in var.admin_instance_ids :
            ["CWAgent", "disk_used_percent", "InstanceId", instance_id, { "region" : "us-east-1" }]
          ]
          view     = "timeSeries"
          stacked  = false
          title    = "Disk_used_percent adm"
          period   = 300
          width    = 1500
          height   = 200
          start    = "-PT3H"
          end      = "P0D"
          timezone = "+0700"
          region   = "us-east-1"
        }
      },
      {
        type   = "metric"
        x      = 16
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [
            for instance_id in var.admin_instance_ids :
            ["AWS/EC2", "CPUUtilization", "InstanceId", instance_id, { "region" : "us-east-1" }]
          ]
          view     = "timeSeries"
          stacked  = false
          title    = "CPUUtilization adm"
          period   = 300
          width    = 1500
          height   = 200
          start    = "-PT3H"
          end      = "P0D"
          timezone = "+0700"
          region   = "us-east-1"
        }
      },
      # backend graphs
      {
        type   = "text"
        x      = 0
        y      = 0
        width  = 24
        height = 1
        properties = {
          markdown = "## Backend Metric"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [
            [{ "expression" : "m2/m1*100", "label" : "Expression1", "id" : "m3", "region" : "us-east-1" }],
            ["Backend_Metric", aws_cloudwatch_log_metric_filter.http_request_be.name, { "region" : "us-east-1", "id" : "m1", "visible" : false }],
            [".", aws_cloudwatch_log_metric_filter.http_request_error.name, { "region" : "us-east-1", "id" : "m2", "visible" : false }]
          ]
          view     = "timeSeries"
          stacked  = false
          stat     = "Sum"
          period   = 60
          title    = "HTTP_Error_percent_BE"
          width    = 1695
          height   = 200
          start    = "-PT3H"
          end      = "P0D"
          timezone = "+0700"
          region   = "us-east-1"
        }
      },
      {
        type   = "metric"
        x      = 8
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [
            ["Backend_Metric", aws_cloudwatch_log_metric_filter.number_exception.name, { "region" : "us-east-1" }]
          ]
          view     = "timeSeries"
          stacked  = false
          period   = 60
          stat     = "Sum"
          title    = "number_exception_BE"
          width    = 1695
          height   = 200
          start    = "-PT3H"
          end      = "P0D"
          timezone = "+0700"
          region   = "us-east-1"
        }
      },
      {
        type   = "metric"
        x      = 16
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [for id in var.backend_instance_ids :
          ["CWAgent", "mem_used_percent", "InstanceId", id, { "region" : "us-east-1" }]]
          view    = "timeSeries"
          stacked = false
          title   = "Mem_used_percent adm"
          period  = 300
          region  = "us-east-1"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [
            for instance_id in var.backend_instance_ids :
            ["CWAgent", "disk_used_percent", "InstanceId", instance_id, { "region" : "us-east-1" }]
          ]
          view     = "timeSeries"
          stacked  = false
          title    = "Disk_used_percent adm"
          period   = 300
          width    = 1500
          height   = 200
          start    = "-PT3H"
          end      = "P0D"
          timezone = "+0700"
          region   = "us-east-1"
        }
      },
      {
        type   = "metric"
        x      = 8
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [
            for instance_id in var.backend_instance_ids :
            ["AWS/EC2", "CPUUtilization", "InstanceId", instance_id, { "region" : "us-east-1" }]
          ]
          view     = "timeSeries"
          stacked  = false
          title    = "CPUUtilization adm"
          period   = 300
          width    = 1500
          height   = 200
          start    = "-PT3H"
          end      = "P0D"
          timezone = "+0700"
          region   = "us-east-1"
        }
      },
    ]
  })
}
