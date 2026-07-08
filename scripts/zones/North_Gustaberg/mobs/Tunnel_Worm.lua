-----------------------------------
-- Area: North Gustaberg
--  Mob: Tunnel Worm
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.EXP_LVL_MOD, -2) -- Subtract 2 levels for /check and exp purposes
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 16, 1, xi.regime.type.FIELDS)
end

return entity
