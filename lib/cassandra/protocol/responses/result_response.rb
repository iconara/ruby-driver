# encoding: utf-8

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

module Cassandra
  module Protocol
    class ResultResponse < Response
      attr_reader :trace_id

      def initialize(trace_id)
        @trace_id = trace_id
      end

      def self.decode(protocol_version, buffer, length, trace_id=nil)
        kind = buffer.read_int
        impl = RESULT_TYPES[kind]
        raise UnsupportedResultKindError, %(Unsupported result kind: #{kind}) unless impl
        impl.decode(protocol_version, buffer, length - 4, trace_id)
      end

      def void?
        false
      end

      private

      RESPONSE_TYPES[0x08] = self

      RESULT_TYPES = [
        # populated by subclasses
      ]
    end
  end
end
