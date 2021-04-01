-----------------------------------
-- Demonic Flower
-- Deals magic damage to a single target.
-- Effect varies with HP and inflicts caster with weakness.
-- Deals souleater like damage to the user.
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.WEAKNESS
    local dmg1 = mob:getHP()*0.24
    local dmg2 = dmg1*0.5
    -- The dmg amounts and duration are guesstimated based on wiki info.
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, 90))

    mob:takeDamage(dmg1)
    target:takeDamage(dmg2, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)

    return dmg2
end

return mobskill_object
