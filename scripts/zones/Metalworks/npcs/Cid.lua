-----------------------------------
-- Area: Metalworks
--  NPC: Cid
-- !pos -12 -12 1 237
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local copMission = player:getCurrentMission(xi.mission.log_id.COP)
    local copStatus = player:getCharVar("PromathiaStatus")

    -- DAWN
    if
        copMission == xi.mission.id.cop.DAWN and
        copStatus == 3 and
        player:getCharVar("Promathia_kill_day") < os.time() and
        player:getCharVar("COP_tenzen_story") == 0
    then
        player:startEvent(897)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 897 then
        player:setCharVar("COP_tenzen_story", 1)
    end
end

return entity
