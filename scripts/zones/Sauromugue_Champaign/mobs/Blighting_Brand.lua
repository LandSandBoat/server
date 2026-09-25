-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Blighting Brand
-----------------------------------
local ID = zones[xi.zone.SAUROMUGUE_CHAMPAIGN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.BLIGHTING_BRAND - 4] = ID.mob.BLIGHTING_BRAND, -- Confirmed on retail
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 275)
    xi.regime.checkRegime(player, mob, 100, 2, xi.regime.type.FIELDS)
end

return entity
