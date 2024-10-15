function event_spawn(e)
    -- Only the Ogre on the dock should say this.
    if (e.self:GetSpawnPointID() == 356222) then
        eq.set_timer("ot_boat_start", 1) -- TD boat offset by 0 minutes
    end
end

function event_timer(e)
    if (e.self:GetSpawnPointID() == 356222) then
        if (e.timer == "ot_boat_start") then
            eq.stop_timer("ot_boat_start")
            eq.set_timer("ot_boat_warning", 20000) -- TD boat every 5 minutes
        end
        if(e.timer == "ot_boat_warning") then
            local cl = eq.get_entity_list():GetCloseClientList(e.self:GetX(), e.self:GetY(), e.self:GetZ(), 2000);
            for client in cl.entries do
                if (client.valid) then
                    client:Message(MT.White, "Ogre Wise One shouts, \"The boat to Overthere is leaving! Join me on the dock if you're goin'!\"");
                end
            end
            eq.stop_timer("ot_boat_warning")
            eq.set_timer("ot_boat_go", 60000)
        end
        if(e.timer == "ot_boat_go") then
            eq.stop_timer("ot_boat_go")
            eq.set_timer("ot_boat_warning", 20000)
            local cl = eq.get_entity_list():GetCloseClientList(e.self:GetX(), e.self:GetY(), e.self:GetZ(), 25);
            for client in cl.entries do
                if (client.valid) then 
                    client:MoveZone("overthere", 2734, 3452, -157, 243);
                end
            end
        end
    end
end
