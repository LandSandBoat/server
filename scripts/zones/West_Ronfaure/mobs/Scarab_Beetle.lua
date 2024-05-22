-----------------------------------
-- Area: West Ronfaure(100)
--  Mob: Scarab Beetle
-- Note: Place holder for Fungus Beetle
-----------------------------------
local ID = zones[xi.zone.WEST_RONFAURE]
-----------------------------------
local entity = {}

local fungusPHTable =
{
    [ID.mob.FUNGUS_BEETLE - 21] = ID.mob.FUNGUS_BEETLE, -- -332.722 -21.032 -112.044
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 3, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 4, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, fungusPHTable, 10, 900) -- 15 minute minimum
end

return entity
