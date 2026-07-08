-----------------------------------
-- Hydro Wave
-- Family: Ruszors
-- Description: Deals Water damage to enemies around the caster. Removes 1 piece of equipment.
-- Notes: Ruszors will absorb Water damage after using this move. (Handled in Ruszor mixin)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 2.50, 2.50, 2.50 }
    params.element        = xi.element.WATER
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.WATER
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

         -- Remove 1 piece of equipment from a random slot.
        xi.mobskills.unequipRandomSlots(target, 1)
    end

    -- Water aura that provides special stoneskin that absorbs only magical/breath/non-elemental damage
    -- TODO: Make a new function to handle stoneskin types.
    skill:setFinalAnimationSub(2)
    mob:delStatusEffectSilent(xi.effect.STONESKIN)
    mob:addStatusEffect(xi.effect.STONESKIN, { duration = 180, origin = mob, subType = 2, subPower = 1500 })

    return info.damage
end

return mobskillObject
