require 'active_record/connection_adapters/postgresql_adapter'

module ActiveRecord
  module ConnectionAdapters
    # We want to extend the provided PostgreSQLAdapter to use timestamps that
    # store timezones.
    class PostgreSQLAdapter
      NATIVE_DATABASE_TYPES.merge!(
        datetime:  { name: 'timestamptz' },
        timestamp: { name: 'timestamptz' }
      )
    end
  end
end
