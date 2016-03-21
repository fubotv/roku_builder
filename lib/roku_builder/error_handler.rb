module RokuBuilder
  class ErrorHandler
    # Handle codes returned from validating options
    # @param options_code [Integer] the error code returned by validate_options
    # @param logger [Logger] system logger
    def self.handle_options_codes(options:, options_code:, logger:)
      case options_code
      when EXTRA_COMMANDS
        logger.fatal "Only one command is allowed"
        abort
      when NO_COMMANDS
        logger.fatal "At least one command is required"
        abort
      when EXTRA_SOURCES
        logger.fatal "Only use one of --ref, --working, --current or --stage"
        abort
      when NO_SOURCE
        logger.fatal "Must use at least one of --ref, --working, --current or --stage"
        abort
      when BAD_CURRENT
        logger.fatal "Can only sideload or build 'current' directory"
        abort
      when BAD_DEEPLINK
        logger.fatal "Must supply deeplinking options when deeplinking"
        abort
      when BAD_IN_FILE
        logger.fatal "Can only supply in file for building"
        abort
      end
    end

    # Handle codes returned from configuring
    # @param configure_code [Integer] the error code returned by configure
    # @param logger [Logger] system logger
    def self.handle_configure_codes(options:, configure_code:, logger:)
      case configure_code
      when CONFIG_OVERWRITE
        logger.fatal 'Config already exists. To create default please remove config first.'
        abort
      when SUCCESS
        logger.info 'Configure successful'
        abort
      end
    end

    # Handle codes returned from load_config
    # @param load_code [Integer] the error code returned by configure
    # @param logger [Logger] system logger
    def self.handle_load_codes(options:, load_code:, logger:)
      case load_code
      when DEPRICATED_CONFIG
        logger.warn 'Depricated config. See Above'
      when MISSING_CONFIG
        logger.fatal "Missing config file: #{options[:config]}"
        abort
      when INVALID_CONFIG
        logger.fatal 'Invalid config. See Above'
        abort
      when MISSING_MANIFEST
        logger.fatal 'Manifest file missing'
        abort
      when UNKNOWN_DEVICE
        logger.fatal "Unkown device id"
        abort
      when UNKNOWN_PROJECT
        logger.fatal "Unknown project id"
        abort
      when UNKNOWN_STAGE
        logger.fatal "Unknown stage"
        abort
      end
    end

    # Handle codes returned from checking devices
    # @param device_code [Integer] the error code returned by check_devices
    # @param logger [Logger] system logger
    def self.handle_device_codes(options:, device_code:, logger:)
      case device_code
      when CHANGED_DEVICE
        logger.info "The default device was not online so a secondary device is being used"
      when BAD_DEVICE
        logger.fatal "The selected device was not online"
        abort
      when NO_DEVICES
        logger.fatal "No configured devices were found"
        abort
      end
    end

    # Handle codes returned from handeling commands devices
    # @param device_code [Integer] the error code returned by handle_options
    # @param logger [Logger] system logger
    def self.handle_command_codes(options:, command_code:, logger:)
      case command_code
      when FAILED_SIDELOAD
        logger.fatal "Failed Sideloading App"
        abort
      when FAILED_SIGNING
        logger.fatal "Failed Signing App"
        abort
      when FAILED_DEEPLINKING
        logger.fatal "Failed Deeplinking To App"
        abort
      when FAILED_NAVIGATING
        logger.fatal "Command not sent"
        abort
      when FAILED_SCREENCAPTURE
        logger.fatal "Failed to Capture Screen"
        abort
      end
    end
  end
end
