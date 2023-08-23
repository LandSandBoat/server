-----------------------------------
-- Area: Pashhow Marshlands
--  Mob: Thread Leech
-- Note: PH for Bloodpool Vorax
-----------------------------------
local ID = zones[xi.zone.PASHHOW_MARSHLANDS]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 22, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 23, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BLOODPOOL_VORAX_PH, 5, 600) -- 10 minutes
end

return entity
