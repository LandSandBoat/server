-----------------------------------
-- Area: Quicksand Caves
--   NM: Mimic
-----------------------------------
mixins = { require('scripts/mixins/families/mimic') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 60)
end

entity.onMobEngage = function(mob, target)
    mob:setTP(3000)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mobSkill.DEATH_TRAP
end

return entity
