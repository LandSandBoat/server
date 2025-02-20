-----------------------------------
-- Area: Yhoator Jungle
--   NM: Hoar-knuckled Rimberry
--   WOTG Nov 2009 NM: Immune to Bind, Sleep, Gravity.
-----------------------------------
mixins = { require('scripts/mixins/families/tonberry') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 368)
    xi.regime.checkRegime(player, mob, 133, 1, xi.regime.type.FIELDS)
end

return entity
