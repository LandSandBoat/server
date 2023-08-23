-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Hati
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 637, 2, xi.regime.type.GROUNDS)
end

return entity
