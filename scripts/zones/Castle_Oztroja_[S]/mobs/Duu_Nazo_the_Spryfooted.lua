-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Duu Nazo the Spryfooted
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.GIL_MAX, -1)
    mob:setMod(xi.mod.REGEN, 100)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
