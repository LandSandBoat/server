-----------------------------------
-- Area: Cape Teriggan
--   NM: Zmey Gorynych
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 406)
end

return entity
