-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Sulfur Scorpion
-- Note: PH for Tyrannic Turrok
-----------------------------------
local ID = zones[xi.zone.IFRITS_CAULDRON]
-----------------------------------
local entity = {}

local tyrannicPHTable =
{
    [ID.mob.TYRANNIC_TUNNOK - 3] = ID.mob.TYRANNIC_TUNNOK,
    [ID.mob.TYRANNIC_TUNNOK + 1] = ID.mob.TYRANNIC_TUNNOK,
    [ID.mob.TYRANNIC_TUNNOK + 2] = ID.mob.TYRANNIC_TUNNOK,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 759, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, tyrannicPHTable, 5, 3600) -- 1 hour
end

return entity
