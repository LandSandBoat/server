-----------------------------------
-- Area: Mine_Shaft_2716
--  NPC: Shaft entrance
-----------------------------------
require("scripts/globals/bcnm")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.bcnm.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.FIRE_IN_THE_EYES_OF_MEN and
        player:getCharVar("PromathiaStatus") == 0
    then
        player:startEvent(4)
    else
        xi.bcnm.onTrigger(player, npc)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    xi.bcnm.onEventUpdate(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 4 then
        player:setCharVar("PromathiaStatus", 1)
    else
        xi.bcnm.onEventFinish(player, csid, option)
    end
end

return entity
