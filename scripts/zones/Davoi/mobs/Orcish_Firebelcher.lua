-----------------------------------
-- Area: Davoi
--  Mob: Orcish Firebelcher
-- Note: PH for Poisonhand Gnadgad
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.POISONHAND_GNADGAD, 10, 3600) -- 1 hour
end

return entity
