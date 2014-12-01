class ApplicationController < ActionController::Base
  protect_from_forgery

  CHECKED_VALUE = '1'
  def to_params_hash(arr, checked=CHECKED_VALUE)
  	return nil if arr.nil?
  	hash = {}
  	arr.each do |val|
  		hash[val] = checked
  	end
  	return hash
  end

  def params_to_array(hash)
  	return nil if hash.nil?
  	hash.keys
  end

	class SessionsHelper

		def method_missing(meth, *args, &block)
			if meth.to_s =~ /^_(\S+)\s*=$/
				self.set($1.to_sym, *args)
			elsif meth.to_s =~ /^_(\S+)$/
				self.get($1.to_sym)
			end
		end

	  def initialize(sess)
	     @session = sess
	     @session_name = :rotten_potatoes
	     @session[@session_name] = {} if @session[@session_name].nil?
	  end

	  def set(key, value)
	    @session[@session_name] = {} if @session[@session_name].nil?
	    @session[@session_name][key] = value
	  end

	  def get(key)
	    @session[@session_name].nil? ? nil : @session[@session_name][key]
	  end

	  def forget
	    @session[@session_name] = {}
	  end

	end

end
