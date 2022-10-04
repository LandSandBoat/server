-----------------------------------
-- Area: Misareaux Coast
--   NM: Okyupete
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 446)
end

return entity
