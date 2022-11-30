-----------------------------------
-- Area: Bibiki Bay
--   NM: Serra
-----------------------------------
require('scripts/globals/hunts')
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 264)
end

return entity
