-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Hinaree
-- Type: Standard NPC
-- !pos -301.535 -10.199 97.698 230
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(COP) == xi.mission.id.cop.THE_ROAD_FORKS and player:getCharVar("EMERALD_WATERS_Status")==6 ) then
        player:startEvent(23)
    elseif (player:getCurrentMission(COP) == xi.mission.id.cop.THREE_PATHS and player:getCharVar("COP_Ulmia_s_Path")== 0 ) then
        player:startEvent(22)
    elseif (player:getCurrentMission(COP) == xi.mission.id.cop.DAWN and player:getCharVar("PromathiaStatus")==3 and player:getCharVar("Promathia_kill_day") < os.time() and player:getCharVar("COP_louverance_story")== 0 ) then
        player:startEvent(757)
    else
        player:startEvent(580)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 23) then
        player:setCharVar("EMERALD_WATERS_Status", 7)  --end 3-3A: San d'Oria Route: "Emerald Waters"
    elseif (csid == 22) then
        player:setCharVar("COP_Ulmia_s_Path", 1)
    elseif (csid == 757) then
        player:setCharVar("COP_louverance_story", 1)
    end
end

return entity
