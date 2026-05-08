-----------------------------------
-- Infernal Scythe
-- Family: Humanoid Scythe Weaponskill
-- Description: Deals darkness elemental damage. Additional effect: Lowers target's attack. Duration of effect varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getMainLvl() + 2
    params.fTP              = { 3.5, 3.5, 3.5 }
    -- params.str_wSC       = 0.3 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.int_wSC       = 0.3 -- TODO: Capture if mobskill weaponskills have wSC.
    params.element          = xi.element.DARK
    params.attackType       = xi.attackType.MAGICAL
    params.damageType       = xi.damageType.DARK
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, 25, 0, math.floor(18 * skill:getTP() / 100))
    end

    return info.damage
end

return mobskillObject
