-----------------------------------
-- Area: Lufaise Meadows
--   NM: Yal-un Eke
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 440)
end

return entity
