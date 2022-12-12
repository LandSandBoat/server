-----------------------------------
--  Cryo_Jet
--  Description:
--  Type: Magical
--  additional effect : Paralyze
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")

-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 3, 60)

    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.ICE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    if target:hasStatusEffect(xi.effect.ELEMENTALRES_DOWN) then
        target:delStatusEffectSilent(xi.effect.ELEMENTALRES_DOWN)
    end

    mob:setLocalVar("nuclearWaste", 0)
    return dmg
end

return mobskillObject
