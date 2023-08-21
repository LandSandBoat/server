-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Sacrificial Goblet
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 391)
end

return entity
