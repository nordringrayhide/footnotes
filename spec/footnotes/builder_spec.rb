require 'spec_helper'

describe Footnotes::Builder do
  it { expect { Footnotes::Builder.new(mock('controller')) }.not_to raise_error }
end
