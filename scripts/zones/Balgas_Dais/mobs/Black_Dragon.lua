-----------------------------------
-- Area: Balga's Dais
--  Mob: Black Dragon
-- Mission 2-3 BCNM Fight
-----------------------------------
mixins = { require('scripts/mixins/draw_in') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.BLACK_DRAGON_SLAYER)
end

return entity
