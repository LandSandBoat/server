-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Antares
-- Note: Place holder Amikiri
-----------------------------------
local ID = zones[xi.zone.GUSTAV_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 768, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.AMIKIRI, 5, 25200) -- 7 hours
end

return entity
