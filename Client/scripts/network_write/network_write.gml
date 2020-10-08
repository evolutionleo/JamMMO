function network_write(buff, sock) {
	///@arg buff
	///@arg socket
	var _ = argument[0] + argument_count; _ = 0;
	
	if is_undefined(sock) {
		sock = oClient.socket
	}
	
	var pack_size = buffer_tell(buff)
	var buff_pack = buffer_create(1, buffer_grow, 1)
	
	buffer_seek(buff_pack, buffer_seek_start, 0)
	buffer_seek(buff, buffer_seek_start, 0)
	
	buffer_write(buff_pack, buffer_s8, pack_size+1)
	buffer_copy(buff, 0, pack_size, buff_pack, 1)
	
	buffer_seek(buff_pack, buffer_seek_start, pack_size+1)
	
	network_send_raw(sock, buff_pack, buffer_tell(buff_pack))
	//network_send_raw(sock, buff, buffer_get_size(buff))
	
	buffer_delete(buff)
	buffer_delete(buff_pack)
}