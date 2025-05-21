-----------------------------------
-- Area: Arrapago Reef
--   NM: Zareehkl the Jubilant (ZNM T2)
-----------------------------------
mixins = { require('scripts/mixins/families/qutrub') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.STUN)
    mob:setLocalVar('qutrubBreakChance', 5) -- Wiki implies its weapon is harder to break
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
