-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Ghast
-- Note: PH for Namtar
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

local namtarPHTable =
{
    [ID.mob.NAMTAR - 6] = ID.mob.NAMTAR, -- -128.762 9.595 164.996
    [ID.mob.NAMTAR - 1] = ID.mob.NAMTAR, -- -157.606 9.905 168.518
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 805, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, namtarPHTable, 10, 3600) -- 1 hour
end

return entity
