-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Corse
-- Note: PH for Citipati
-----------------------------------
local ID = zones[xi.zone.ATTOHWA_CHASM]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    local params = {}
    params.nightOnly = true
    xi.mob.phOnDespawn(mob, ID.mob.CITIPATI, 10, math.randomInt(10800, 21600), params) -- 3 to 6 hours, night only
end

return entity
