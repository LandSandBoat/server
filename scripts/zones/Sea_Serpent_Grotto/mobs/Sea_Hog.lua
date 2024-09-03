-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Sea Hog
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 376)
end

return entity
