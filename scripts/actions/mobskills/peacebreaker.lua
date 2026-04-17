-----------------------------------
-- Peacebreaker
-- Family: Humanoid (Naja Salaheem)
-- Description: Deals damage to a target. Additional Effect: Magic Defense Down
-- Notes: Peacebreaker increases Magic Damage Taken on the target (~2x Magic Damage),
--        making Naja a good fit with offensive magic jobs such as Rune Fencer.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 2.0, 2.0, 2.0 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: This should be Increases Magic Damage Taken, but this was faster/easier
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_DEF_DOWN, 50, 0, 60)
    end

    return info.damage
end

return mobskillObject
