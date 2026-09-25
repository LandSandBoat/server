-----------------------------------
-- Area: West Sarutabaruta
--   NM: Tom Tit Tat
-----------------------------------
local ID = zones[xi.zone.WEST_SARUTABARUTA]
-----------------------------------
---@type TMobEntity
local entity = {}

-- TODO: Support East/West Tom Tit Tat
entity.phList =
{
    [ID.mob.TOM_TIT_TAT[1] - 1] = ID.mob.TOM_TIT_TAT[1], -- Confirmed on retail
    [ID.mob.TOM_TIT_TAT[2] - 1] = ID.mob.TOM_TIT_TAT[2], -- Confirmed on retail
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 250)
end

return entity
