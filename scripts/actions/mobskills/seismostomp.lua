-----------------------------------
--  Seismostomp
--  Description: Damage varies with TP. Additional effect: "Stun."
--  Type: Physical (Blunt)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod  = 1
    local dmgmod  = 2.3

    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        dmgmod = dmgmod + math.random()
    end

    local info           = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES)
    local shadowsRemoved = math.random(1, 2)
    local dmg            = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, shadowsRemoved)
    local typeEffect     = xi.effect.STUN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)

    return dmg
end

return mobskillObject
