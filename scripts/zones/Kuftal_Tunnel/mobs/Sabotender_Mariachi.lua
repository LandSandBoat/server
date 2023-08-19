-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Sabotender Mariachi
-- TODO: Auto-Regen during the day
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 417)
end

return entity
