-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Young Opo-opo
-- Note: PH for Mischievous Micholas
-----------------------------------
local ID = zones[xi.zone.YUHTUNGA_JUNGLE]
-----------------------------------
local entity = {}

local micholasPHTable =
{
    [ID.mob.MISCHIEVOUS_MICHOLAS - 1] = ID.mob.MISCHIEVOUS_MICHOLAS, -- -265.616 -0.5 -24.389
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 126, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 128, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, micholasPHTable, 20, 3600) -- 1 hour
end

return entity
