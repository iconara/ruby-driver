# encoding: ascii-8bit

# Copyright 2013-2014 DataStax, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'spec_helper'


module Cassandra
  module Protocol
    describe SupportedResponse do
      describe '.decode' do
        let :response do
          buffer = CqlByteBuffer.new("\x00\x02\x00\x0bCQL_VERSION\x00\x01\x00\x053.0.0\x00\x0bCOMPRESSION\x00\x00")
          described_class.decode(1, buffer, buffer.length)
        end

        it 'decodes the options' do
          response.options.should == {'CQL_VERSION' => ['3.0.0'], 'COMPRESSION' => []}
        end
      end

      describe '#to_s' do
        it 'returns a string with the options' do
          response = described_class.new('CQL_VERSION' => ['3.0.0'], 'COMPRESSION' => [])
          response.to_s.should == 'SUPPORTED {"CQL_VERSION"=>["3.0.0"], "COMPRESSION"=>[]}'
        end
      end
    end
  end
end
