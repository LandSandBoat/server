-----------------------------------
-- Area: Mamook
-- Mob: Mikilulu
-- ToAU Quest: Prince and the Hopper
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:setUnkillable(true)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
