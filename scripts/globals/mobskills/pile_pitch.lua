-----------------------------------
--  Pile Pitch
--
--  Description:  Reduces target's HP to 5% of its maximum value, ignores Utsusemi  , Bind (30 sec)
--  Type: Magical
--
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    -- skillList  54 = Omega
    -- skillList 727 = Proto-Omega
    -- skillList 728 = Ultima
    -- skillList 729 = Proto-Ultima
    local skillList = mob:getMobMod(xi.mobMod.SKILL_LIST)
    local mobhp = mob:getHPP()

    if ((skillList == 54 and mobhp < 26) or (skillList == 727 and mob:getAnimationSub() == 1)) then
        return 0
    else
        return 1
    end
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local currentHP = target:getHP()
    local damage = currentHP * .90
    local typeEffect = xi.effect.BIND
    local dmg = MobFinalAdjustments(damage,mob,skill,target, xi.attackType.MAGICAL, xi.damageType.NONE,MOBPARAM_IGNORE_SHADOWS)
    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 30)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.NONE)
    mob:resetEnmity(target)
    return dmg
end
return mobskill_object
