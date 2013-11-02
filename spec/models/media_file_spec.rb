require 'spec_helper'

describe MediaFile do
  it { should belong_to(:card) }
  it { should validate_presence_of(:card) }
  it { should have_attached_file(:file) }

  it { should validate_attachment_presence(:file) }
  it { should validate_attachment_content_type(:file).
         allowing('image/png', 'image/gif', 'image/jpg').
         rejecting('text/plain', 'text/html') }
  it { should validate_attachment_size(:file).less_than(128.kilobytes) }

  describe "#file" do
    let(:card) { FactoryGirl.create(:card) }
    it "stores file data" do
      path = File.expand_path('../../data/image.png', __FILE__)
      File.open(path) do |f|
        card.media_files.create!(file: f)
      end
      card.media_files.length.should == 1
      card.media_files[0].file.url.should_not be_nil
      card.media_files[0].file_content_type.should == 'image/png'
    end
  end
end
