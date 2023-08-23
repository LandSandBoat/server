-----------------------------------
-- Area: Bibiki Bay
--   NM: Serra
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 264)
end

return entity
