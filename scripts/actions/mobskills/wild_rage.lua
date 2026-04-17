-----------------------------------
-- Wild Rage
-- Family: Scorpion
-- Description: Deals physical damage to enemies within area of effect.
-- Notes: Has additional effect of Poison when used by King Vinegarroon.
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
    params.fTP            = { 2.0, 2.0, 2.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior

    if mob:getPool() == xi.mobPool.PLATOON_SCORPION then
        local battlefield = mob:getBattlefield()

        if battlefield then
            local scorpionMultiplier = battlefield:getLocalVar('scorpionsDefeated') * 0.5
            local fTP = 2.0 + scorpionMultiplier

            params.fTP = { fTP, fTP, fTP }
        end
    end

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        if mob:getPool() == xi.mobPool.KING_VINEGARROON then
            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 25, 3, 60)
        end
    end

    return info.damage
end

return mobskillObject
