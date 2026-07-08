-----------------------------------
-- Area: Davoi
--  Mob: War Lizard
-- Note: PH for Tigerbane Bakdak
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.TIGERBANE_BAKDAK, 10, 3600) -- 1 hour
end

return entity
