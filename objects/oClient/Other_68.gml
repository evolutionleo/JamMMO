/// @desc
//show_debug_message("Networking event triggered.")

var type = async_load[? "type"]
var buff = async_load[? "buffer"]
var global_size = async_load[? "size"]


switch(type) {
	case network_type_data:
		#region My c0D3
		
		var packet_num = 0
		var pos = 0
		
		while(true) {
			var pack_size = buffer_read(buff, buffer_s8)
			
			var pack = buffer_create(1, buffer_grow, 1)
			buffer_copy(buff, pos+1, pack_size, pack, 0)
			
			handle_packet(pack)
			
			buffer_delete(pack)
			
			pos += pack_size+1
			buffer_seek(buff, buffer_seek_start, pos)
			
			
			packet_num++
			
			
			if pos == global_size {
				break
			}
		}
		
		#endregion
		
		//trace("Received % packets", packet_num)
		
		break
	default:
		// We don't handle other stuff :)
		break
}