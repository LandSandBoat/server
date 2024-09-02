-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Deinonychus
-- Note: Place Holder for Yowie
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

local yowiePHTable =
{
    [ID.mob.YOWIE - 63] = ID.mob.YOWIE, -- 27.000 19.000 132.000
    [ID.mob.YOWIE - 60] = ID.mob.YOWIE, -- 20.000 20.000 118.000
    [ID.mob.YOWIE - 58] = ID.mob.YOWIE, -- 19.000 18.000 100.000
    [ID.mob.YOWIE - 56] = ID.mob.YOWIE, -- 18.000 21.000 82.000
    [ID.mob.YOWIE - 44] = ID.mob.YOWIE, -- 23.000 20.000 75.000
    [ID.mob.YOWIE - 43] = ID.mob.YOWIE, -- 19.000 19.000 55.000
    [ID.mob.YOWIE - 37] = ID.mob.YOWIE, -- 34.000 21.000 59.000
    [ID.mob.YOWIE - 36] = ID.mob.YOWIE, -- 59.000 21.000 65.000
    [ID.mob.YOWIE - 30] = ID.mob.YOWIE, -- 58.000 21.000 57.000
    [ID.mob.YOWIE - 29] = ID.mob.YOWIE, -- 72.000 21.000 63.000
    [ID.mob.YOWIE - 28] = ID.mob.YOWIE, -- 87.000 21.000 59.000
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 740, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, yowiePHTable, 5, math.random(7200, 28800)) -- 2 to 8 hours
end

return entity
