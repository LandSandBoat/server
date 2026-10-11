-----------------------------------
-- Area: Fei'Yin
--   NM: Goliath
-----------------------------------
---@type TMobEntity
local entity = {}

-- TODO:
-- Implement through the spawn slot system when chance is refactored to per-mob basis
entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.GOLIATH_KILLER)
    end
end

return entity
