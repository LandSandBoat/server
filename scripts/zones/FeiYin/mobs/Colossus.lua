-----------------------------------
-- Area: FeiYin
--  Mob: Colossus
-- Note: PH for Goliath
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
-----------------------------------
---@type TMobEntity
local entity = {}

local goliathPHTable =
{
    [ID.mob.GOLIATH + 7] = ID.mob.GOLIATH,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 715, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, goliathPHTable, 10, 3600) -- 1 hour
end

return entity
