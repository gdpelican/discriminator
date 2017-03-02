require "discriminator/version"
require "discriminator/methods"
require "active_record"

ActiveRecord::Base.extend(Discriminator::Methods)
