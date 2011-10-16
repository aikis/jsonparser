class JparserController < ApplicationController
  def index
  end

  def parse
    uploaded_io = params[:picture]
    uploaded_to = Rails.root.join('tmp', uploaded_io.original_filename)
    # test it! Maybe use oneline encoding!
    data = File.open(uploaded_to, 'w') do |file|
      file.write(uploaded_io.read)
    end
    data = File.open(uploaded_to, 'r')
    json = ""
    while(line = data.gets)
      json << line
    end
    params = ActiveSupport::JSON.decode(json)
    addproduct = nil
    errors = 0
    params.each do |elem|
      addproduct = Product.new(:name => elem["name"], :description => elem["description"], :image => elem["image"])
      errors = errors + 1 if !addproduct.save
    end
    data.close
    redirect_to :root, :notice => "There are #{errors} errors! Some items are duplicated maybe..." if errors > 0
    redirect_to :root, :notice => "Add OK!" if errors == 0
  end
end
