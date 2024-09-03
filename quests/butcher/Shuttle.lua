function event_spawn(e)
    eq.set_timer("td_boat_start", 10000) -- TD boat offset by 2.5 minutes
end

function event_timer(e)
    if (e.timer == "td_boat_start") then
        eq.stop_timer("td_boat_start")
        eq.set_timer("td_boat_warning", 20000) -- TD boat every 5 minutes
    end
    if(e.timer == "td_boat_warning") then
        -- Only one boat should announce
        if (e.self:GetSpawnPointID() == 326525) then
            local cl = eq.get_entity_list():GetCloseClientList(e.self:GetX(), e.self:GetY(), e.self:GetZ(), 2000);
            for client in cl.entries do
                if (client.valid) then
                    client:Message(MT.White, "Magnus Boran shouts \"The boat to Timorous Deep leaves in one minute! Run!\"");
                end
            end
        end
        eq.stop_timer("td_boat_warning")
        eq.set_timer("td_boat_go", 10000)
    end
    if(e.timer == "td_boat_go") then
        eq.stop_timer("td_boat_go")
        eq.set_timer("td_boat_warning", 20000)
        local cl = eq.get_entity_list():GetCloseClientList(e.self:GetX(), e.self:GetY(), e.self:GetZ(), 100);
        for client in cl.entries do
            if (client.valid) then 
                client:MoveZone("timorous", -3273, -4564, 20);
            end
        end
    end
end
