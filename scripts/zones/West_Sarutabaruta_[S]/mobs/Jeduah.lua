-----------------------------------
-- Area: West Sarutabaruta [S]
--   NM: Jeduah
-----------------------------------
local ID = zones[xi.zone.WEST_SARUTABARUTA_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.JEDUAH - 1] = ID.mob.JEDUAH, -- 113.797 -0.8 -310.342
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 517)
end

return entity
