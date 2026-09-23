-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Hippomaritimus
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(3600, 5400)) -- 60-90 min repop
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 210)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(3600, 5400)) -- 60-90 min repop
end

return entity
