-----------------------------------
-- Area: Quicksand Caves
--  Mob: Ancient Vessel
-- Mithra and the Crystal (Zilart 12) Fight
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- Mob always resists Silence. But it isnt an immunity, its a resistance rank of 11, and as such, it could potentially be immunobroken.
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 600)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
