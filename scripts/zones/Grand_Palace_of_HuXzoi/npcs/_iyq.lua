-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  NPC: cermet portal
-- !pos 420 0 401 34
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local cop = player:getCurrentMission(xi.mission.log_id.COP)
    local copStat = player:getCharVar("PromathiaStatus")

    if
        cop == xi.mission.id.cop.A_FATE_DECIDED and
        copStat == 1 and
        not GetMobByID(ID.mob.IXGHRAH):isSpawned()
    then
        SpawnMob(ID.mob.IXGHRAH):updateClaim(player)
    elseif cop == xi.mission.id.cop.A_FATE_DECIDED and copStat == 2 then
        player:startEvent(3)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 3 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.A_FATE_DECIDED)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL)
    end
end

return entity
