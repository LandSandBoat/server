-----------------------------------
-- Area: Beaucedine Glacier [S]
--  Mob: Gargouille
-- Note: PH for Grand'Goule
-----------------------------------
local ID = zones[xi.zone.BEAUCEDINE_GLACIER_S]
mixins = { require('scripts/mixins/families/gargouille') }
-----------------------------------
---@type TMobEntity
local entity = {}

local grandgoulePHTable =
{
    [ID.mob.GRANDGOULE - 7] = ID.mob.GRANDGOULE,
    [ID.mob.GRANDGOULE - 6] = ID.mob.GRANDGOULE,
    [ID.mob.GRANDGOULE - 5] = ID.mob.GRANDGOULE,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, grandgoulePHTable, 10, 3600) -- 1 hour
end

return entity
