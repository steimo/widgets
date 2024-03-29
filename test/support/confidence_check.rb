module TestSupport
  module ConfidenceCheck
    class ConfidenceCheckFailed < Minitest::Assertion
      def initialize(minitest_assertion)
        super("CONFIDENCE CHECK FAILED: #{minitest_assertion.message}")
        @minitest_assertion = minitest_assertion
      end

      delegate :backtrace,
               :error,
               :location,
               :result_code,
               :result_label,
               :backtrace_locations,
               :cause, to: :@minitest_assertion
    end

    def confidence_check(&block)
      block.()
    rescue Minitest::Assertion => ex
      raise ConfidenceCheckFailed.new(ex)
    end
  end
end
