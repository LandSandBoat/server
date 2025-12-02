-----------------------------------
-- Area: Davoi
--  Mob: Orcish Nightraider
-- Note: PH for Poisonhand Gnadgad
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.POISONHAND_GNADGAD, 10, 3600) -- 1 hour
end

return entity
