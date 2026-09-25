-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Typhoon Wyvern
-- Note: Place holder Ungur
-- TODO: Ungur PHs should be in a spawn group with only 1 up at a time
-----------------------------------
local ID = zones[xi.zone.GUSTAV_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 769, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.UNGUR, 5, 7200) -- 2 hours
end

return entity
