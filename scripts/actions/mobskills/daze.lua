-----------------------------------
-- Daze
-- Family: Automaton
-- Description: Delivers a single ranged attack. Damage varies with TP. Additional Effect: Stun.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getWeaponDmg()
    params.numHits          = 1
    params.fTP              = { 5.0, 5.5, 6.0 }
    params.accuracyModifier = { 150, 150, 150 }
    params.attackType       = xi.attackType.RANGED
    params.damageType       = xi.damageType.PIERCING
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.skipParry        = true
    params.skipGuard        = true
    params.skipBlock        = true

    local info = xi.mobskills.mobRangedMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4)
    end

    return info.damage
end

return mobskillObject
