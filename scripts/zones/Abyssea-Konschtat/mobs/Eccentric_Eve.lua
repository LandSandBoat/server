-----------------------------------
-- Area: Abyssea - Konschtat (15)
--   NM: Eccentric Eve
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.ECCENTRICITY_EXPUNGER)
    end
end

return entity
