-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Phantom Worm
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addMod(xi.mod.REGEN, 35)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
