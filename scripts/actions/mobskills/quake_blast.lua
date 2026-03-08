-----------------------------------
-- Quake Blast
-- Family: Antlions
-- Description: Deals Earth damage to enemies within area of effect. Additional Effect: Unequip All Equipment
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage      = mob:getMainLvl() + 2
    params.fTP             = { 3.0, 3.0, 3.0 }
    params.element         = xi.element.EARTH
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.EARTH
    params.shadowBehavior  = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    params.dStatMultiplier = 1

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        for i = xi.slot.MAIN, xi.slot.BACK do
            target:unequipItem(i)
        end
    end

    return info.damage
end

return mobskillObject
