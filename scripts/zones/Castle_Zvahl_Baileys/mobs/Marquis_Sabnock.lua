-----------------------------------
-- Area: Castle Zvahl Baileys
--   NM: Marquis Sabnock
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 352)
end

return entity
