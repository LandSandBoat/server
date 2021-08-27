-----------------------------------
-- Area: Yhoator Jungle
--   NM: Edacious Opo-opo
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 366)
end

return entity
