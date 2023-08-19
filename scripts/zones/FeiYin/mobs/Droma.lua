-----------------------------------
-- Area: FeiYin
--  Mob: Droma
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 714, 2, xi.regime.type.GROUNDS)
end

return entity
