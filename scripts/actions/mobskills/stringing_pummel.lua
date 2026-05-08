-----------------------------------
-- Stringing Pummel
-- Family: Humanoid Hand to Hand Weaponskill
-- Description: Delivers a sixfold attack. Chance of critical hit varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 6
    params.fTP            = { 0.75, 0.75, 0.75 }
    --params.str_wSC      = 0.32 -- TODO: Capture if mobskill weaponskills have wSC.
    --params.vit_wSC      = 0.32 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.HTH
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_6
    params.canCrit        = true
    params.criticalChance = { 0.15, 0.30, 0.45 }

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
