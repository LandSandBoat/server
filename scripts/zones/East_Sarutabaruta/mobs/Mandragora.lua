-----------------------------------
-- Area: East Sarutabaruta
--  Mob: Mandragora
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_H2H_PENALTY, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 89, 1, xi.regime.type.FIELDS)
end

return entity
