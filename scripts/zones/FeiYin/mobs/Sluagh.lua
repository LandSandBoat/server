-----------------------------------
-- Area: FeiYin
--   NM: Sluagh
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 349)
end

return entity
