-----------------------------------
-- Bilgestorm
-- Family: Dvergr
-- Description: Deals damage in an area of effect. Additional effect: Lowers attack, accuracy, and defense
-- Notes: Only used at low health.*Experienced the use at 75%*
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Capture skill. Magic or Physical? shadowBehavior, fTPs, status effects, etc
    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 2.0, 2.0, 2.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ACCURACY_DOWN, math.random(20, 25), 0, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, math.random(20, 25), 0, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, math.random(20, 25), 0, 60)
    end

    return info.damage
end

return mobskillObject
