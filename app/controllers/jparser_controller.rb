class JparserController < ApplicationController
  def index
  end

  def parse
    uploaded_io = File.open(params[:picture], "r")
    uploaded_to = Rails.root.join('tmp', uploaded_io.original_filename)
    # test it! Maybe use oneline encoding!
    data = File.open(uploaded_to, 'w') do |file|
      file.write(uploaded_io.read)
    end
    json = ""
    while(line = data.gets)
      json.join(line)
    end
    redirect_to :root, :notice => "This!"
    params = ActiveSupport::JSON.decode(json)
    params.each do |name, description, image|
      addproduct = Product.new(:name => name, :description => description, :image => image)
    end
    begin
      addproduct.save!
    rescue
      redirect_to :root, :notice => "#{addproduct.errors[:name]}"
    end
    redirect_to :root, :notice => "Add OK!"
  end
end
