-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Sea Hog
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -233.000, y =  10.000, z = -59.000 }
}

entity.phList =
{
    [ID.mob.SEA_HOG - 2] = ID.mob.SEA_HOG, -- -221.455 9.542 -44.191
    [ID.mob.SEA_HOG - 1] = ID.mob.SEA_HOG, -- -249 10 -57
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 376)
end

return entity
