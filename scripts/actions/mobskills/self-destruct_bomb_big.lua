-----------------------------------
-- Self-Destruct (Growing Bomb)
-- Description : Sacrifices user to deal massive fire damage to targets in the area.
-- Self-Destruct is only used by giant bombs that are not notorious monsters (Friar's Lanterns)
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 20' Area of Effect
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:isMobType(xi.mobType.NOTORIOUS) or -- TODO: Set skill list
        mob:getHPP() >= 90
    then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = skill:getMobHP() / 2
    params.fTP            = { 1.0, 1.0, 1.0 }
    params.element        = xi.element.FIRE
    params.attackType     = xi.attackType.BREATH
    params.damageType     = xi.damageType.FIRE
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
