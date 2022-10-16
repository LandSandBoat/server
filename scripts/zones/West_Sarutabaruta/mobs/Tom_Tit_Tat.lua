-----------------------------------
-- Area: West Sarutabaruta
--   NM: Tom Tit Tat
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 250)
end

return entity
