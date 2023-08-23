-----------------------------------
-- Area: Lufaise Meadows
--   NM: Flockbock
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 442)
end

return entity
