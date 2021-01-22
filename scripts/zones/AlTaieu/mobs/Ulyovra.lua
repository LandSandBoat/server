-----------------------------------
-- Area: Al'Taieu
--  Mob: Ul'yovra
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:hideName(true)
    mob:untargetable(true)
    mob:setAnimationSub(5)
    mob:wait(2000)
end

entity.onMobEngaged = function(mob, target)
    mob:hideName(false)
    mob:untargetable(false)
    mob:setAnimationSub(6)
    mob:wait(2000)
end

entity.onMobDisengage = function(mob)
    mob:hideName(true)
    mob:untargetable(true)
    mob:setAnimationSub(5)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
