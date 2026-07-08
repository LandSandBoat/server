-----------------------------------
-- Area: Abyssea - Vunkerl
--   NM: Sedna
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.SEDNA_TUSKBREAKER)
    end
end

return entity
