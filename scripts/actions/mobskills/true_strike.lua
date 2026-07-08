-----------------------------------
-- True Strike
-- Family: Humanoid Club Weaponskill
-- Description: Deals critical damage. Accuracy varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    mob:messageBasic(xi.msg.basic.READIES_WS, 0, 166)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getWeaponDmg()
    params.numHits          = 1
    params.fTP              = { 1.0, 1.0, 1.0 }
    -- params.str_wSC       = 0.5 -- TODO: Capture if mobskill weaponskills have wSC.
    params.canCrit          = true
    params.criticalChance   = { 1.0, 1.0, 1.0 }
    params.accuracyModifier = { -50, -50, -50 }
    params.attackMultiplier = { 2.0, 2.0, 2.0 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.BLUNT
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
