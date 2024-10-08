-----------------------------------
-- Area: Halvung
--   NM: Big Bomb
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 466)
end

return entity
