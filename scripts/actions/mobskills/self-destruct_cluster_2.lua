-----------------------------------
-- Self-Destruct
-- Family: Clusters
-- Description: The 2nd bomb in the Cluster explodes to deal Fire damage on targets in range.
-- Notes: Bomb Cluster Self Destruct - 2 Bomb up
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

    if mob:getPool() == xi.mobPool.RAZON then
        params.baseDamage = mob:getMaxHP()
        params.fTP        = { 0.50, 0.50, 0.50 }

        if mob:getHPP() <= 33 then
            params.baseDamage = 0
        end
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    skill:setFinalAnimationSub(6) -- TODO: Standardize cluster spawn animations.

    return info.damage
end

return mobskillObject
