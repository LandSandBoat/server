-----------------------------------
-- Area: Pso'Xja
--  NPC: Stone Gate
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/PsoXja/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local posZ=player:getZPos()
    if (player:hasKeyItem(tpz.ki.PSOXJA_PASS) == true and posZ >= 25) then
        player:startEvent(14)
    elseif (posZ < 25) then
        player:startEvent(17)
    else
        player:messageSpecial(ID.text.DOOR_LOCKED)
    end
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
