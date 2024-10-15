function event_spawn(e)
    eq.set_timer("td_boat_start", 1) -- TD boat offset by 0 minutes
end

function event_timer(e)
    if (e.timer == "td_boat_start") then
        eq.stop_timer("td_boat_start")
        eq.set_timer("td_boat_warning", 20000) -- TD boat every 5 minutes
    end
    if(e.timer == "td_boat_warning") then
        local cl = eq.get_entity_list():GetCloseClientList(e.self:GetX(), e.self:GetY(), e.self:GetZ(), 2000);
        for client in cl.entries do
            if (client.valid) then
                client:Message(MT.White, "Dragoon V'Lask shouts, \"The boat to Timorous Deep leaves soon. Come to me if you're going. Or not.\"");
            end
        end
        eq.stop_timer("td_boat_warning")
        eq.set_timer("td_boat_go", 60000)
    end
    if(e.timer == "td_boat_go") then
        eq.stop_timer("td_boat_go")
        eq.set_timer("td_boat_warning", 20000)
        local cl = eq.get_entity_list():GetCloseClientList(e.self:GetX(), e.self:GetY(), e.self:GetZ(), 25);
        for client in cl.entries do
            if (client.valid) then
                client:MoveZone("timorous", 3626, 5859, 3, 446);
            end
        end
    end
end
