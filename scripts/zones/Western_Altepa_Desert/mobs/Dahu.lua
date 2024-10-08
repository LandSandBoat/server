-----------------------------------
-- Area: Western Altepa Desert
--   NM: Dahu
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 413)
end

return entity
