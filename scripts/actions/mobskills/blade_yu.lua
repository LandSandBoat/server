-----------------------------------
-- Blade: Yu
-- Family: Humanoid Katana Weaponskill
-- Description: Deals water elemental damage. Additional effect: Poison. Duration varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getMainLvl() + 2
    params.fTP              = { 2.25, 2.25, 2.25 }
    -- params.dex_wSC       = 0.28 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.int_wSC       = 0.28 -- TODO: Capture if mobskill weaponskills have wSC.
    params.element          = xi.element.WATER
    params.attackType       = xi.attackType.MAGICAL
    params.damageType       = xi.damageType.WATER
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 10, 3, math.floor(75 + 15 * skill:getTP() / 1000))
    end

    return info.damage
end

return mobskillObject
