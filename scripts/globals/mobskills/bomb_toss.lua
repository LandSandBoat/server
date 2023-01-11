-----------------------------------
-- Bomb Toss ("Suicide Fail")
-- Throws a bomb at an enemy.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local suicideCheck = math.random(0, 100)

    if
        not mob:isNM() and
        not mob:isInDynamis() and
        suicideCheck <= 15 -- 15% chance to use bomb_toss_suicide if bomb_toss is picked (50%)
    then
        mob:useMobAbility(592)
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end

return mobskillObject
