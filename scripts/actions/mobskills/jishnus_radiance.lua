-----------------------------------
-- Jishnu's Radiance
-- Family: Humanoid Archery Weaponskill
-- Description: Delivers a threefold attack. Chance of critical hit varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 3
    params.fTP            = { 1.75, 1.75, 1.75 }
    -- params.dex_wSC     = 0.6 -- TODO: Capture if mobskill weaponskills have wSC.
    params.skipParry      = true
    params.skipGuard      = true
    params.skipBlock      = true
    params.criticalChance = { 0.15, 0.2, 0.25 }
    params.attackType     = xi.attackType.RANGED
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3

    local info = xi.mobskills.mobRangedMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
