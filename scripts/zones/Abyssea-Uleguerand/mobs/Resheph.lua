-----------------------------------
-- Area: Abyssea - Uleguerand
--   NM: Resheph
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.RESHEPH_ERADICATOR)
    end
end

return entity
