-----------------------------------
-- Swift Blade
-- Family: Humanoid Sword Weaponskill
-- Description: Delivers a three-hit attack. Accuracy varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    mob:messageBasic(xi.msg.basic.READIES_WS, 0, 41)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage      = mob:getWeaponDmg()
    params.numHits         = 3
    params.fTP             = { 1.5, 1.5, 1.5 }
    -- params.str_wSC         = 0.3 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.mnd_wSC         = 0.3 -- TODO: Capture if mobskill weaponskills have wSC.
    params.accuracyModifier = { 0, 30, 60 }
    params.attackType      = xi.attackType.PHYSICAL
    params.damageType      = xi.damageType.SLASHING
    params.shadowBehavior  = xi.mobskills.shadowBehavior.NUMSHADOWS_3

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
