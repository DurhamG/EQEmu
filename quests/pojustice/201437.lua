-- 201435 The Tribunal
-- Trial of Stoning
--
-- items: 31599

local stoning_flag      = 0;
local trial_group_id    = 0;
local client_id         = 0; -- character ID, not entity ID
local trial_x           = -133;
local trial_y           = -1107;
local trial_z           = 73;
local trial_h           = 126;
local trial_mobs        = { 201451, 201493, 21494, 201495, 201496, 201497, 201498, 201499 };

local cooldown_timer    = 1800000;
local eject_timer       = 900000;
local fail_timer        = 360000;

function event_say(e)
   local qglobals = eq.get_qglobals(e.self,e.other);

   if (qglobals["pop_poj_mavuin"] ~= nil) then 
      if (e.message:findi("hail")) then 
         e.self:Emote(" fixes you with a dark, peircing gaze. 'What do you want, mortal? Are you [" .. eq.say_link( "prepared", false, "prepared") .. "]?");

      elseif (e.message:findi("prepared")) then
			e.self:Say("Very well. When you are ready, you may [" .. eq.say_link("ready to begin the trial of stoning", false, "begin the trial of stoning") .. "]. The archers will not cease their punishment until nothing else stands. Do not let the prisoners take more than they can bear. We shall judge the mark of your success.");
         
      elseif (e.message:findi("ready to begin the trial of stoning")) then
         if ( stoning_flag == 0 ) then 
            e.self:Say("Then begin.");

            -- Move the Player and their Group tot he trial room.
            local trial_group = e.other:GetGroup();
            if (trial_group ~= nil and trial_group.valid) then
               MoveGroup( trial_group, e.self:GetX(), e.self:GetY(), e.self:GetZ(), 75, trial_x, trial_y, trial_z, trial_h); 
               trial_group_id = trial_group:GetID();
            else
               client_id = e.other:CharacterID();
               e.other:MovePC(201, trial_x, trial_y, trial_z, trial_h); -- Zone: pojustice
            end

            -- Spawn the Controller
            eq.spawn2(201451, 0, 0, trial_x, trial_y, trial_z, trial_h); -- NPC: #Event_Stoning_Control

            -- Set the Proximity Check Timer; if everyone has left the trial (wipe); then reset things
            eq.set_timer("proximitycheck", 60000);

            -- Set a variable to indicate the Trial is unavailable.
            stoning_flag = 1;
         else
            e.self:Say("I'm sorry, the Trial of Stoning is currently unavilable to you.");
         end
      elseif (e.message:findi("what evidence of mavuin") ) then
         if ( e.other:HasItem(31845) ) then
            eq.set_global("pop_poj_tribunal", "1", 5, "F");
            eq.set_global("pop_poj_stoning", "1", 5, "F");
            e.other:Message(MT.LightBlue, "You receive a character flag!");
         end

		elseif (e.message:findi("i seek knowledge") ) then
			local marks = { 31796, 31842, 31844, 31845, 31846 , 31960 }
			local has_six = 1;
			for k,v in pairs(marks) do
				if (not e.other:HasItem(v)) then
					has_six = 0;
				end
			end

			if (has_six == 1) then 
				if (not e.other:HasItem(31599)) then 
					-- give 31599 to e.other
					e.other:SummonItem(31599); -- Item: The Mark of Justice
				end
			elseif (has_six == 0) then
				e.self:Say("You have done well, mortal, but there are more trials yet for you to complete.");
			end
      end
   end
end

