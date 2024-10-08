-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Razorjaw Pugil
-- Note: PH for Sea Hog
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

local seaHogPHTable =
{
    [ID.mob.SEA_HOG - 2] = ID.mob.SEA_HOG, -- -221.455 9.542 -44.191
    [ID.mob.SEA_HOG - 1] = ID.mob.SEA_HOG, -- -249 10 -57
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, seaHogPHTable, 10, 3600) -- 1 hour
end

return entity
