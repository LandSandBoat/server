-----------------------------------
-- Zantetsuken
-- Notes:
--  Deals heavy, short range damage to targets in front of Odin and
--  resets enmity on those hit. This ability deals damage equal to 95% of the targets maximum HP.
--  To be clear, this move does NOT reduce the targets HP by 95%, but deals damage EQUAL TO 95% of
--  their Max HP, meaning it can kill you if your HP is not at 96% or higher when you are hit by this.
--  Used immediately when Odin drops below 90%, 70%, 50%, and 30% HP.
--  And is the only ability used by The Dark Rider
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = target:getMaxHP() * 0.95

    local dmg = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.SPECIAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.SPECIAL, xi.damageType.NONE)
        mob:resetEnmity(target)
    end

    return dmg
end

return mobskillObject