function event_timer(e)
   if (e.timer == "ejecttimer") then
      eq.stop_timer(e.timer);
      despawn_trial_mobs()

      local trial_group = eq.get_entity_list():GetGroupByID(trial_group_id);
      if (trial_group ~= nil and trial_group.valid) then
         MoveGroup( trial_group, trial_x, trial_y, trial_z, 250, 456, 825, 9, 180, "A mysterious force translocates you."); 
      else
          local client_e = eq.get_entity_list():GetClientByCharID(client_id);
          if (client_e ~= nil and client_e.valid) then
              client_e:MovePC( 201, 456, 825, 9, 360 ); -- Zone: pojustice
              client_e:Message(MT.BrightBlue, "A mysterious force translocates you.");
          end
      end
      HandleCorpses(trial_x, trial_y, trial_z, 200);

      eq.stop_timer("proximitycheck");

   elseif (e.timer == "cooldown") then
      eq.stop_timer(e.timer);

      stoning_flag   = 0;
      client_id      = 0;
      trial_group_id = 0;

      despawn_trial_mobs();

      eq.stop_timer("proximitycheck");
      e.self:Shout("The Trial of Stoning is now Available.");

   elseif (e.timer == "proximitycheck") then
      -- The proximitycheck timer is primarily for when a trial has failed
      -- This check will allow the trial to be re-attempted as soon as
      -- everyone has left the trial room (or they are kicked out after
      -- 15minutes by the ejecttimer).

      -- Check to see if all the PCs have left the Trial area; if so
      -- Clean Corpses up and release thoe hold and stop the timer.
      if not ProximityCheck(trial_x, trial_y, trial_z, 250) then 
         eq.stop_timer(e.timer);

         eq.stop_timer("cooldown");
         eq.stop_timer("ejecttimer");
         eq.set_timer("ejecttimer", 100);
         eq.set_timer("cooldown", 200);
      end
   end
end

function event_signal(e)
   if (e.signal == 0) then

   elseif (e.signal == 1) then
      -- Trial was successful
      -- 30min till next Trial can start
      -- 15min Eject Timer to kick any PC out of the Trial Room
      eq.set_timer("ejecttimer", eject_timer);
      eq.set_timer("cooldown"  , cooldown_timer);

		eq.stop_timer("proximitycheck");

   elseif (e.signal == 2) then
      -- Trial Failed
      eq.set_timer("ejecttimer", fail_timer);
      eq.set_timer("cooldown"  , fail_timer);

      eq.stop_timer("proximitycheck");
      eq.set_timer("proximitycheck", 10000);

   end

end

function MoveGroup(trial_group, src_x, src_y, src_z, distance, tgt_x, tgt_y, tgt_z, tgt_h, msg)
   if ( trial_group ~= nil) then
      local trial_count = trial_group:GroupCount();

      for i = 0, trial_count - 1, 1 do
         local mob_v = trial_group:GetMember(i);

         if (mob_v ~= nil and mob_v.valid and mob_v:IsClient()) then
            local client_v = mob_v:CastToClient();

            if (client_v.valid) then
               -- check the distance and port them up if close enough
               if (client_v:CalculateDistance(src_x, src_y, src_z) <= distance) then
                  -- port the player up
                  client_v:MovePC(201, tgt_x, tgt_y, tgt_z, tgt_h); -- Zone: pojustice
					
                  if (msg) then
                     client_v:Message(MT.BrightBlue, msg);
                  end
               end
            end
         end
      end
   end
end

function HandleCorpses(src_x, src_y, src_z, dist)

   -- Move Player Corpses from the Trial Area to the Grave Yard
   local clist = eq.get_entity_list():GetCorpseList();
   if ( clist ~= nil ) then
      for corpse in clist.entries do
         if ( corpse:IsPlayerCorpse() ) then
             if (corpse:CalculateDistance(src_x, src_y, src_z) < dist) then
               corpse:GMMove(58, -47, 2);      
             end
         elseif ( corpse:IsNPCCorpse() ) then
            if (corpse:CalculateDistance(src_x, src_y, src_z) < dist) then
               corpse:Delete();
            end
          end
      end
   end
end

function ProximityCheck(chk_x, chk_y, chk_z, dist)

   local players_in_prox = false;
   local clist = eq.get_entity_list():GetClientList();

   if ( clist ~= nil ) then
      for client in clist.entries do
         if (client:CalculateDistance(chk_x, chk_y, chk_z) < dist) then
            players_in_prox = true;
         end
      end
   end

   return players_in_prox;
end

function despawn_trial_mobs()
   for k,v in pairs(trial_mobs) do
      eq.depop_all(v);
   end
end