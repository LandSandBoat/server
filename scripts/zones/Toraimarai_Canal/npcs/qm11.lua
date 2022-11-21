-----------------------------------
-- Area: Toraimarai Canal
--  NPC: ???
-- Involved In Quest: The Root of the Problem
-- !pos 19 17 59 169
-----------------------------------
local ID = require("scripts/zones/Toraimarai_Canal/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("rootProblem") == 2 then
        if
            not GetMobByID(ID.mob.MAGIC_SLUDGE):isSpawned() and
            player:getCharVar("rootProblemQ1") == 2 and
            player:getCharVar("rootProblemQ2") == 2
        then
            player:startEvent(48)
        end
    elseif player:getCharVar("rootProblem") == 3 then
        player:startEvent(55)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 48 and option ~= 0 then
        SpawnMob(ID.mob.MAGIC_SLUDGE):updateClaim(player)
    end
end

return entity
