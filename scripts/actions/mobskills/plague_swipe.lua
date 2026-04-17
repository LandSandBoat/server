-----------------------------------
-- Plague Swipe
-- Family: Khimaira
-- Description: Delivers a threefold attack in an cone effect behind user. Additional Effect: Bio, Plague
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if not target:isBehind(mob) then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 3 -- TODO: Capture numHits
    params.fTP            = { 1.0, 1.0, 1.0 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_4

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture effect powers/durations
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIO, 7, 3, 60, 0, 15) -- TODO: Capture subPower(ATTP modifier, using Bio II value for now)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 3, 60)
    end

    return info.damage
end

return mobskillObject
