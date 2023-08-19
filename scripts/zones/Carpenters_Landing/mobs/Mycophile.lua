-----------------------------------
-- Area: Carpenters Landing
--   NM: Mycophile
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 166)
end

return entity
