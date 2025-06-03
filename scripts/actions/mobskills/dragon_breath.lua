-----------------------------------
--  Dragon Breath
--
--  Description: Deals Fire damage to enemies within a fan-shaped area.
--  Type: Breath
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown cone
--  Notes: Used only by Fafnir, Nidhogg, Cynoprosopi, and Wyrm. Because of the high damage output from Fafnir/Nidhogg/Wyrm, it is usually avoided by
--        standing on (or near) the wyrm's two front feet. Cynoprosopi's breath attack is much less painful.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if not target:isInfront(mob, 128) then
        return 1
    elseif mob:getAnimationSub() == 1 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, skill, 0.15, 1.25, xi.element.FIRE, 1596)
    dmgmod = utils.conalDamageAdjustment(mob, target, skill, dmgmod, 0.2)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.FIRE)
    return dmg
end

return mobskillObject
