-----------------------------------
-- Empty Salvation
-- Damages all targets in range with the salvation of emptiness. Additional effect: Dispels 3 effects
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- This move is currently coded as blinkable (3 shadows)
    -- Unknown if it should be blinkable
    -- Unknown if the dispels are an additional effect
    target:dispelStatusEffect(xi.effectFlag.DISPELABLE)
    target:dispelStatusEffect(xi.effectFlag.DISPELABLE)
    target:dispelStatusEffect(xi.effectFlag.DISPELABLE)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    end

    return dmg
end

return mobskillObject
