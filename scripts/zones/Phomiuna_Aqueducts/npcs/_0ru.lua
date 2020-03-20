-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: Oil lamp
-- !pos -63.699 -26.227 43.009 27
-----------------------------------
require("scripts/globals/missions");
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs");
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)

    local DoorOffset = npc:getID();

    player:messageSpecial(ID.text.LAMP_OFFSET); -- fire lamp
    npc:openDoor(7); -- lamp animation

    local element = VanadielDayElement();
    -- printf("element: %u",element);

    if (element == 0) then -- fireday
        if (GetNPCByID(DoorOffset-6):getAnimation() == 8) then -- ice lamp open?
            GetNPCByID(DoorOffset-9):openDoor(15); -- Door _0rk
        end
    elseif (element == 2) then  -- waterday
        if (GetNPCByID(DoorOffset-5):getAnimation() == 8) then -- water lamp open?
            GetNPCByID(DoorOffset-9):openDoor(15); -- Door _0rk
        end
    end

end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)

end;
