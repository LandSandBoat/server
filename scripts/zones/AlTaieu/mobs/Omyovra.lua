-----------------------------------
-- Area: Al'Taieu
--  Mob: Om'yovra
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:hideName(true)
    mob:setUntargetable(true)
    mob:setAnimationSub(5)
    mob:wait(2000)
end

entity.onMobEngaged = function(mob, target)
    mob:hideName(false)
    mob:setUntargetable(false)
    mob:setAnimationSub(6)
    mob:wait(2000)
end

entity.onMobDisengage = function(mob)
    mob:hideName(true)
    mob:setUntargetable(true)
    mob:setAnimationSub(5)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
