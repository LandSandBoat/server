-----------------------------------
-- Area: Meriphataud Mountains
--  Mob: Axe Beak
-----------------------------------
mixins = { require('scripts/mixins/families/cockatrice') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mix.cockatrice.onMobMobskillChoose(mob, target)
end

entity.onMobWeaponSkill = function(mob, target, skill)
    return xi.mix.cockatrice.onMobWeaponSkill(mob, target, skill)
end

return entity
