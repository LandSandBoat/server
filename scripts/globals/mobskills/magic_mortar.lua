-----------------------------------
-- Slapstick
-- Description: Damage varies with TP
-- Type: Physical
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target,mob,skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local hpdmgMod = math.floor(mob:getMaxHP() * (math.floor(0.016 * mob:getTP()) + 16) / 256)

    target:takeDamage(hpdmgMod, mob, xi.attackType.BREATH, xi.damageType.ELEMENTAL)
    return hpdmgMod
end

return mobskill_object
