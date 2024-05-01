-----------------------------------
-- Area: West Sarutabaruta [S]
--  Mob: Tiny Lycopodium
-- Note: PH for Jeduah
-----------------------------------
local ID = zones[xi.zone.WEST_SARUTABARUTA_S]
mixins = { require('scripts/mixins/families/lycopodium') }
-----------------------------------
local entity = {}

local jeduahPHTable =
{
    [ID.mob.JEDUAH - 1] = ID.mob.JEDUAH, -- 113.797 -0.8 -310.342
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, jeduahPHTable, 10, 3600) -- 1 hour
end

return entity
