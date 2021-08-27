-----------------------------------
-- Area: Promyvion vahzl
--  NPC: Memory flux (2)
-----------------------------------
local ID = require("scripts/zones/Promyvion-Vahzl/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(COP) == xi.mission.id.cop.DESIRES_OF_EMPTINESS and player:getCharVar("PromathiaStatus") == 3 and not GetMobByID(ID.mob.SOLICITOR):isSpawned() then
        SpawnMob(ID.mob.SOLICITOR):updateClaim(player)
    elseif player:getCurrentMission(COP) == xi.mission.id.cop.DESIRES_OF_EMPTINESS and player:getCharVar("PromathiaStatus") == 4 then
        player:startEvent(52)
    else
        player:messageSpecial(ID.text.OVERFLOWING_MEMORIES)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 52 then
        player:setCharVar("PromathiaStatus", 5)
    end
end

return entity
