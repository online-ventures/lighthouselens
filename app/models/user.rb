class User < ApplicationRecord
  def self.get_auth_id(data)
    data['uid'] || data['user_id']
  end

  def to_s
    name
  end

  def name
    info['name']
  end

  def image
    info['image']
  end

  def set_data(data)
    self.data = data
    self.permissions = extract_permissions
    self.first_name = extract_first_name
    self.last_name = extract_last_name
    self.email = info['email']
  end

  def set_data!(data)
    set_data(data)
    save
  end

  def to_hash
    {
      name: name,
      email: email,
      image: image,
      permissions: permissions,
      data: data
    }
  end

  def can?(permission)
    permission.in? permissions
  end

  def expired?
    expires_at.blank? or expires_at < DateTime.now
  end

  private

  def info
    data['info'] || {}
  end

  def extra
    data['extra'] || {}
  end

  def raw
    extra['raw_info'] || {}
  end

  def credentials
    data['credentials'] || {}
  end

  def email?(text)
    text.match? /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  end

  def name_from_email
    return unless email? extract_name(:first)
    return info['nickname'] if info['nickname']
    extract_name(:first).split('@').first
  end

  def extract_name(n)
    names = name.split
    i = if n.is_a? Integer
          n
        elsif n == :first
          0
        elsif n == :last
          -1
        else
          0
        end
    names[i]
  end

  def extract_first_name
    raw['given_name'] or name_from_email or extract_name(:first)
  end

  def extract_last_name
    raw['family_name'] or extract_name(:last)
  end

  def extract_permissions
    credentials_token&.first&.dig('permissions')
  end

  def credentials_token
    return unless token = credentials['token']
    begin
      JWT.decode(token, nil, false)
    rescue StandardError
      nil
    end
  end

  def expires_at
    return unless unixtime = credentials['expires_at'].to_s
    DateTime.strptime(unixtime,'%s')
  end
end
