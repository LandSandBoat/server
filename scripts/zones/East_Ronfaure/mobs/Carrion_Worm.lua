-----------------------------------
-- Area: East Ronfaure
--  Mob: Carrion Worm
-- Note: PH for Bigmouth Billy
-----------------------------------
local ID = zones[xi.zone.EAST_RONFAURE]
-----------------------------------
---@type TMobEntity
local entity = {}

local bigmouthPHTable =
{
    [ID.mob.BIGMOUTH_BILLY - 2] = ID.mob.BIGMOUTH_BILLY, -- 453.625 -18.436 -127.048
    [ID.mob.BIGMOUTH_BILLY - 1] = ID.mob.BIGMOUTH_BILLY, -- 403.967 -36.822 -16.285
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 65, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, bigmouthPHTable, 7, 1300) -- 30 minute minimum
end

return entity
