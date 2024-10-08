-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Hurricane Wyvern
-- Note: PH for Vouivre
-----------------------------------
local ID = zones[xi.zone.IFRITS_CAULDRON]
-----------------------------------
---@type TMobEntity
local entity = {}

local vouivrePHTable =
{
    [ID.mob.VOUIVRE - 13] = ID.mob.VOUIVRE,
    [ID.mob.VOUIVRE - 12] = ID.mob.VOUIVRE,
    [ID.mob.VOUIVRE - 9]  = ID.mob.VOUIVRE,
    [ID.mob.VOUIVRE - 8]  = ID.mob.VOUIVRE,
    [ID.mob.VOUIVRE - 5]  = ID.mob.VOUIVRE,
    [ID.mob.VOUIVRE - 1]  = ID.mob.VOUIVRE,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 762, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, vouivrePHTable, 5, 7200) -- 2 hours
end

return entity
