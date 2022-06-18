# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  self.implicit_order_column = 'created_at'

  def self.perform_sp(method, sql, *bindings)
    sql = send(:sanitize_sql_array, bindings.unshift(sql)) if bindings.any?
    connection.send(method, sql)
  end

  def self.fetch_sp(sql, *bindings)
    perform_sp(:select_all, sql, *bindings)
  end
end
