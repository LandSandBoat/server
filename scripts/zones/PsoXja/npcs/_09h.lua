-----------------------------------
-- Area: Pso'Xja
--  NPC: Avatars Gate
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/PsoXja/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.THREE_PATHS and player:getCharVar("COP_Tenzen_s_Path") == 9) then
        player:startEvent(5)
    else
        player:messageSpecial(ID.text.DOOR_LOCKED)
    end
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 5) then
        player:setCharVar("COP_Tenzen_s_Path", 10)
    end
end
