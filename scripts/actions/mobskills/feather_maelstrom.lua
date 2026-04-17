-----------------------------------
-- Feather Maelstrom
-- Family: Yagudo
-- Description: Deals physical damage to a single target. Additional Effect: Amnesia, Bio
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Physical or Ranged PDIF?
    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 2.8, 2.8, 2.8 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture power/duration of effects
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIO, 6, 3, 60, 0, 15) -- TODO: Capture subPower (ATTP Modifier). Using Bio II value for now (15%)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AMNESIA, 1, 0, 60) -- Note: Power matters for things that attempt to remove Amnesia.
    end

    return info.damage
end

return mobskillObject
