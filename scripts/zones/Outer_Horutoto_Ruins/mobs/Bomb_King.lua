-----------------------------------
-- Area: Outer Horutoto Ruins (194)
--   NM: Bomb King
-----------------------------------
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.roe.onRecordTrigger(player, 275)
end

return entity
