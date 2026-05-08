-----------------------------------
-- Self-Destruct
-- Family: Clusters
-- Description: The 2nd bomb in the Cluster explodes to deal Fire damage on targets in range.
-- Notes: Bomb Cluster Self Destruct - 2 Bomb up. This version blows up all bombs in the formation, killing the mob.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = skill:getMobHP()
    params.fTP            = { 0.40, 0.40, 0.40 }
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
