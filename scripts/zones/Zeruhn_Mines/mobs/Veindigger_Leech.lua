-----------------------------------
-- Area: Zeruhn Mines (172)
--  Mob: Veindigger Leech
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 630, 2, xi.regime.type.GROUNDS)
end

return entity
