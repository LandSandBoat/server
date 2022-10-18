-----------------------------------
-- Area: Tahrongi Canyon
--  Mob: Habrok
-----------------------------------
require("scripts/globals/hunts")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setLocalVar("pop", os.time() + math.random(1200, 7200))
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 258)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setLocalVar("pop", os.time() + math.random(1200, 7200))
end

return entity
