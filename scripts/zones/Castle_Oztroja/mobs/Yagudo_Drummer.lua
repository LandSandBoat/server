-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Drummer
-- Note: PH for Mee Deggi the Punisher
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.MEE_DEGGI_THE_PUNISHER, 5, 3000) -- 50 minutes
end

return entity
