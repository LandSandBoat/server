-----------------------------------
-- Area: Bostaunieux Oubliette
--  Mob: Werebat
-- Note: PH for Arioch
-----------------------------------
local ID = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
-----------------------------------
local entity = {}

local ariochPHTable =
{
    [ID.mob.ARIOCH - 11] = ID.mob.ARIOCH, -- -259 0.489 -188
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 611, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ariochPHTable, 10, 3600) -- 1 hour
end

return entity
