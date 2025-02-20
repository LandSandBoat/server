-----------------------------------
-- Area: Korroloka Tunnel (173)
--   NM: Cargo Crab Colin
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.GIL_MIN, 1200)
    mob:setMobMod(xi.mobMod.GIL_MAX, 1950)
end

entity.onMobSpawn = function(mob)
    -- Has very high physical defense, takes normal damage from magic.
    mob:setMod(xi.mod.UDMGPHYS, -7000)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, { power = 10 })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 226)
end

return entity
