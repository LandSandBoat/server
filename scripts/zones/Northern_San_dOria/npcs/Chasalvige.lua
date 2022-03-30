-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Chasalvige
-- Type: Standard Info NPC
--  Involved in Mission: The Road Forks
--  Involved in Mission: Promathia Mission 5 - Three Paths
-- !pos 96.432 -0.520 134.046 231
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(COP) == xi.mission.id.cop.THREE_PATHS and player:getCharVar("COP_Ulmia_s_Path") == 2) then
        player:startEvent(762)
    else
        player:startEvent(6)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 762) then
        player:setCharVar("COP_Ulmia_s_Path", 3)
    end
end

return entity
