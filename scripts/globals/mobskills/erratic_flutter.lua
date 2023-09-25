-----------------------------------
-- Erratic Flutter
--
-- Description: Deals Fire damage around the caster. Grants the effect of Haste.
-- Family: Wamoura
-- Monipulators: Wamoura (MON), Coral Wamoura (MON)
-- Level (Monstrosity): 60
-- TP Cost (Monstrosity): 1500 TP
-- Type: Enhancing
-- Element: Fire
-- Can be dispelled: Yes
-- Notes:
-- Blue magic version is 307/1024 haste for 5 minutes. Wamaora haste is presumed identical.
-- Wamoura version also deals Fire damage to targets around the wamoura.
-- While it does not overwrite most forms of Slowga, Slow II, Slow II TP moves,
-- Erratic Flutter does overwrite Hojo: Ni, Hojo: Ichi, and Slow.
-- Player Blue magic version is wind element instead of fire.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 1.5, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg , mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    xi.mobskills.mobBuffMove(mob, xi.effect.HASTE, 2998, 0, 300) -- There is no message for the self buff aspect, only dmg.

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end

return mobskillObject
