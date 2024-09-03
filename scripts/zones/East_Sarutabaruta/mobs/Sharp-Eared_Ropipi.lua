-----------------------------------
-- Area: East Sarutabaruta (116)
--   NM: Sharp-Eared Ropipi
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 254)
end

return entity
