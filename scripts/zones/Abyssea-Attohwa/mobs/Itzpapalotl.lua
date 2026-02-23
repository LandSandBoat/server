-----------------------------------
-- Area: Abyssea - Attohwa
--   NM: Itzpapalotl
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.ITZPAPALOTL_DECLAWER)
    end
end

return entity
