module ChosenAssets
    class Engine < ::Rails::Engine
      config.assets.precompile += %w(
        chosen-sprite*.png
      )

      rake_tasks do
        load 'chosen_assets/tasks.rake'
      end
    end
end
