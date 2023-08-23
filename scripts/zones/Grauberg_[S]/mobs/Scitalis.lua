-----------------------------------
-- Area: Grauberg [S]
--   NM: Scitalis
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 503)
end

return entity
