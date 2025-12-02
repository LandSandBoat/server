-----------------------------------
-- Area: Horlais Peak
--  Mob: Dread Dragon
-- Mission 2-3 BCNM Fight
-----------------------------------
mixins = { require('scripts/mixins/draw_in') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PARALYZE)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.DREAD_DRAGON_SLAYER)
end

return entity
