-----------------------------------
-- Area: Dragons Aery
--  Mob: Darter
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALLI_HATE, 30) -- 30 yalm distance
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
