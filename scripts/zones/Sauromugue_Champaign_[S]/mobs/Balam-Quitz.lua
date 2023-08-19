-----------------------------------
-- Area: Sauromugue Champaign [S]
--   NM: Balam-Quitz
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 529)
end

return entity
