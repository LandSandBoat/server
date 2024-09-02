-----------------------------------
-- Area: Davoi
--   NM: Blubbery Bulge
-- Involved in Quest: The Miraculous Dale
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 196)
end

return entity
