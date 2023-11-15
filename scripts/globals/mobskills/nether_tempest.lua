-----------------------------------
-- Nether Tempest
-- AoE Nether Blast
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- Diabolos Dynamis Tavnazia tosses nether tempest for a reported 661 dmg
    -- Diabolos are lvl 85.   A multiplier of 7.77 hits 661
    local multiplier = 7.77
    local dmg = mob:getMainLvl() * multiplier -- http://wiki.ffo.jp/html/4045.html
    local dmgmod = 1
    local ignoreres = true

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, dmg, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, ignoreres)

    dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end

return mobskillObject
