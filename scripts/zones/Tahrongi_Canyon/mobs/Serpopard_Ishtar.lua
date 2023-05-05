-----------------------------------
-- Area: Tahrongi Canyon
--   NM: Serpopard Ishtar
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 257)
    xi.roe.onRecordTrigger(player, 279)
end

return entity
