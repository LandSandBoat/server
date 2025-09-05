-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Blighting Brand
-----------------------------------
local ID = zones[xi.zone.SAUROMUGUE_CHAMPAIGN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -206.692, y =  8.000, z =  203.594 }
}

entity.phList =
{
    [ID.mob.BLIGHTING_BRAND - 3] = ID.mob.BLIGHTING_BRAND, -- 240.725 1.853 223.185
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 275)
    xi.regime.checkRegime(player, mob, 100, 2, xi.regime.type.FIELDS)
end

return entity
