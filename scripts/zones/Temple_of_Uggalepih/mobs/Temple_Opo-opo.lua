-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Temple Opo-opo
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 792, 2, xi.regime.type.GROUNDS)
end

return entity
