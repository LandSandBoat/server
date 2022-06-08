---------------------------------------------
--       Dynamis-Buburimu Mobskills        --
---------------------------------------------
---------------------------------------------
--        Module Required Scripts          --
---------------------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/status")
require("scripts/globals/msg")
require("modules/module_utils")
---------------------------------------------
local m = Module:new("era_buburimu_tp_moves")

m:addOverride("xi.globals.mobskills.mighty_strikes.onMobWeaponSkill", function(target, mob, skill)
    if mob:getLocalVar("MIGHTY_STRIKES") == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end
    
    xi.mobskills.mobBuffMove(mob, xi.effect.MIGHTY_STRIKES, 1, 0, 45)
    skill:setMsg(xi.msg.basic.USES)
    return xi.effect.MIGHTY_STRIKES
end)

m:addOverride("xi.globals.mobskills.hundred_fists.onMobWeaponSkill", function(target, mob, skill)
    if mob:getLocalVar("HUNDRED_FISTS") == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end
    
    xi.mobskills.mobBuffMove(mob, xi.effect.HUNDRED_FISTS, 1, 0, 30)
    skill:setMsg(xi.msg.basic.USES)
    return xi.effect.HUNDRED_FISTS
end)

m:addOverride("xi.globals.mobskills.benediction.onMobWeaponSkill", function(target, mob, skill)
    if mob:getLocalVar("BENEDICTION") == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end
    
    target:eraseAllStatusEffect()
    local maxHeal = target:getMaxHP() - target:getHP()
    target:addHP(maxHeal)
    target:wakeUp()
    skill:setMsg(xi.msg.basic.SELF_HEAL)
    return maxHeal
end)

m:addOverride("xi.globals.mobskills.manafont.onMobWeaponSkill", function(target, mob, skill)
    if mob:getLocalVar("MANAFONT") == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end

    xi.mobskills.mobBuffMove(mob, xi.effect.MANAFONT, 1, 0, 60)
    skill:setMsg(xi.msg.basic.USES)
    return xi.effect.MANAFONT
end)

m:addOverride("xi.globals.mobskills.chainspell.onMobWeaponSkill", function(target, mob, skill)
    if mob:getLocalVar("CHAINSPELL") == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end
    
    xi.mobskills.mobBuffMove(mob, xi.effect.CHAINSPELL, 1, 0, 60)
    skill:setMsg(xi.msg.basic.USES)
    return xi.effect.CHAINSPELL
end)

m:addOverride("xi.globals.mobskills.perfect_dodge.onMobWeaponSkill", function(target, mob, skill)
    if mob:getLocalVar("PERFECT_DODGE") == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end
    
    xi.mobskills.mobBuffMove(mob, xi.effect.PERFECT_DODGE, 1, 0, 30)
    skill:setMsg(xi.msg.basic.USES)
    return xi.effect.PERFECT_DODGE
end)

m:addOverride("xi.globals.mobskills.invincible.onMobWeaponSkill", function(target, mob, skill)
    if mob:getLocalVar("INVINCIBLE") == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end
    
    xi.mobskills.mobBuffMove(mob, xi.effect.INVINCIBLE, 1, 0, 30)
    skill:setMsg(xi.msg.basic.USES)
    return xi.effect.INVINCIBLE
end)

m:addOverride("xi.globals.mobskills.blood_weapon.onMobWeaponSkill", function(target, mob, skill)
    if mob:getLocalVar("BLOOD_WEAPON") == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end
    
    xi.mobskills.mobBuffMove(mob, xi.effect.BLOOD_WEAPON, 1, 0, 30)
    skill:setMsg(xi.msg.basic.USES)
    return xi.effect.BLOOD_WEAPON
end)

m:addOverride("xi.globals.mobskills.charm.onMobWeaponSkill", function(target, mob, skill)
    if mob:getLocalVar("CHARM") == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end
    
    local typeEffect = xi.effect.CHARM_I
    local power = 0
    if (not target:isPC()) then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return typeEffect
    end
    local msg = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 150)
    if (msg == xi.msg.basic.SKILL_ENFEEB_IS) then
        mob:charm(target)
    end
    skill:setMsg(msg)
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.soul_voice.onMobWeaponSkill", function(target, mob, skill)
    if mob:getLocalVar("SOUL_VOICE") == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end
    
    xi.mobskills.mobBuffMove(mob, xi.effect.SOUL_VOICE, 1, 0, 180)
    skill:setMsg(xi.msg.basic.USES)
    return xi.effect.SOUL_VOICE
end)

m:addOverride("xi.globals.mobskills.eagle_eye_shot.onMobWeaponSkill", function(target, mob, skill)
    if mob:getLocalVar("EAGLE_EYE_SHOT") == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end
    
    local numhits = 1
    local accmod = 2
    local dmgmod = 9 + math.random()
    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)
    if dmg > 0 then
       target:addTP(20)
       mob:addTP(80)
    end
    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.meikyo_shisui.onMobWeaponSkill", function(target, mob, skill)
    if mob:getLocalVar("MEIKYO_SHISUI") == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end
    
    xi.mobskills.mobBuffMove(mob, xi.effect.MEIKYO_SHISUI, 1, 0, 30)
    skill:setMsg(xi.msg.basic.USES)
    mob:addTP(3000)
    return xi.effect.MEIKYO_SHISUI
end)

m:addOverride("xi.globals.mobskills.mijin_gakure.onMobWeaponSkill", function(target, mob, skill)
    if mob:getLocalVar("MIJIN_GAKURE") == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end
    
    local dmgmod = 1
    local hpmod = skill:getMobHPP() / 100
    local basePower = (mob:getFamily() == 335) and 4 or 6 -- Maat has a weaker (4) Mijin than usual (6)
    local power = hpmod * 10 + basePower
    local baseDmg = mob:getWeaponDmg() * power
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, baseDmg, xi.magic.ele.NONE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    if mob:isInDynamis() then -- dynamis mobs will kill themselves, other mobs might not
        mob:setHP(0)
    end
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)
    return dmg
end)

return m
