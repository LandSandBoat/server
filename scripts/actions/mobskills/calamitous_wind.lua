-----------------------------------
--  Calamitous Wind
--    Mob Ability: 2433
--  Description: Destructive winds deal Wind damage to players in range.
--    Additional effect: knockback + full dispel
--  Type: Magical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: 20' radial
--  Notes: Only used by Zirnitra, Turul, and Amhuluk under 50%
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getHPP() > 50 then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.element.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    -- TODO: Should print *each* effect dispelled in addition to damage taken.
    target:dispelAllStatusEffect(bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.FOOD))
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    return dmg
end

return mobskillObject
