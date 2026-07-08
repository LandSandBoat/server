-----------------------------------
-- Tachi: Shoha
-- Family: Humanoid Great Katana Weaponskill
-- Description: Delivers a two-hit attack. Damage varies with TP.
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
    params.fTP              = { 1.375, 2.1875, 2.6875 }
    -- params.str_wSC       = 0.85 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackMultiplier = { 1.375, 1.375, 1.375 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.SLASHING
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_2

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
