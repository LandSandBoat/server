-----------------------------------
-- Area: Abyssea - Altepa
--   NM: Bennu
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.BENNU_DEPLUMER)
    end
end

return entity
