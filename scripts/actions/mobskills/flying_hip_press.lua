-----------------------------------
-- Flying Hip Press
-- Family: Bugbears
-- Description: Deals Wind damage to enemies within area of effect.
-- Note: Mob version of this skill is NOT a HP based breath attack like the BLU spell is.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 2.0, 2.0, 2.0 }
    params.element        = xi.element.WIND
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.WIND
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    if mob:getPool() == xi.mobPool.BUGBOY then
        params.fTP = 7.0
    end

    if mob:getPool() == xi.mobPool.BUGBEAR_MATMAN then
        params.fTP = 10.0
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
