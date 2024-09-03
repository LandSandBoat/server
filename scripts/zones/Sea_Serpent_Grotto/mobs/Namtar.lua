-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Namtar
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 369)
    xi.regime.checkRegime(player, mob, 805, 2, xi.regime.type.GROUNDS)
    xi.magian.onMobDeath(mob, player, optParams, set{ 366 })
end

return entity
