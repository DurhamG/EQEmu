function event_spawn(e)
    eq.set_timer("bb_boat_start", 1) -- BB boat offset by 0 minutes
    eq.set_timer("fv_boat_start", 15000) -- BB boat offset by 2.5 minutes
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
                client:Message(MT.White, "Island Shuttle shouts, \"The shuttle is about to head to Butcher Block. Jump on while you can!\"");
            end
        end
        eq.stop_timer("bb_boat_warning")
        eq.set_timer("bb_boat_go", 60000)
    end
    if(e.timer == "bb_boat_go") then
        eq.stop_timer("bb_boat_go")
        eq.set_timer("bb_boat_warning", 20000)
        local cl = eq.get_entity_list():GetCloseClientList(e.self:GetX(), e.self:GetY(), e.self:GetZ(), 30);
        for client in cl.entries do
            if (client.valid) then 
                client:MoveZone("butcher", 3109, 1050, 12, 401);
            end
        end
    end

    if (e.timer == "fv_boat_start") then
        eq.stop_timer("fv_boat_start")
        eq.set_timer("fv_boat_warning", 20000) -- BB boat every 5 minutes
    end
    if(e.timer == "fv_boat_warning") then
        local cl = eq.get_entity_list():GetCloseClientList(e.self:GetX(), e.self:GetY(), e.self:GetZ(), 2000);
        for client in cl.entries do
            if (client.valid) then
                client:Message(MT.White, "Island Shuttle shouts, \"The shuttle is departing for Firiona Vie. Hop on while you can!\"");
            end
        end
        eq.stop_timer("fv_boat_warning")
        eq.set_timer("fv_boat_go", 60000)
    end
    if(e.timer == "fv_boat_go") then
        eq.stop_timer("fv_boat_go")
        eq.set_timer("fv_boat_warning", 20000)
        local cl = eq.get_entity_list():GetCloseClientList(e.self:GetX(), e.self:GetY(), e.self:GetZ(), 30);
        for client in cl.entries do
            if (client.valid) then 
                client:MoveZone("firiona", 1403, -4205, -102, 511);
            end
        end
    end
end
