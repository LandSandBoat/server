-----------------------------------
-- Mercurial Strike
-- Used by Briareus
-- Area of Effect magic damage centered around the target, wipes shadows. Damage varies.
-- Amount of damage done by Mercurial Strike follows a repeating numerical pattern (example: 111, 222, 333, etc up to 1111).
-- Depending on the result, a secondary effect may be triggered: The number determines the next weaponskill Briareus will use.
-- 111 = Impact Roar (through shadows, does not wipe)
-- 222 = Grand Slam (1-3 shadows)
-- 333 = Grand Slam (1-3 shadows)
-- 444 = Power Attack (1 shadow)
-- 555 = Trebuchet (1-3 shadows, does not wipe it or go through unlike Grandgrousier)
-- 666 = Trebuchet
-- 777 = JA Times Reset to 0:00 (including 2hr) / Uses Mercurial Strike on the next TP move
-- 888 = Colossal Slam
-- 999 = Colossal Slam
-- 1111 = 2hr Meikyo Shisui
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/mobskills")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local _, dmg = utils.randomEntry({ 111, 222, 333, 444, 555, 666, 777, 888, 999, 1111 })
    mob:setLocalVar("MERCURIAL_STRIKE_DAMAGE", dmg)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
