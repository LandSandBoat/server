-----------------------------------
-- Area: Beadeaux [S]
--  Mob: Gold Quadav
-- Note: PH for Da'Dha Hundredmask
-----------------------------------
local ID = zones[xi.zone.BEADEAUX_S]
-----------------------------------
---@type TMobEntity
local entity = {}

local daDhaPHTable =
{
    [ID.mob.DA_DHA_HUNDREDMASK - 100] = ID.mob.DA_DHA_HUNDREDMASK, -- -37.741 0.344 -127.037
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, daDhaPHTable, 12, 7200) -- 2 hours
end

return entity
