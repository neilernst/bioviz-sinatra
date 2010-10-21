#require 'rubygems'
require "bundler/setup"
require 'sinatra'
require_relative 'environment'

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

# root page
get '/' do
  haml :root
end

get '/jstest' do
  haml :testjs
end

get '/brain' do
  haml :brain
end

get '/gene' do
  @experiments = Experiment.all

  builder :gene
end

get '/gene/:gene' do
  @genes = Gene.get('known_gene_symbol' => :gene)
  builder :gene_one
end

helpers do
  def em(text)
    "<em>#{text}</em>"
  end
  def test_script
    str = <<-END_OF
    // Setup canvas
    void setup()
    {
      size(372,180);
      background(255);
    }
    // Draw elements
    void draw()
    {
      // Remove the border
      noStroke();
int bar_width = 36;
      // Adding this variable that is changeable by our JavaScript below.
      int dynamic_bar = $("#slider").slider("value");
      int[] bar_height = {132, 132, 100, 132, 160, 132, dynamic_bar};
      color[] bar_colors = {#cc9933, #c572d1, #8c8061, #e6df2b, #3ecbe5, #ca5e23, #99cc33};
      color[] shadow_colors = {#bb8822, #b461c0, #7b7050, #d5ce1a, #2dbad4, #b94d12, #79b327};
      for (int i=0; i<bar_height.length; i++)
      {
      /  / Build the shadow first.
        fill(shadow_colors[i]);
        rect(12+i*48, height-bar_height[i], bar_width, bar_height[i]);
        // Then build the fill bar.
        fill(bar_colors[i]);
        rect(12+i*48, height-bar_height[i]+2, bar_width-2, bar_height[i]-2);
      }
    }
    END_OF
    
    return str
  end

 def processing_script
    return "
            // All Examples Written by Casey Reas and Ben Fry
        // unless otherwise stated.
        int rectX, rectY;      // Position of square button
        int circleX, circleY;  // Position of circle button
        int rectSize = 50;     // Diameter of rect
        int circleSize = 53;   // Diameter of circle
        
        color rectColor;
        color circleColor;
        color baseColor;
        
        boolean rectOver = false;
        boolean circleOver = false;
        
        
        
        void setup()
        {
          size(200, 200);
              smooth();
              rectColor = color(0);
              circleColor = color(255);
 baseColor = color(102);
              circleX = width/2+circleSize/2+10;
              circleY = height/2;
              rectX = width/2-rectSize-10;
              rectY = height/2-rectSize/2;
              ellipseMode(CENTER);
        }
        
        void draw()
        {
          update(mouseX, mouseY);
        
          noStroke();
              if (rectOver) {
                background(rectColor);
                text  (thisNode,15,90)
              } else if (circleOver) {
                background(circleColor);
              } else {
                background(baseColor);
              }
        
              stroke(255);
              fill(rectColor);
              rect(rectX, rectY, rectSize, rectSize); 
               stroke(0);
              fill(circleColor);
              ellipse(circleX, circleY, circleSize, circleSize);
        }
        
        void update(int x, int y)
        {
          if( overCircle(circleX, circleY, circleSize) ) {
                circleOver = true;
                rectOver = false;
              } else if ( overRect(rectX, rectY, rectSize, rectSize) ) {
                rectOver = true;
                circleOver = false;
              } else {
                circleOver = rectOver = false;stroke(0);
              fill(circleColor);
              ellipse(circleX, circleY, circleSize, circleSize);
        }
        
        void update(int x, int y)
        {
          if( overCircle(circleX, circleY, circleSize) ) {
                circleOver = true;
                rectOver = false;
              } else if ( overRect(rectX, rectY, rectSize, rectSize) ) {
                rectOver = true;
                circleOver = false;
              } else {
                circleOver = rectOver = false;
  }
        }
        
        boolean overRect(int x, int y, int width, int height) 
        {
          if (mouseX >= x && mouseX <= x+width && 
              mouseY >= y && mouseY <= y+height) {
              return true;
          } else {
            return false;
          }
        }
 boolean overCircle(int x, int y, int diameter) 
        {
              float disX = x - mouseX;
              float disY = y - mouseY;
              if(sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
              return true;
              } else {
              return false;
              }
        }
        "
	end
	
end
