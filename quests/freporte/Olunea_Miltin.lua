-- items: 13922
function event_say(e)
	if(e.message:findi("hail")) then
		e.self:Say("Hello. It is good to meet you. Try not to scare the fish away. This is A good spot I supply fish to the Grub N' Grog. The patrons there love me!");
	end
end

function event_trade(e)
	local item_lib = require("items");

	if(item_lib.check_turn_in(e.trade, {item1 = 13922})) then -- Snapped Pole
		e.self:Say("Great! Thank you stranger. The rogues must have broken it. At least I could repair it. It would be seasons before I could afford another pole.");
		e.other:Ding();
		e.other:Faction(330,1,0); -- Freeport Militia
		e.other:Faction(336,1,0); -- Coalition of Tradefolk Underground
		e.other:Faction(281,-1,0); -- Knights of Truth
		e.other:Faction(362,-1,0); -- Priests of Marr
		e.other:AddEXP(100);
		e.other:GiveCash(50,0,0,0);
	end
	item_lib.return_items(e.self, e.other, e.trade)
end

function event_spawn(e)
    eq.set_timer("oot_boat_start", 1) -- OOT boat offset by 0 minutes
end

function event_timer(e)
    if (e.timer == "oot_boat_start") then
        eq.stop_timer("oot_boat_start")
        eq.set_timer("oot_boat_warning", 20000) -- BB boat every 5 minutes
    end
    if(e.timer == "oot_boat_warning") then
        local cl = eq.get_entity_list():GetCloseClientList(e.self:GetX(), e.self:GetY(), e.self:GetZ(), 2000);
        for client in cl.entries do
            if (client.valid) then
                client:Message(MT.White, "Olunea Miltin shouts, \"The boat to Ocean of Tears is heading out! Gather 'round!\"");
            end
        end
        eq.stop_timer("oot_boat_warning")
        eq.set_timer("oot_boat_go", 60000)
    end
    if(e.timer == "oot_boat_go") then
        eq.stop_timer("oot_boat_go")
        eq.set_timer("oot_boat_warning", 20000)
        local cl = eq.get_entity_list():GetCloseClientList(e.self:GetX(), e.self:GetY(), e.self:GetZ(), 25);
        for client in cl.entries do
            if (client.valid) then 
                client:MoveZone("oot", 7581, -2090, 3, 132);
            end
        end
    end
end
