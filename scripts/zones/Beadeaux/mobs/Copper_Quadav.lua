-----------------------------------
-- Area: Beadeaux
--  Mob: Copper Quadav
-- Note: PH for Da'Dha Hundredmask
-- Involved in Mission 3-1 (Bastok)
-----------------------------------
local ID = zones[xi.zone.BEADEAUX]
-----------------------------------
local entity = {}

local daDhaPHTable =
{
    [ID.mob.DA_DHA_HUNDREDMASK - 1] = ID.mob.DA_DHA_HUNDREDMASK,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, daDhaPHTable, 10, 5400) -- 90 minutes
end

return entity
