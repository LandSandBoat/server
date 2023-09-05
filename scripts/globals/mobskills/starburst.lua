-----------------------------------
-- Starburst
-- Deals Light or Dark elemental damage. Damage varies with TP.
-- Type: Magical
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1.8
    local attkType = xi.damageType.DARK
    local element = xi.magic.ele.DARK

    if math.random() > 0.5 then
        attkType = xi.damageType.LIGHT
        element = xi.magic.ele.DARK
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, element, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, attkType, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, attkType)
    return dmg
end

return mobskillObject
