-----------------------------------
-- Area: East Sarutabaruta
--  Mob: River Crab
-- Note: PH for Duke Decapod
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 92, 1, xi.regime.type.FIELDS)
end

return entity
