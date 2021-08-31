-----------------------------------
-- Area: Ifrits Cauldron
--   NM: Tarasque
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 403)
end

return entity
