-----------------------------------
-- Hungry Crunch
-- Family: Bugard
-- Description: Steals an enemy's HP. Additional effects: TP Reset, Meal Steal.
-- Notes: Used by Boggelmann.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Capture if magic or physical skill.
    params.baseDamage         = mob:getMainLvl() + 2
    params.fTP                = { 2.0, 2.0, 2.0 }
    params.element            = xi.element.NONE
    params.attackType         = xi.attackType.MAGICAL
    params.damageType         = xi.damageType.NONE
    params.shadowBehavior     = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.skipMagicBonusDiff = true -- Other drain skills tested skipped MDB checks so adding this till we test physical/magical.

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.HP, info.damage))

        target:setTP(0)
        target:delStatusEffectSilent(xi.effect.FOOD) -- TODO: Does it only delete the food effect or does it steal the buff?
    end

    return info.damage
end

return mobskillObject
