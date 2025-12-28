-----------------------------------
-- Area: La Theine Plateau
--  Mob: Tumbling Truffle
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
local ID = zones[xi.zone.LA_THEINE_PLATEAU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.TUMBLING_TRUFFLE - 3] = ID.mob.TUMBLING_TRUFFLE, -- 450.472 70.657 238.237
}

entity.spawnPoints =
{
    { x = 339.000, y = 56.000, z = 155.000 },
    { x = 384.000, y = 71.000, z = 205.000 },
    { x = 467.000, y = 71.000, z = 239.000 },
    { x = 528.000, y = 70.000, z = 278.000 },
    { x = 592.000, y = 59.000, z = 297.000 },
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 154)
    xi.regime.checkRegime(player, mob, 71, 2, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
    xi.magian.onMobDeath(mob, player, optParams, set{ 68 })
end

return entity
