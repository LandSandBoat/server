-----------------------------------
-- Area: East Sarutabaruta
--  Mob: Prickly Pitriv
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.GIL_MAX, -1)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.unityWanted.onMobDeath(mob, player, optParams)
end

return entity
