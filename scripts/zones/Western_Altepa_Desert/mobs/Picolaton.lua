-----------------------------------
-- Area: Western Altepa Desert
--   NM: Picolaton
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 414)
end

return entity
