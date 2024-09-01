-----------------------------------
-- Area: North Gustaberg
--  Mob: Maneating Hornet
-- Note: Place Holder For Stinging Sophie
-----------------------------------
local ID = zones[xi.zone.NORTH_GUSTABERG]
-----------------------------------
---@type TMobEntity
local entity = {}

local sophiePHTable =
{
    [ID.mob.STINGING_SOPHIE[1] - 6] = ID.mob.STINGING_SOPHIE[1], -- 196.873 -40.415 500.153
    [ID.mob.STINGING_SOPHIE[1] - 5] = ID.mob.STINGING_SOPHIE[1], -- 352.974 -40.359 472.914
    [ID.mob.STINGING_SOPHIE[1] - 4] = ID.mob.STINGING_SOPHIE[1], -- 216.150 -41.182 445.157
    [ID.mob.STINGING_SOPHIE[1] - 3] = ID.mob.STINGING_SOPHIE[1], -- 353.313 -40.347 463.609
    [ID.mob.STINGING_SOPHIE[1] - 2] = ID.mob.STINGING_SOPHIE[1], -- 237.753 -40.500 469.738
    [ID.mob.STINGING_SOPHIE[1] - 1] = ID.mob.STINGING_SOPHIE[1], -- 197.369 -40.612 453.688

    [ID.mob.STINGING_SOPHIE[2] - 5] = ID.mob.STINGING_SOPHIE[2], -- 210.607 -40.478 566.096
    [ID.mob.STINGING_SOPHIE[2] - 4] = ID.mob.STINGING_SOPHIE[2], -- 288.447 -40.842 634.161
    [ID.mob.STINGING_SOPHIE[2] - 3] = ID.mob.STINGING_SOPHIE[2], -- 295.890 -41.593 614.738
    [ID.mob.STINGING_SOPHIE[2] - 2] = ID.mob.STINGING_SOPHIE[2], -- 363.973 -40.774 562.355
    [ID.mob.STINGING_SOPHIE[2] - 1] = ID.mob.STINGING_SOPHIE[2], -- 356.544 -40.528 570.302
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 17, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, sophiePHTable, 5, 1) -- Pure Lottery
end

return entity
