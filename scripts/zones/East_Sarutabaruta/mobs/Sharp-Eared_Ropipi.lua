-----------------------------------
-- Area: East Sarutabaruta (116)
--   NM: Sharp-Eared Ropipi
-----------------------------------
local ID = zones[xi.zone.EAST_SARUTABARUTA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.SHARP_EARED_ROPIPI + 18] = ID.mob.SHARP_EARED_ROPIPI, -- 363.152 -16.705 -326.213
    [ID.mob.SHARP_EARED_ROPIPI + 17] = ID.mob.SHARP_EARED_ROPIPI, -- 303.282 -17.642 -415.870
    [ID.mob.SHARP_EARED_ROPIPI - 2]  = ID.mob.SHARP_EARED_ROPIPI, -- 224.258 -17.858 -486.256
    [ID.mob.SHARP_EARED_ROPIPI - 1]  = ID.mob.SHARP_EARED_ROPIPI, -- 227.825 -16.978 -317.467
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 254)
end

return entity
