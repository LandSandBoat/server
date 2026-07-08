-----------------------------------
-- Numbing Shot
-- Family: Humanoid Marksmanship Weaponskill
-- Description: Delivers a short-ranged attack that deals triple damage. Additional effect: Paralysis. Duration of effect varies with TP.
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
    params.fTP            = { 3.0, 3.0, 3.0 }
    -- params.agi_wSC        = 0.6 -- TODO: Capture if mobskill weaponskills have wSC.
    params.skipParry      = true
    params.skipGuard      = true
    params.skipBlock      = true
    params.attackType     = xi.attackType.RANGED
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobRangedMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 30, 0, xi.mobskills.calculateDuration(skill:getTP(), 60, 180))
    end

    return info.damage
end

return mobskillObject
