-----------------------------------
-- Sarv
-- Family: Humanoid Archery Weaponskill
-- Description: Damage varies with TP.
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
    params.fTP            = { 2.75, 5.5, 8.25 }
    -- params.str_wSC     = 0.65 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.agi_wSC     = 0.65 -- TODO: Capture if mobskill weaponskills have wSC.
    params.skipParry      = true
    params.skipGuard      = true
    params.skipBlock      = true
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
