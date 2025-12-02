-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Deinonychus
-- Note: Place Holder for Yowie
-- TODO: Yowie PHs should be in a spawn group
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 740, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local params = {}
    xi.mob.phOnDespawn(mob, ID.mob.YOWIE, 5, 7200, params) -- 2 hours
end

return entity
