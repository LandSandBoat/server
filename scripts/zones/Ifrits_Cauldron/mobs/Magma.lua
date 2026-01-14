-----------------------------------
-- Area: Ifrit's Cauldron
--   NM: Magma
-- Bastok mission 6-2
-----------------------------------
---@type TMobEntity
local entity = {}

-- Magma seems to do 1 for 1 with its Self-Destruct, and appears to also be Breath damage from Siknoz's testing.
-- It likely only blows up below 10%, considering it is stun immune.

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
end

return entity
