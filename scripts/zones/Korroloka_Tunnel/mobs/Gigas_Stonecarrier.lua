-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Gigas Stonecarrier
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 733, 1, xi.regime.type.GROUNDS)
end

return entity
