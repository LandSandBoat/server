-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _0rv (Oil lamp)
-- Notes: Opens north door at J-9 from inside.
-- !pos -63.703 -26.227 37.000 27
-----------------------------------
require("scripts/globals/missions");
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)

    local DoorOffset = npc:getID() - 1;

    if (GetNPCByID(DoorOffset):getAnimation() == 9) then
        if (player:getZPos() > 36) then
            npc:openDoor(7); -- lamp animation
            GetNPCByID(DoorOffset):openDoor(7); -- _0rg
        end
    end

end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)

end;
