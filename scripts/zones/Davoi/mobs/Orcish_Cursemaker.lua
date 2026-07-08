-----------------------------------
-- Area: Davoi
--  Mob: Orcish Cursemaker
-- Note: PH for Hawkeyed Dnatbat
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.HAWKEYED_DNATBAT, 10, 3600) -- 1 hour
end

return entity
