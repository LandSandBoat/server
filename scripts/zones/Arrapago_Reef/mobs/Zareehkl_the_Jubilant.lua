-----------------------------------
-- Area: Arrapago Reef
--   NM: Zareehkl the Jubilant
-----------------------------------
mixins = { require('scripts/mixins/families/qutrub') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('qutrubBreakChance', 5) -- Wiki implies its weapon is harder to break
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
