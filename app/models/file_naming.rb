class FileNaming < ActiveRecord::Base
  attr_accessible :filename_1, :filename_2, :filename_3, :filename_4, :filename_format_1,
                  :filename_format_2, :filename_format_3, :filename_format_4, :filename_sample_1,
                  :filename_sample_2, :filename_sample_3, :filename_sample_4, :filename_sample_5,
                  :filename_sample_6
end