-----------------------------------
-- Area: Ghoyu's Reverie
--  Mob: Lambton Worm
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.LAMBTON_WORM_DESEGMENTER)
    end
end

return entity
