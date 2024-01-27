-----------------------------------
-- Area: Cape Teriggan
--   NM: Frostmane
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 405)
end

return entity
