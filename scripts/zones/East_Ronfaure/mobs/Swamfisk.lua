-----------------------------------
-- Area: East Ronfaure
--   NM: Swamfisk
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 150)
end

return entity
