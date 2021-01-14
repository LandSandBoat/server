-----------------------------------
-- Area: Al'Taieu
--  Mob: Ul'yovra
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:hideName(true)
    mob:untargetable(true)
    mob:setAnimationSub(5)
    mob:wait(2000)
end

function onMobEngaged(mob, target)
    mob:hideName(false)
    mob:untargetable(false)
    mob:setAnimationSub(6)
    mob:wait(2000)
end

function onMobDisengage(mob)
    mob:hideName(true)
    mob:untargetable(true)
    mob:setAnimationSub(5)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
