function event_spawn(e)
	eq.set_timer("oot_boat_1min", 20000) -- boat ride every N minutes
end

function event_timer(e)
	if(e.timer == "oot_boat_1min") then
		local cl = eq.get_entity_list():GetCloseClientList(e.self::GetX(), e.self::GetY(), e.self::GetZ(), 2000);
		for client in cl.entries do
			if (client.valid) then 
				client:Message(MessageTypes::White, "The boat to Ocean of Tears leaves in one minute! Hurry!");
			end
		end
		eq.stop_timer("oot_boat_1min")
		eq.start_timer("oot_boat", 10000)
	end
	if(e.timer == "oot_boat") then
		eq.stop_timer("oot_boat")
		eq.set_timer("oot_boat_1min", 20000)
		local cl = eq.get_entity_list():GetCloseClientList(e.self::GetX(), e.self::GetY(), e.self::GetZ(), 100);
		for client in cl.entries do
			if (client.valid) then 
				client:MoveZone("oot", -9200, 0, 20);
			end
		end
	end
end
