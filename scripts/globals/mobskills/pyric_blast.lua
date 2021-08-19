-----------------------------------
--  Pyric Blast
--
--  Description: Deals Fire damage to enemies within a fan-shaped area. Additional effect: Plague
--  Type: Breath
--  Ignores Shadows
--  Range: Unknown Cone
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if(mob:getFamily() == 316) then
        local mobSkin = mob:getModelId()

        if (mobSkin == 1796) then
            return 0
        else
            return 1
        end
    end

    if (mob:getAnimationSub() == 0) then
        return 0
    else
        return 1
    end
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local dmgmod = MobBreathMove(mob, target, 0.01, 0.1, xi.magic.ele.FIRE, 700)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)

    MobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 3, 60)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.FIRE)

    if (mob:getFamily() == 313 and bit.band(mob:getBehaviour(), xi.behavior.NO_TURN) == 0) then -- re-enable no turn if all three heads are up
        mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    end

    return dmg
end

return mobskill_object
