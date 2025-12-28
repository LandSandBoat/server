-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Sabotender Sediendo
-- Note: Place Holder for Sabotender Mariachi
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 738, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local params = {}
    xi.mob.phOnDespawn(mob, ID.mob.SABOTENDER_MARIACHI, 5, 10800, params) -- 3 hours
end

return entity
