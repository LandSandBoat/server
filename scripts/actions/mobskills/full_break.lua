-----------------------------------
-- Full Break
-- Family: Humanoid Great Axe Weaponskill
-- Description: Lowers accuracy, weakens attacks and defense, and impairs evasion of target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 1.0, 1.0, 1.0 }
    -- params.str_wSC     = 0.5 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.vit_wSC     = 0.5 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local duration = math.floor(60 + 3 * skill:getTP() / 100)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN,   12.5, 0, duration)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN,  12.5, 0, duration)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ACCURACY_DOWN, 20,   0, duration)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.EVASION_DOWN,  20,   0, duration)
    end

    return info.damage
end

return mobskillObject
