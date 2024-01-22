-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Corse
-- Note: PH for Citipati
-----------------------------------
local ID = zones[xi.zone.ATTOHWA_CHASM]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local params = {}
    params.nightOnly = true
    xi.mob.phOnDespawn(mob, ID.mob.CITIPATI_PH, 20, math.random(10800, 21600), params) -- 3 to 6 hours, night only
end

return entity
