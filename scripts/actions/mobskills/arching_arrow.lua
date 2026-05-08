-----------------------------------
-- Arching Arrow
-- Family: Humanoid Archery Weaponskill
-- Description: Delivers a single-hit attack. Chance of critical varies with TP.
-- Darkness/Gravitation skillchain properties.
-- NOTES: Used by Semih Lafihna
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
    params.fTP            = { 3.5, 3.5, 3.5 }
    -- params.str_wSC     = 0.16 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.agi_wSC     = 0.25 -- TODO: Capture if mobskill weaponskills have wSC.
    params.skipParry      = true
    params.skipGuard      = true
    params.skipBlock      = true
    params.criticalChance = { 0.1, 0.3, 0.5 }
    params.attackType     = xi.attackType.RANGED
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobRangedMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
