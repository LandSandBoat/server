-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--  Mob: Vorpal Bunny
-- Note: PH for Ratatoskr
-----------------------------------
local ID = zones[xi.zone.FORT_KARUGO_NARUGO_S]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.RATATOSKR_PH, 10, 5400) -- 90 minutes
end

return entity
