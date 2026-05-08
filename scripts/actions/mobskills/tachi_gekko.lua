-----------------------------------
-- Tachi: Gekko
-- Family: Humanoid Great Katana Weaponskill
-- Description: Silences target. Damage varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getWeaponDmg()
    params.numHits          = 1
    params.fTP              = { 1.5625, 1.88, 2.5 }
    -- params.str_wSC       = 0.75 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackMultiplier = { 2.0, 2.0, 2.0 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.SLASHING
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 45)
    end

    return info.damage
end

return mobskillObject
