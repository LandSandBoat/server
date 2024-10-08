-----------------------------------
-- Area: West Ronfaure
--  Mob: Forest Hare
-- Note: PH for Jaggedy-Eared Jack
-----------------------------------
local ID = zones[xi.zone.WEST_RONFAURE]
-----------------------------------
---@type TMobEntity
local entity = {}

local jaggedyPHTable =
{
    [ID.mob.JAGGEDY_EARED_JACK - 1] = ID.mob.JAGGEDY_EARED_JACK -- -262.780 -22.384 -253.873
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, jaggedyPHTable, 9, 2400) -- 40 minute minimum
end

return entity
