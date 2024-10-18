-----------------------------------
-- Area: Beadeaux (147)
--  Mob: Zircon Quadav
-- Notes: PH for Zo'Khu Blackcloud
--  Bowl of Quadav Stew is a guaranteed steal with
--  Quest THE_TENSHODO_SHOWDOWN active
-----------------------------------
local ID = zones[xi.zone.BEADEAUX]
-----------------------------------
---@type TMobEntity
local entity = {}

local zoKhuPHTable =
{
    [ID.mob.ZO_KHU_BLACKCLOUD - 2] = ID.mob.ZO_KHU_BLACKCLOUD, -- -294.223 -3.504 -206.657
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, zoKhuPHTable, 10, 3600) -- 1 to 5 hours
end

return entity
