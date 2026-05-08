-----------------------------------
-- Dimidiation
-- Family: Humanoid Great Sword Weaponskill
-- Description: Delivers a twofold attack. Damage varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getWeaponDmg()
    params.numHits          = 2
    params.fTP              = { 2.25, 4.5, 6.75 }
    -- params.dex_wSC       = 0.8 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.SLASHING
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_2
    params.attackMultiplier = { 1.25, 1.25, 1.25 }

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
