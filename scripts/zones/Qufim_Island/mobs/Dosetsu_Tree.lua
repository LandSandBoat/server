-----------------------------------
-- Area: Qufim Island
--   NM: Dosetsu Tree
-----------------------------------
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.roe.onRecordTrigger(player, 303)
end

return entity
