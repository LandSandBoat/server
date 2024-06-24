-----------------------------------
-- Area: Beadeaux (254)
--  Mob: Emerald Quadav
-- Note: PH for Ga'Bhu Unvanquished
-----------------------------------
local ID = zones[xi.zone.BEADEAUX]
-----------------------------------
local entity = {}

local gaBhuPHTable =
{
    [ID.mob.GA_BHU_UNVANQUISHED - 1] = ID.mob.GA_BHU_UNVANQUISHED, -- 139.642 -2.445 161.557
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, gaBhuPHTable, 10, 3600) -- 1 hour
end

return entity
