-----------------------------------
-- Mijin Gakure
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local hpmod = skill:getMobHPP() / 100
    local basePower = (mob:getFamily() == 335) and 4 or 6 -- Maat has a weaker (4) Mijin than usual (6)
    local power = hpmod * 10 + basePower
    local baseDmg = mob:getWeaponDmg() * power
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, baseDmg, xi.magic.ele.NONE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    if mob:isInDynamis() then -- dynamis mobs will kill themselves, other mobs might not
        mob:setHP(0)
    end

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)

    return dmg
end

return mobskill_object
