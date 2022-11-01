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
    if
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.DAWN and
        player:getCharVar("PromathiaStatus") == 3 and
        player:getCharVar("Promathia_kill_day") < os.time() and
        player:getCharVar("COP_louverance_story") == 0
    then
        player:startEvent(757)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 757 then
        player:setCharVar("COP_louverance_story", 1)
    end
end

return entity
