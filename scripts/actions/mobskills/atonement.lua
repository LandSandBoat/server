-----------------------------------
-- Atonement
-- Family: Humanoid Sword Weaponskill
-- Description: Delivers a twofold attack. Damage varies with TP.
-- NOTE : The player version of this skill is based off of Enmity. TODO : Capture mob version of this skill.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.percentMultipier = 0
    params.damageCap        = 750
    params.bonusDamage      = math.floor(mob:getWeaponDmg() * 2 * xi.combat.physical.calculateTPfactor(skill:getTP(), { 1.0, 1.5, 2.0 }))
    params.resistStat       = xi.mod.INT
    params.element          = xi.element.NONE
    params.attackType       = xi.attackType.BREATH
    params.damageType       = xi.damageType.ELEMENTAL
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
