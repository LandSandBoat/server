-----------------------------------
-- Area: Promyvion vahzl
--  NPC: Memory flux (1)
-----------------------------------
local ID = require("scripts/zones/Promyvion-Vahzl/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(COP) == xi.mission.id.cop.DESIRES_OF_EMPTINESS and player:getCharVar("PromathiaStatus") == 1 and not GetMobByID(ID.mob.PROPAGATOR):isSpawned() then
        SpawnMob(ID.mob.PROPAGATOR):updateClaim(player)
    elseif player:getCurrentMission(COP) == xi.mission.id.cop.DESIRES_OF_EMPTINESS and player:getCharVar("PromathiaStatus") == 2 then
        player:startEvent(51)
    else
        player:messageSpecial(ID.text.OVERFLOWING_MEMORIES)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 51 then
        player:setCharVar("PromathiaStatus", 3)
    end
end

return entity
