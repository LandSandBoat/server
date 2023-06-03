-----------------------------------
-- Area: Den of Rancor
--  Mob: Hakutaku
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 1600)
    mob:setMobMod(xi.mobMod.GIL_MAX, 3500)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
