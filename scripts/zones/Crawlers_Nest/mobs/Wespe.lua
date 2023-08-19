-----------------------------------
-- Area: Crawlers' Nest (197)
--  Mob: Wespe
-- Note: PH for Demonic Tiphia
-----------------------------------
local ID = zones[xi.zone.CRAWLERS_NEST]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 691, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.DEMONIC_TIPHIA_PH, 5, math.random(7200, 28800)) -- 2 to 8 hours
end

return entity
