-----------------------------------
-- Area: Phanauet Channel (1)
--  NM: Stubborn Dredvodd
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(1) -- Jumping Animation
    mob:setUntargetable(false)
end

entity.onMobFight = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(43200, 54000)) -- 12 - 15 hours
end

return entity
