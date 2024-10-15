function event_spawn(e)
    eq.set_timer("fp_boat_start", 1) -- FP boat offset by 0 minutes
end

function event_timer(e)
    if (e.timer == "fp_boat_start") then
        eq.stop_timer("fp_boat_start")
        eq.set_timer("fp_boat_warning", 20000) -- FP boat every 5 minutes
    end
    if(e.timer == "fp_boat_warning") then
        local cl = eq.get_entity_list():GetCloseClientList(e.self:GetX(), e.self:GetY(), e.self:GetZ(), 2000);
        for client in cl.entries do
            if (client.valid) then
                client:Message(MT.White, "Tegea Prendyn shouts, \"The boat to Freeport setting sail! Join me if you want to go!\"");
            end
        end
        eq.stop_timer("fp_boat_warning")
        eq.set_timer("fp_boat_go", 60000)
    end
    if(e.timer == "fp_boat_go") then
        eq.stop_timer("fp_boat_go")
        eq.set_timer("fp_boat_warning", 20000)
        local cl = eq.get_entity_list():GetCloseClientList(e.self:GetX(), e.self:GetY(), e.self:GetZ(), 25);
        for client in cl.entries do
            if (client.valid) then 
                client:MoveZone("freporte", -992, -16, -52, 132);
            end
        end
    end
end
