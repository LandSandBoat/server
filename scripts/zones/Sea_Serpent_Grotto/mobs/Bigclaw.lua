-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Bigclaw
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 807, 2, xi.regime.type.GROUNDS)
end

return entity
