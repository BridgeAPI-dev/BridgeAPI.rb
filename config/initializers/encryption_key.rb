# frozen_string_literal: true

class NoEcryptionKey < StandardError
end

if Rails.env == 'test' || Rails.env == 'development'
  ENV['SALT'] = "e4l\xB7\x98p\xE3\x97\xE4H[\xE8\x8A\xFF\xC5\x11\xF8\xB7\x05\x95Oj\x9CS\x8A\x8A\fF\x90:\xE0\xFB"
end

raise NoEncryptionKey if Rails.env == :production && !ENV['SALT']
