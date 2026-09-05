-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Cockatrice
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

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 772, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 773, 2, xi.regime.type.GROUNDS)
end

return entity
