-----------------------------------
-- Area: East Ronfaure
--  Mob: Pugil
-- Note: PH for Swamfisk
-----------------------------------
local ID = zones[xi.zone.EAST_RONFAURE]
-----------------------------------
---@type TMobEntity
local entity = {}

local swamfiskPHTable =
{
    [ID.mob.SWAMFISK[1] - 2] = ID.mob.SWAMFISK[1], -- 379.120 -27.898 -46.436
    [ID.mob.SWAMFISK[1] - 1] = ID.mob.SWAMFISK[1], -- 417.542 -17.210 -177.883

    [ID.mob.SWAMFISK[2] - 4] = ID.mob.SWAMFISK[2], -- 443.334 -17.000 -303.275
    [ID.mob.SWAMFISK[2] - 3] = ID.mob.SWAMFISK[2], -- 423.000 -16.000 -285.000
    [ID.mob.SWAMFISK[2] - 2] = ID.mob.SWAMFISK[2], -- 461.268 -6.674 -391.342
    [ID.mob.SWAMFISK[2] - 1] = ID.mob.SWAMFISK[2], -- 459.345 -6.686 -363.842
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 64, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, swamfiskPHTable, 7, 3600) -- 1 hour minimum
end

return entity
