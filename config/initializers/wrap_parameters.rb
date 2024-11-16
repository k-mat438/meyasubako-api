# frozen_string_literal: true

# プロジェクト単位でwrapを防ぐ
ActiveSupport.on_load(:action_controller) do
  wrap_parameters format: []
end
