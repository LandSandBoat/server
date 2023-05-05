-----------------------------------
-- Area: Beaucedine Glacier
--   NM: Nue
-----------------------------------
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.roe.onRecordTrigger(player, 291)
end

return entity
