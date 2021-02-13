-----------------------------------
-- Area: Pso'Xja
--  NPC: Avatars Gate
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/PsoXja/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.THREE_PATHS and player:getCharVar("COP_Tenzen_s_Path") == 1) then
        player:startEvent(3)
    else
        player:messageSpecial(ID.text.DOOR_LOCKED)
    end
    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 3) then
        player:setCharVar("COP_Tenzen_s_Path", 2)
    end
end

return entity
