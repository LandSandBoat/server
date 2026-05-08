-----------------------------------
-- Asuran Fists
-- Family: Humanoid Hand to Hand Weaponskill
-- Description: Delivers an eightfold attack. Accuracy varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- maat can only use this at 70
    if mob:getMainLvl() < 70 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getWeaponDmg()
    params.numHits          = 8
    params.fTP              = { 1.0, 1.0, 1.0 }
    --params.str_wSC        = 0.1 -- TODO: Capture if mobskill weaponskills have wSC.
    --params.vit_wSC        = 0.1 -- TODO: Capture if mobskill weaponskills have wSC.
    params.accuracyModifier = { 0, 30, 60 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.HTH
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_8

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
