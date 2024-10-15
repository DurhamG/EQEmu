function event_spawn(e)
    eq.set_timer("oot_boat_start", 1) -- OOT boat offset by 0 minutes
end

function event_timer(e)
    if (e.timer == "oot_boat_start") then
        eq.stop_timer("oot_boat_start")
        eq.set_timer("oot_boat_warning", 20000) -- OOT boat every 5 minutes
    end
    if(e.timer == "oot_boat_warning") then
        local cl = eq.get_entity_list():GetCloseClientList(e.self:GetX(), e.self:GetY(), e.self:GetZ(), 2000);
        for client in cl.entries do
            if (client.valid) then
                client:Message(MT.White, "Glorin Binfurr shouts, \"The boat to Ocean of Tears is departing! Get here quick if you're traveling!\"");
            end
        end
        eq.stop_timer("oot_boat_warning")
        eq.set_timer("oot_boat_go", 60000)
    end
    if(e.timer == "oot_boat_go") then
        eq.stop_timer("oot_boat_go")
        eq.set_timer("oot_boat_warning", 20000)
        local cl = eq.get_entity_list():GetCloseClientList(e.self:GetX(), e.self:GetY(), e.self:GetZ(), 30);
        for client in cl.entries do
            if (client.valid) then 
                client:MoveZone("oot", -9200, 275, 4);
            end
        end
    end
end
