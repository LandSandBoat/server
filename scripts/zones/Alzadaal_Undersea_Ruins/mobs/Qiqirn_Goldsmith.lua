-----------------------------------
-- Area: Alzadaal Undersea Ruins (72)
--  Mob: Qiqirn Goldsmith
-- Note: PH for Cookieduster Lipiroon
-----------------------------------
local ID = zones[xi.zone.ALZADAAL_UNDERSEA_RUINS]
-----------------------------------
local entity = {}

local cookiedusterPHTable =
{
    [ID.mob.COOKIEDUSTER_LIPIROON - 8] = ID.mob.COOKIEDUSTER_LIPIROON,
    [ID.mob.COOKIEDUSTER_LIPIROON - 6] = ID.mob.COOKIEDUSTER_LIPIROON,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, cookiedusterPHTable, 5, 3600) -- 1 hour
end

return entity
