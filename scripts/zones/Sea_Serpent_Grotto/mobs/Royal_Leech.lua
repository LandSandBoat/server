-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Royal Leech
-- Note: PH for Masan
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
local entity = {}

local masanPHTable =
{
    [ID.mob.MASAN - 4] = ID.mob.MASAN, -- 17.001 9.340 186.571
    [ID.mob.MASAN - 3] = ID.mob.MASAN, -- 18.702 9.512 183.594
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 804, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, masanPHTable, 10, 14400) -- 4 hours
end

return entity
