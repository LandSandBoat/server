-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Doom Warlock
-- Note: Place holder Taxim
-----------------------------------
local ID = zones[xi.zone.GUSTAV_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 765, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 766, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 769, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.TAXIM, 5, 7200) -- 2 hours
end

return entity
