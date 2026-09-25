-----------------------------------
-- Area: La Theine Plateau
--  Mob: Tumbling Truffle
-----------------------------------
local ID = zones[xi.zone.LA_THEINE_PLATEAU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.TUMBLING_TRUFFLE - 1] = ID.mob.TUMBLING_TRUFFLE, -- Confirmed on retail
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 154)
    xi.regime.checkRegime(player, mob, 71, 2, xi.regime.type.FIELDS)
    xi.magian.onMobDeath(mob, player, optParams, set{ 68 })
end

return entity
