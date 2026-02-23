-----------------------------------
-- Area: Abyssea - Misareaux
--   NM: Cirein-croin
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.CIREIN_CROIN_HARPOONER)
    end
end

return entity
