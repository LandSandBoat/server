-----------------------------------
-- Area: Tahrongi Canyon
--   NM: Yara Ma Yha Who
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 256)
end

return entity
