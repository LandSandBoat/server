-----------------------------------
-- Area: Misareaux Coast
--  Mob: Warder Aglaia
-----------------------------------
mixins = { require('scripts/mixins/warders_cop') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobAbilityEnabled(false) -- ability use handled in mixin
    mob:setLocalVar('warder', 1)
    mob:setLocalVar('electro', 1)
end

entity.onMobDisengage = function(mob)
    -- reset variables so that disengaging mobs won't break mixin
    mob:setLocalVar('changeTime', 0)
    mob:setLocalVar('initiate', 0)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
