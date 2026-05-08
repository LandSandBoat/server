-----------------------------------
-- Hypothermal Combustion
-- Family: Bomb (Snoll)
-- Description: Self-destructs, dealing Ice damage targets near the mob.
-- Notes: Damage is based on remaining HP
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:isMobType(xi.mobType.NOTORIOUS) then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = skill:getMobHP() / 3
    params.fTP            = { 1, 1, 1 }
    params.element        = xi.element.ICE
    params.attackType     = xi.attackType.BREATH
    params.damageType     = xi.damageType.ICE
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

mobskillObject.onMobSkillFinalize = function(mob, skill)
    mob:setHP(0)
end

return mobskillObject
