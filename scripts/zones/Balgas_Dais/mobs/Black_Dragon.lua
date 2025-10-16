-----------------------------------
-- Area: Balga's Dais
--  Mob: Black Dragon
-- Mission 2-3 BCNM Fight
-----------------------------------
mixins = { require('scripts/mixins/draw_in') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.SLOW)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.BLACK_DRAGON_SLAYER)
end

return entity
