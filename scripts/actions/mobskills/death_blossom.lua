-----------------------------------
-- Death Blossom
-- Family: Humanoid Sword Weaponskill
-- Description:     Delivers a threefold attack that lowers target's magic evasion.
-- TODO: Chance of lowering target's magic evasion varies with TP.
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
    params.fTP            = { 1.125, 1.125, 1.125 }
    -- params.str_wSC        = 0.3 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.mnd_wSC        = 0.5 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_EVASION_DOWN, 10, 0, 60)
    end

    return info.damage
end

return mobskillObject
