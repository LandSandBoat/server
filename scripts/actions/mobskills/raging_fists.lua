-----------------------------------
-- Raging Fists
-- Family: Humanoid Hand to Hand Weaponskill
-- Description: Delivers a fivefold attack. Damage varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 5
    params.fTP            = { 1.0, 1.5, 2.0 }
    --params.str_wSC      = 0.2 -- TODO: Capture if mobskill weaponskills have wSC.
    --params.dex_wSC      = 0.2 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.HTH
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_5

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
