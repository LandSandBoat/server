-----------------------------------
-- Spike Flail
-- Deals extreme damage in a threefold attack to targets behind the user.
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) then
        return 1
    elseif mob:hasStatusEffect(xi.effect.SUPER_BUFF) then
        return 1
    elseif mob:hasStatusEffect(xi.effect.INVINCIBLE) then
        return 1
    elseif mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) then
        return 1
    elseif target:isInfront(mob, 128) then
        return 1
    elseif mob:getAnimationSub() == 1 then
        return 1
    end
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = math.random(5, 7)
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 2, 3, 4)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, MOBPARAM_3_SHADOW)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskill_object
