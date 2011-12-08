module Bitcoin
  module Protocol

    class TxOut

      attr_accessor :value, :pk_script_length, :pk_script

      def initialize *args
        @value, @pk_script_length, @pk_script = *args
      end

      def [] idx
        case idx
        when 0 then @value
        when 1 then @pk_script_length
        when 2 then @pk_script
        end
      end

      def []= idx, val
        case idx
        when 0 then @value = val
        when 1 then @pk_script_length = val
        when 2 then @pk_script = val
        end
      end

      def parse_data(data)
        idx = 0
        @value = data[idx...idx+=8].unpack("Q")[0]
        @pk_script_length, tmp = Protocol.unpack_var_int(data[idx..-1])
        idx += data[idx..-1].bytesize - tmp.bytesize
        @pk_script = data[idx...idx+=@pk_script_length]
        idx
      end

    end

  end
end