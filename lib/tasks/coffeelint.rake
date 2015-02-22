task(:coffeelint).clear

task :coffeelint do
  file_pattern = '{app,spec}/**/*.coffee*'

  config = {
    arrow_spacing: {
      level: 'error'
    },
    colon_assignment_spacing: {
      level: 'error',
      spacing: {
        left: 0,
        right: 1
      }
    },
    empty_constructor_needs_parens: {
      level: 'error'
    },
    line_endings: {
      level: 'error',
      value: 'unix'
    },
    max_line_length: {
      level: 'error',
      value: 99
    },
    no_empty_param_list: {
      level: 'error'
    },
    no_plusplus: {
      level: 'error'
    },
    no_unnecessary_fat_arrows: {
      level: 'error'
    },
    non_empty_constructor_needs_parens: {
      level: 'error'
    },
    space_operators: {
      level: 'error'
    }
  }

  results = Dir.glob(file_pattern).map { |f| Coffeelint.run_test(f, config) }

  unless results.all?
    abort
  end
end
