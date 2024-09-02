-----------------------------------
-- Area: Meriphataud Mountains
--  Mob: Coeurl
-- Note: PH for Patripatan
-----------------------------------
local ID = zones[xi.zone.MERIPHATAUD_MOUNTAINS]
-----------------------------------
---@type TMobEntity
local entity = {}

local patripatanPHTable =
{
    [ID.mob.PATRIPATAN - 5] = ID.mob.PATRIPATAN, -- 551.767, -32.570, 590.205
    [ID.mob.PATRIPATAN - 4] = ID.mob.PATRIPATAN, -- 646.199, -24.483, 644.477
    [ID.mob.PATRIPATAN - 3] = ID.mob.PATRIPATAN, -- 535.318, -32.179, 602.055
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 63, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, patripatanPHTable, 5, math.random(3600, 10800)) -- 1 to 3 hours
end

return entity
