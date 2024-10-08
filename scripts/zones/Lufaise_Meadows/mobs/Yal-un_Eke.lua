-----------------------------------
-- Area: Lufaise Meadows
--   NM: Yal-un Eke
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 440)
end

return entity
