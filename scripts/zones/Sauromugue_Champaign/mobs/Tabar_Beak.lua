-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Tabar Beak
-- Note: PH for Deadly Dodo
-----------------------------------
local ID = zones[xi.zone.SAUROMUGUE_CHAMPAIGN]
-----------------------------------
---@type TMobEntity
local entity = {}

local deadlyDodoPHTable =
{
    [ID.mob.DEADLY_DODO - 2] = ID.mob.DEADLY_DODO, -- 238.000 40.000 332.000
    [ID.mob.DEADLY_DODO - 1] = ID.mob.DEADLY_DODO, -- 369.564 39.658 345.197
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 100, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, deadlyDodoPHTable, 33, 3600) -- 1 hour
end

return entity
