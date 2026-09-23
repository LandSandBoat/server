-----------------------------------
-- Area: Cape Teriggan
--   NM: Frostmane
-----------------------------------
local ID = zones[xi.zone.CAPE_TERIGGAN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.FROSTMANE - 5] = ID.mob.FROSTMANE, -- -262.000 -0.700 442.000
    [ID.mob.FROSTMANE - 4] = ID.mob.FROSTMANE, -- -272.224 -0.942 461.321
    [ID.mob.FROSTMANE - 3] = ID.mob.FROSTMANE, -- -268.000 -0.558 440.000
    [ID.mob.FROSTMANE - 2] = ID.mob.FROSTMANE, -- -283.874 -0.660 485.504
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 405)
end

entity.onMobDespawn = function(mob)
end

return entity
