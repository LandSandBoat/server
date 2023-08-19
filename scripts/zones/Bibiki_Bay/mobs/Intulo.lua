-----------------------------------
-- Area: Bibiki Bay
--   NM: Intulo
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 265)
end

return entity
