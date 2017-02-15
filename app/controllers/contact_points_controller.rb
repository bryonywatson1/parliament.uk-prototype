class ContactPointsController < ApplicationController
  def index
    data = Parliament::Request.new.contact_points.get
    @contact_points = data.filter('http://id.ukpds.org/schema/ContactPoint')
  end

  def show
    data = Parliament::Request.new.contact_points(params[:contact_point_id]).get
    @contact_point = data.filter('http://id.ukpds.org/schema/ContactPoint').first
    vcard = create_vcard(@contact_point)
    send_data vcard.to_s, filename: 'contact.vcf', disposition: 'attachment', data: { turbolink: false }
  end
end
