-----------------------------------
-- Area: Ifrits Cauldron
--   NM: Tarasque
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 403)
end

return entity
