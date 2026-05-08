-----------------------------------
-- Realmrazer
-- Family: Humanoid Club Weaponskill
-- Description: Delivers a sevenfold attack. Accuracy varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getWeaponDmg()
    params.numHits          = 7
    params.fTP              = { 0.88, 0.88, 0.88 }
    -- params.mnd_wSC       = 0.85 -- TODO: Capture if mobskill weaponskills have wSC.
    params.accuracyModifier = { 0, 30, 60 } -- TODO: Verify exact number.
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.BLUNT
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_7

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
