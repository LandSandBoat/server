-----------------------------------
-- Area: Batallia Downs
--  Mob: Stalking Sapling
-- Note: PH for Tottering Toby
-----------------------------------
local ID = zones[xi.zone.BATALLIA_DOWNS]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 72, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 73, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.TOTTERING_TOBY_PH, 20, 3600) -- 1 hour
end

return entity
