-----------------------------------
-- Area: Nashmau
--  NPC: Pyopyoroon
-- Standard Info NPC
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(TOAU) == xi.mission.id.toau.LOST_KINGDOM) then
        player:startEvent(280)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
