-----------------------------------
-- Area: Xarcabard
--  Mob: Cursed Weapon
-- Note: PH for Barbaric Weapon
-----------------------------------
local ID = zones[xi.zone.XARCABARD]
-----------------------------------
---@type TMobEntity
local entity = {}

local barbaricPHTable =
{
    [ID.mob.BARBARIC_WEAPON - 1] = ID.mob.BARBARIC_WEAPON,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 52, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 53, 3, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, barbaricPHTable, 10, 7200) -- 2 hours
end

return entity
