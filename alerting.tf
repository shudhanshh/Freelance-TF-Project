resource "google_logging_metric" "logging_metric_project_ownership" {
  name   = "project-ownership"
  filter = "protoPayload.@type=type.googleapis.com/google.cloud.audit.AuditLog AND protoPayload.methodName=SetIamPolicy AND protoPayload.serviceData.policyDelta.bindingDeltas.role=roles/owner"
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
  
}
resource "google_logging_metric" "logging_metric_audit_config" {
  name   = "audit-config"
  filter ="protoPayload.@type=type.googleapis.com/google.cloud.audit.AuditLog AND protoPayload.request.updateMask=auditConfigs AND protoPayload.methodName=SetIamPolicy"
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}
resource "google_logging_metric" "logging_metric_Custom_role_changes" {
  name   = "Customrole-changes"
  filter =  "protoPayload.@type=type.googleapis.com/google.cloud.audit.AuditLog AND protoPayload.serviceName=iam.googleapis.com AND protoPayload.methodName=google.iam.admin.v1.UpdateRole"
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}
resource "google_logging_metric" "logging_metric_VPC_network_firewall_rule" {
  name   = "VPC-network-firewall-rule"
  filter ="protoPayload.@type=type.googleapis.com/google.cloud.audit.AuditLog AND resource.type=gce_firewall_rule"
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}
resource "google_logging_metric" "logging_metric_vpc_network_route_changes" {
  name   = "vpc-network-route-changes"
  filter ="protoPayload.@type=type.googleapis.com/google.cloud.audit.AuditLog AND resource.type=gce_route"
    metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}
resource "google_logging_metric" "logging_metric_vpc_network_changes" {
  name   = "vpc-network-changes"
  filter ="protoPayload.@type=type.googleapis.com/google.cloud.audit.AuditLog AND resource.type=gce_network"
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}
resource "google_logging_metric" "logging_metric_IAM_permission_changes_cloudstorage" {
  name   = "IAM-permission-changes-cloudstorage"
  filter ="protoPayload.@type=type.googleapis.com/google.cloud.audit.AuditLog AND protoPayload.methodName=storage.setIamPermissions AND protoPayload.serviceName=storage.googleapis.com"
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}
resource "google_logging_metric" "logging_metric_SQL_instance_configuration_changes" {
  name   = "SQL-instance-configuration-changes"
  filter ="protoPayload.@type=type.googleapis.com/google.cloud.audit.AuditLog AND protoPayload.methodName=cloudsql.instances.update AND protoPayload.serviceName=cloudsql.googleapis.com"
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}
#Creating alertpolicy
resource "google_monitoring_notification_channel" "email0" {
  display_name = "mamta.yadlpalli@array.com"
  type = "email"
  labels = {
    email_address = "mamta.yadlpalli@array.com"
  }
}
resource "google_monitoring_notification_channel" "email1" {
  display_name = "phillip@array.com"
  type = "email"
  labels = {
    email_address = "phillip@array.com"
  }
}
#alert policy for projectownershiplog
resource "google_monitoring_alert_policy" "alert_policy_project_ownership" {
 notification_channels = [
   google_monitoring_notification_channel.email0.name,
   google_monitoring_notification_channel.email1.name ]
  display_name = "project-ownership"
  combiner     = "OR"
  conditions {
    display_name = "test condition"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/project-ownership\" AND resource.type=\"global\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_COUNT"
      }
    }
  }

  user_labels = {
    alert = "project_ownership_change"
  }
}


resource "google_monitoring_alert_policy" "alert_policy_audit_config" {
 notification_channels = [
   google_monitoring_notification_channel.email0.name,
   google_monitoring_notification_channel.email1.name ]
  display_name = "audit-config"
  combiner     = "OR"
  conditions {
    display_name = " audit-config-condition"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/audit-config\" AND resource.type=\"global\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_COUNT"
      }
    }
  }

  user_labels = {
    alert = "audit_config_change"
  }
}
resource "google_monitoring_alert_policy" "alert_policy_customrole_changes" {
 notification_channels = [
  google_monitoring_notification_channel.email0.name,
  google_monitoring_notification_channel.email1.name ]
  display_name = "customrole-changes"
  combiner     = "OR"
  conditions {
    display_name = "customrole-changes-condition"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/Customrole-changes\" AND resource.type=\"global\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_COUNT"
      }
    }
  }

  user_labels = {
    alert = "customrole_changes"
  }
}
resource "google_monitoring_alert_policy" "alert_policy_vpc_network_firewall_rule" {
 notification_channels = [
   google_monitoring_notification_channel.email0.name,
   google_monitoring_notification_channel.email1.name]
  display_name = "vpc-network-firewall-rule"
  combiner     = "OR"
  conditions {
    display_name = "vpc-network-firewall-rule-condition"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/VPC-network-firewall-rule\" AND resource.type=\"global\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_COUNT"
      }
    }
  }

  user_labels = {
    alert = "vpc_network_firewall_rule_change"
  }
}
resource "google_monitoring_alert_policy" "alert_policy_vpc_network_route_changes" {
 notification_channels = [
   google_monitoring_notification_channel.email0.name,
   google_monitoring_notification_channel.email1.name ]
  display_name = "vpc-network-route-changes"
  combiner     = "OR"
  conditions {
    display_name = " vpc-network-route-changes-condition"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/vpc-network-route-changes\" AND resource.type=\"global\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_COUNT"
      }
    }
  }

  user_labels = {
    alert = "vpc_network_route_change"
  }
}
resource "google_monitoring_alert_policy" "alert_policy_vpc_network_changes" {
 notification_channels = [
   google_monitoring_notification_channel.email0.name,
   google_monitoring_notification_channel.email1.name ]
  display_name = "vpc-network-changes"
  combiner     = "OR"
  conditions {
    display_name = "vpc-network-changes-condition"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/vpc-network-changes\" AND resource.type=\"global\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_COUNT"
      }
    }
  }

  user_labels = {
    alert = "vpc_network_changes"
  }
}
resource "google_monitoring_alert_policy" "alert_policy_iam_permission_changes_cloudstorage" {
 notification_channels = [
   google_monitoring_notification_channel.email0.name,
   google_monitoring_notification_channel.email1.name ]
  display_name = "iam-permission-changes-cloudstorage"
  combiner     = "OR"
  conditions {
    display_name = "iam-permission-changes-cloudstorage-condition"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/IAM-permission-changes-cloudstorage\" AND resource.type=\"global\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_COUNT"
      }
    }
  }

  user_labels = {
    alert = "iam_permission_changes_cloudstorage_change"
  }
}
resource "google_monitoring_alert_policy" "alert_policy_sql_instance_configuration_changes" {
 notification_channels = [
   google_monitoring_notification_channel.email0.name,
   google_monitoring_notification_channel.email1.name ]
  display_name = "sql-instance-configuration-changes"
  combiner     = "OR"
  conditions {
    display_name = "sql-instance-configuration-changes-condition"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/SQL-instance-configuration-changes\" AND resource.type=\"global\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_COUNT"
      }
    }
  }

  user_labels = {
    alert = "sql_instance_configuration_changes"
  }
}
