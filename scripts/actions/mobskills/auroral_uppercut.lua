-----------------------------------
--  Auroral Uppercut
-----------------------------------
local ID = zones[xi.zone.EMPYREAL_PARADOX]
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        target:hasStatusEffect(xi.effect.PHYSICAL_SHIELD) or
        target:hasStatusEffect(xi.effect.MAGIC_SHIELD)
    then
        return 1
    end

    mob:showText(mob, ID.text.PRISHE_TEXT + 4)

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod  = 1
    local info    = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * dmgmod, xi.element.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)

    return dmg
end

return mobskillObject
