# values hard-coded for interim use.
# Phase I - These settings can be moved to DB once interface is built for admins to manage it through GUI.
# Phase II - Multi-tenant implementation. Values should be populated based on current user's rights.
class GlobalSettings
  def self.current_bookstall_id
    158
     # 156
  end

  def self.current_stores_id
    157
     # 155
  end

  def self.current_business_entitry_id
    134
     # 136
  end

  def self.organisation_name
    'Spiritual Hierarchy Publication Trust'
  end

  def self.organisation_address
    'Kanha Shanti Vanam, Shri Ramchandra Mission
13-110, Chegur, Kothur, Mahoobnagar Dt, Telegana 509228'
  end

  def self.organisation_registration
    'TIN # 36217061270'
  end
  def self.start_date
    '01/04/2016'
  end

  def self.threshold_default
    5
  end
end
