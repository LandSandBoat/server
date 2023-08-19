-----------------------------------
-- Area: Qufim Island
--   NM: Trickster Kinetix
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 307)
end

return entity
