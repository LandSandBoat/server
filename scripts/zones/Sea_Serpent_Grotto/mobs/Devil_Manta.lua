-----------------------------------
-- Area: Sea Serpent Grotto (176)
--  Mob: Devil Manta
-- Note: Place holder Charybdis
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

local charybdisPHTable =
{
    [ID.mob.CHARYBDIS - 4] = ID.mob.CHARYBDIS, -- -138.181, 48.389, -338.001
    [ID.mob.CHARYBDIS - 2] = ID.mob.CHARYBDIS, -- -212.407, 38.538, -342.544
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 810, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, charybdisPHTable, 10, math.random(28800, 43200)) -- 8 - 12 hours
end

return entity
