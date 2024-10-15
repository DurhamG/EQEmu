function event_spawn(e)
    eq.set_timer("bb_boat_start", 1) -- BB boat offset by 0 minutes
end

function event_timer(e)
    if (e.timer == "bb_boat_start") then
        eq.stop_timer("bb_boat_start")
        eq.set_timer("bb_boat_warning", 20000) -- BB boat every 5 minutes
    end
    if(e.timer == "bb_boat_warning") then
        local cl = eq.get_entity_list():GetCloseClientList(e.self:GetX(), e.self:GetY(), e.self:GetZ(), 2000);
        for client in cl.entries do
            if (client.valid) then
                client:Message(MT.White, "Zachariah Reigh shouts \"The boat to Butcher Block is getting ready to leave! Gather 'round if you wish to travel!\"");
            end
        end
        eq.stop_timer("bb_boat_warning")
        eq.set_timer("bb_boat_go", 60000)
    end
    if(e.timer == "bb_boat_go") then
        eq.stop_timer("bb_boat_go")
        eq.set_timer("bb_boat_warning", 20000)
        local cl = eq.get_entity_list():GetCloseClientList(e.self:GetX(), e.self:GetY(), e.self:GetZ(), 25);
        for client in cl.entries do
            if (client.valid) then 
                client:MoveZone("butcher", 3110, 1447, 12, 378);
            end
        end
    end
end
