-----------------------------------
-- Nether Tempest
-- Family: Avatar (Diabolos)
-- Description:
-- Notes: Likely an AOE version of Nether Blast
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Capture fTPs/damage formula
    params.baseDamage     = mob:getMainLvl()
    params.additiveDamage = { 10, 10, 10 }
    params.fTP            = { 5, 5, 5 }
    params.element        = xi.element.DARK
    params.attackType     = xi.attackType.BREATH
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
