-----------------------------------
-- Area: Fei'Yin
--   NM: Jenglot
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 348)
end

return entity
