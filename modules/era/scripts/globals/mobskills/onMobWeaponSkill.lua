-----------------------------------
-- AirSkyBoat Lua Module
-- Used to change mobskills luas to era values and use era weaponskills global.
-----------------------------------
require("modules/module_utils")
require("scripts/globals/magic")
require("scripts/globals/mobskills")
-----------------------------------
local m = Module:new("mobskills_onMobWeaponSkill")

m:addOverride("xi.globals.mobskills.10000_needles.onMobWeaponSkill", function(target, mob, skill)
    local needles = 10000 / skill:getTotalTargets()
    local dmg     = xi.mobskills.mobFinalAdjustments(needles, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.LIGHT)

    return dmg
end)

m:addOverride("xi.globals.mobskills.1000_needles.onMobWeaponSkill", function(target, mob, skill)
    local needles = 1000 / skill:getTotalTargets()

    local dmg     = xi.mobskills.mobFinalAdjustments(needles, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.LIGHT)

    return dmg
end)

m:addOverride("xi.globals.mobskills.2000_needles.onMobWeaponSkill", function(target, mob, skill)
    local needles = 2000 / skill:getTotalTargets()
    local dmg     = xi.mobskills.mobFinalAdjustments(needles, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.LIGHT)

    return dmg
end)

m:addOverride("xi.globals.mobskills.4000_needles.onMobWeaponSkill", function(target, mob, skill)
    local needles = 4000 / skill:getTotalTargets()
    local dmg     = xi.mobskills.mobFinalAdjustments(needles, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.LIGHT)

    return dmg
end)

m:addOverride("xi.globals.mobskills.abrasive_tantara.onMobWeaponSkill", function(target, mob, skill)
    local power    = 1
    local duration = 60

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AMNESIA, power, 0, duration))

    return xi.effect.AMNESIA
end)

m:addOverride("xi.globals.mobskills.absolute_terror.onMobWeaponSkill", function(target, mob, skill)
    local power    = 30
    local duration = 30 --  Reference: http://wiki.ffxiclopedia.org/wiki/Absolute_Terror

    if skill:isAoE() then
        duration = math.random(10, 18)
    else
        duration = 10 + math.random(0, 40)
    end

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.TERROR, power, 0, duration))

    return xi.effect.TERROR
end)

m:addOverride("xi.globals.mobskills.absorbing_kiss.onMobWeaponSkill", function(target, mob, skill)
    local drained = 0
    local threshold = 7

    local effects =
    {
        { xi.effect.STR_DOWN, 17, 10, 180 },
        { xi.effect.DEX_DOWN, 17, 10, 180 },
        { xi.effect.VIT_DOWN, 17, 10, 180 },
        { xi.effect.AGI_DOWN, 17, 10, 180 },
        { xi.effect.INT_DOWN, 17, 10, 180 },
        { xi.effect.MND_DOWN, 17, 10, 180 },
        { xi.effect.CHR_DOWN, 17, 10, 180 }
    }

    for _, eff in pairs(effects) do
        if math.random() < threshold then
            skill:setMsg(xi.mobskills.mobDrainAttribute(mob, target, eff[1], eff[2], eff[3], eff[4]))
            drained = drained + 1
        end
    end

    return drained
end)

m:addOverride("xi.globals.mobskills.abyssal_drain.onMobWeaponSkill", function(target, mob, skill)
    -- TODO: Implement this
    return 0
end)

m:addOverride("xi.globals.mobskills.abyssal_strike.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.abyss_blast.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 20, 0, 120)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 2.5, 3.5, 4.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)

    return dmg
end)

m:addOverride("xi.globals.mobskills.acid_breath.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, 10, 15, 180)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 1, xi.magic.ele.WATER, 200)
    local dmg    = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)

    return dmg
end)

m:addOverride("xi.globals.mobskills.acid_mist.onMobWeaponSkill", function(target, mob, skill)
    local power = 50
    if skill:getID() == 1872 then -- Nightmare Leech - Reduces to 1 attack
        power = 99
    end

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, power, 0, math.random(60, 120))

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WATER, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)

    return dmg
end)

m:addOverride("xi.globals.mobskills.acid_spray.onMobWeaponSkill", function(target, mob, skill)
    local power = math.max(1, (mob:getMainLvl() / 10)) * 2

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 3, 60)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WATER, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)

    return dmg
end)

m:addOverride("xi.globals.mobskills.acrid_stream.onMobWeaponSkill", function(target, mob, skill)
    local power    = 20
    local duration = 120

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_DEF_DOWN, power, 0, duration)

    local dmgmod = 1
    local info   = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3.5, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)

    return dmg
end)

m:addOverride("xi.globals.mobskills.actinic_burst.onMobWeaponSkill", function(target, mob, skill)
    local power    = 200
    local duration = 20

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FLASH, power, 0, duration))

    return xi.effect.FLASH
end)

m:addOverride("xi.globals.mobskills.activate.onMobWeaponSkill", function(target, mob, skill)
    mob:spawnPet()
    skill:setMsg(xi.msg.basic.NONE)

    return 0
end)

m:addOverride("xi.globals.mobskills.aegis_schism.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 75, 0, 120)
    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.aeolian_void.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 15, 0, 60)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.25, 2.5, xi.magic.ele.EARTH, 300)
    local dmg    = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.EARTH)

    return dmg
end)

m:addOverride("xi.globals.mobskills.aerial_armor.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BLINK, 3, 0, 180))

    return xi.effect.BLINK
end)

m:addOverride("xi.globals.mobskills.aerial_blast.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local dStatMult = 1 -- This allows us to calculate dInt for summoners 2hr
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 9, 9, 9, dStatMult)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    return dmg
end)

m:addOverride("xi.globals.mobskills.aerial_collision.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod  = 1
    local dmgmod  = 1
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 10, 0, 30)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)

    return dmg
end)

m:addOverride("xi.globals.mobskills.aerial_wheel.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.aero_ii.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info   = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    return dmg
end)

m:addOverride("xi.globals.mobskills.aero_iv.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2
    local info   = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    return dmg
end)

m:addOverride("xi.globals.mobskills.aero_meeble_warble.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2
    local info   = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 9, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 0, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CHOKE, 50, 3, 60)

    return dmg
end)

m:addOverride("xi.globals.mobskills.airy_shield.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.ARROW_SHIELD, 1, 0, 60))

    return xi.effect.ARROW_SHIELD
end)

m:addOverride("xi.globals.mobskills.amatsu_hanaikusa.onMobWeaponSkill", function(target, mob, skill)
    local power    = 22.5
    local duration = 60
    local numhits = 1
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5625, 1.875, 2.50)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        target:addStatusEffect(xi.effect.PARALYSIS, power, 0, duration)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.amatsu_kazakiri.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.50, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.amatsu_torimai.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.50, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.amatsu_tsukikage.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5625, 1.875, 2.50)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.amatsu_tsukioboro.onMobWeaponSkill", function(target, mob, skill)
    local power    = 1
    local duration = 60
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5625, 1.875, 2.50)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        target:addStatusEffect(xi.effect.SILENCE, power, 0, duration)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.amatsu_yukiarashi.onMobWeaponSkill", function(target, mob, skill)
    local power    = 1
    local duration = 60
    local numhits = 1
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5625, 1.875, 2.50)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        target:addStatusEffect(xi.effect.BIND, power, 0, duration)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.amber_scutum.onMobWeaponSkill", function(target, mob, skill)
    local status = mob:getStatusEffect(xi.effect.DEFENSE_BOOST)
    local power  = 100

    if status ~= nil then
        -- This is as accurate as we get until effects applied by mob moves can use subpower..
        power = status:getPower() * 2
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, power, 0, 60))

    return xi.effect.DEFENSE_BOOST
end)

m:addOverride("xi.globals.mobskills.amon_drive.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    if not skill:hasMissMsg() then
        -- should all be changed to mobPhysicalStatusEffectMove
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 25, 0, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PETRIFICATION, 1, 0, math.random(8, 15) + mob:getMainLvl() / 3)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, math.ceil(mob:getMainLvl() / 5), 3, 60)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.amorphic_spikes.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, .6, .85, 1.1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.amplification.onMobWeaponSkill", function(target, mob, skill)
    local mabTotal = mob:getStatusEffect(xi.effect.MAGIC_ATK_BOOST)
    local mdbTotal = mob:getStatusEffect(xi.effect.MAGIC_DEF_BOOST)

    if mob:getStatusEffect(xi.effect.MAGIC_ATK_BOOST) ~= nil then -- mag atk bonus stacking
        mabTotal = mabTotal:getPower() + 10
    else
        mabTotal = 10
    end

    if mob:getStatusEffect(xi.effect.MAGIC_DEF_BOOST) ~= nil then -- mag def bonus stacking
        mdbTotal = mdbTotal:getPower() + 10
    else
        mdbTotal = 10
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_ATK_BOOST, mabTotal, 0, 180))
    xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_DEF_BOOST, mdbTotal, 0, 180)

    return xi.effect.MAGIC_ATK_BOOST
end)

m:addOverride("xi.globals.mobskills.animating_wail.onMobWeaponSkill", function(target, mob, skill)
    local power    = 1500
    local duration = 300

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.HASTE, power, 0, duration))

    return xi.effect.HASTE
end)

m:addOverride("xi.globals.mobskills.antigravity.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)

    return dmg
end)

m:addOverride("xi.globals.mobskills.antigravity_1.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info   = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:delHP(dmg)

    return dmg
end)

m:addOverride("xi.globals.mobskills.antigravity_2.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info   = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:delHP(dmg)

    return dmg
end)

m:addOverride("xi.globals.mobskills.antigravity_3.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local info   = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:delHP(dmg)

    return dmg
end)

m:addOverride("xi.globals.mobskills.antimatter.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.0
    local info   = xi.mobskills.mobMagicalMove(mob, target, skill, 750, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)

    return dmg
end)

m:addOverride("xi.globals.mobskills.antiphase.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60))

    return xi.effect.SILENCE
end)

m:addOverride("xi.globals.mobskills.apocalyptic_ray.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DOOM, 10, 3, 30))

    return xi.effect.DOOM
end)

m:addOverride("xi.globals.mobskills.aqua_ball.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, 10, 10, 180)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WATER, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)

    return dmg
end)

m:addOverride("xi.globals.mobskills.aqua_ball_knockback.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1.5, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)

    skill:setMsg(xi.msg.basic.HIT_DMG)
    return dmg
end)

m:addOverride("xi.globals.mobskills.aqua_blast.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)

    return dmg
end)

m:addOverride("xi.globals.mobskills.aqua_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 1, xi.magic.ele.WATER, 500)
    local dmg    = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)

    return dmg
end)

m:addOverride("xi.globals.mobskills.arcane_stomp.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_SHIELD, 2, 0, 300))

    return xi.effect.MAGIC_SHIELD
end)

m:addOverride("xi.globals.mobskills.arching_arrow.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.arctic_impact.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info   = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.magic.ele.ICE, dmgmod, 0)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)

    return dmg
end)

m:addOverride("xi.globals.mobskills.arcuballista.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.ark_guardian_tarutaru.onMobWeaponSkill", function(target, mob, skill)
    mob:useMobAbility(mob:getMobMod(xi.mobMod.TELEPORT_END))
    skill:setMsg(xi.msg.basic.NONE)

    return 0
end)

m:addOverride("xi.globals.mobskills.armor_break.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.25

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 40, 0, 120 + (skill:getTP() / 1000 * 60))

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.armor_buster.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2.5
    local info   = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.WEIGHT, 20, 3, 45)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)

    return dmg
end)

m:addOverride("xi.globals.mobskills.armor_piercer.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.arm_block.onMobWeaponSkill", function(target, mob, skill)
    local defBoost = 25
    if mob:isInDynamis() then
        defBoost = 50
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, defBoost, 0, 60))

    return xi.effect.DEFENSE_BOOST
end)

m:addOverride("xi.globals.mobskills.artificial_gravity.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 15, 0, 60)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)

    return dmg
end)

m:addOverride("xi.globals.mobskills.artificial_gravity_1.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info   = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 15, 0, 60)
    target:delHP(dmg)

    return dmg
end)

m:addOverride("xi.globals.mobskills.artificial_gravity_2.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info   = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 30, 0, 60)
    target:delHP(dmg)

    return dmg
end)

m:addOverride("xi.globals.mobskills.artificial_gravity_3.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local info   = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 60, 0, 60)
    target:delHP(dmg)

    return dmg
end)

m:addOverride("xi.globals.mobskills.ascetics_fury.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1.1 , 1.3, 1.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.asthenic_fog.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DROWN, 15, 3, 120))

    return xi.effect.DROWN
end)

m:addOverride("xi.globals.mobskills.astral_flow.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.msg.basic.USES)
    local mobID = mob:getID()
    local pos = mob:getPos()
    local avatar = 0

    if mob:isInDynamis() then
        local mobInfo = xi.dynamis.mobList[mob:getZoneID()][mob:getZone():getLocalVar((string.format("MobIndex_%s", mob:getID())))]

        if mobInfo ~= nil and mobInfo.info[2] == "Apocalyptic Beast" then
            if mob:getLocalVar("ASTRAL_FLOW") == 1 then
                skill:setMsg(xi.msg.basic.NONE)
                return xi.effect.NONE
            end

            xi.dynamis.spawnDynamicPet(target, mob, xi.job.SMN)
        elseif mobInfo ~= nil and mobInfo.info[2] == "Dagourmarche" then
            xi.dynamis.spawnDynamicPet(target, mob, xi.job.SMN)
        end
    else
        if xi.astralflow.avatarOffsets[mobID] then
            avatar = mobID + xi.astralflow.avatarOffsets[mobID]
        else
            avatar = mobID + 2 -- default offset
        end

        if not GetMobByID(avatar):isSpawned() then
            GetMobByID(avatar):setSpawn(pos.x + 1, pos.y, pos.z + 1, pos.rot)
            SpawnMob(avatar):updateEnmity(mob:getTarget())
        end
    end

    return xi.effect.ASTRAL_FLOW
end)

local function petInactive(pet)
    return
        pet:hasStatusEffect(xi.effect.LULLABY) or
        pet:hasStatusEffect(xi.effect.STUN) or
        pet:hasStatusEffect(xi.effect.PETRIFICATION) or
        pet:hasStatusEffect(xi.effect.SLEEP_II) or
        pet:hasStatusEffect(xi.effect.SLEEP_I) or
        pet:hasStatusEffect(xi.effect.TERROR)
end

m:addOverride("xi.globals.mobskills.astral_flow_pet.onMobWeaponSkill", function(target, mob, skill)
    local pet = mob:getPet()

    skill:setMsg(xi.msg.basic.USES)

    -- no effect if pet is inactive
    if pet and petInactive(pet) then
        return xi.effect.ASTRAL_FLOW
    end

    -- Find proper pet skill
    local petFamily = pet:getFamily()
    local modelId   = pet:getModelId()
    local skillId = 0

    if     petFamily == 45 or petFamily == 388 or modelId == 794 then -- 794
        skillId = 914 -- titan     earthen fury
    elseif petFamily == 44 or petFamily == 387 or modelId == 797 then -- 797
        skillId = 917 -- shiva     diamond dust
    elseif petFamily == 43 or petFamily == 386 or modelId == 798 then -- 798
        skillId = 918 -- ramuh     judgment bolt
    elseif petFamily == 40 or petFamily == 384 or modelId == 795 then -- 795
        skillId = 915 -- leviathan tidal wave
    elseif petFamily == 38 or petFamily == 383 or modelId == 793 then -- 793
        skillId = 913 -- ifrit     inferno
    elseif petFamily == 37 or petFamily == 382 or modelId == 796 then -- 796
        skillId = 916 -- garuda    aerial blast
    elseif petFamily == 36 or petFamily == 381 or modelId == 792 then -- 792
        skillId = 839 -- fenrir    howling moon
    elseif petFamily == 34 or petFamily == 379 or modelId == 791 then -- 791
        skillId = 919 -- carbuncle searing light
    else
        printf("[astral_flow_pet] received unexpected pet family %i. Defaulted skill to Searing Light.", petFamily)
        skillId = 919 -- searing light
    end

    pet:useMobAbility(skillId)

    return xi.effect.ASTRAL_FLOW
end)

m:addOverride("xi.globals.mobskills.asuran_claws.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 6
    local accmod  = 1
    local dmgmod  = 1
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.asuran_fists.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 8
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 8, 8, 8)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.august_melee_axe.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    skill:setMsg(xi.msg.basic.HIT_DMG)
    return dmg
end)

m:addOverride("xi.globals.mobskills.august_melee_bow.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    skill:setMsg(xi.msg.basic.HIT_DMG)
    return dmg
end)

m:addOverride("xi.globals.mobskills.august_melee_h2h.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    skill:setMsg(xi.msg.basic.HIT_DMG)
    return dmg
end)

m:addOverride("xi.globals.mobskills.august_melee_sword.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    skill:setMsg(xi.msg.basic.HIT_DMG)
    return dmg
end)

m:addOverride("xi.globals.mobskills.aura_of_persistence.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 17.5, 0, 300))

    return xi.effect.DEFENSE_BOOST
end)

m:addOverride("xi.globals.mobskills.auroral_drape.onMobWeaponSkill", function(target, mob, skill)
    local silenced   = false
    local blinded    = false
    local typeEffect = nil

    silenced = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)
    blinded  = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 50, 0, 90)
    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)

    -- display silenced first, else blind
    if silenced == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.SILENCE
    elseif blinded == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.BLINDNESS
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.auroral_uppercut.onMobWeaponSkill", function(target, mob, skill)
    local ID = require("scripts/zones/Empyreal_Paradox/IDs")
    mob:showText(mob, ID.text.PRISHE_TEXT + 4)
    local numhits = 1
    local accmod  = 1
    local dmgmod  = 1
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.auroral_wind.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WIND, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    return dmg
end)

m:addOverride("xi.globals.mobskills.autumn_breeze.onMobWeaponSkill", function(target, mob, skill)
    --[[
    https://youtu.be/r7ogGoabgH0?t=1m58s
    https://youtu.be/a0Tqdl8_SY4?t=2m29s
    https://youtu.be/a0Tqdl8_SY4?t=5m22s
    https://youtu.be/m0XpjG6E1oc?t=58s
    https://youtu.be/m0XpjG6E1oc?t=5m52s
    belphoebe : 300 ish (310, 312, 294..)
    skuld     : 250 ish
    carabosse : 100-250 ish (lowest lv mob of the 3)
    ]]
    local heal = math.random(100, 400)

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(mob, heal)
end)

m:addOverride("xi.globals.mobskills.avalanche_axe.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.awful_eye.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.STR_DOWN, 10, 10, 180))

    if skill:getID() == 1862 then -- Nightmare Bugard - Adds PETRIFICATION
        skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.PETRIFICATION, 1, 0, 60))

        return xi.effect.PETRIFICATION
    end

    return xi.effect.STR_DOWN
end)

m:addOverride("xi.globals.mobskills.axe_kick.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.axe_throw.onMobWeaponSkill", function(target, mob, skill)
    mob:setAnimationSub(1)

    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.axial_bloom.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 30))

    return xi.effect.BIND
end)

m:addOverride("xi.globals.mobskills.azure_lore.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.AZURE_LORE, 1, 0, 45)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.AZURE_LORE
end)

m:addOverride("xi.globals.mobskills.backhand_blow.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.back_heel.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.back_swish.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded * math.random(2, 3))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.bad_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.15, 3, xi.magic.ele.EARTH, 500)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.EARTH)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, math.min(1, mob:getMainLvl() / 10), 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 15, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 30)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 15, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 50, 0, 60)

    return dmg
end)

m:addOverride("xi.globals.mobskills.bai_wing.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 4, 4, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 6000, 0, 120)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.baleful_gaze.onMobWeaponSkill", function(target, mob, skill)
    local duration = math.random(30, 60)

    -- Cockatrice
    if mob:getFamily() == 70 then
        duration = duration * 2
    end

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.PETRIFICATION, 1, 0, duration))

    return xi.effect.PETRIFICATION
end)

m:addOverride("xi.globals.mobskills.bane.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BANE

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 40, 0, 480))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.barbed_crescent.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BLINDNESS, 100, 0, 180)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.barofield.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2.0
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 25, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.barracuda_dive.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.barrage.onMobWeaponSkill", function(target, mob, skill)
    mob:addStatusEffect(xi.effect.BARRAGE, 0, 0, 60)
    return 0
end)

m:addOverride("xi.globals.mobskills.barrier_tusk.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_DEF_BOOST, 30, 0, 90)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 30, 0, 90))

    return xi.effect.DEFENSE_BOOST
end)

m:addOverride("xi.globals.mobskills.bastion_of_twilight.onMobWeaponSkill", function(target, mob, skill)
    local ID = require("scripts/zones/Empyreal_Paradox/IDs")
    mob:showText(mob, ID.text.PROMATHIA_TEXT + 5)
    mob:addStatusEffect(xi.effect.MAGIC_SHIELD, 1, 0, 0)
    mob:setAnimationSub(2)

    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return xi.effect.MAGIC_SHIELD
end)

m:addOverride("xi.globals.mobskills.batterhorn.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.battery_charge.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.REFRESH

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 3, 3, 300))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.battle_dance.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEX_DOWN, 10, 10, 180)

    return dmg
end)

m:addOverride("xi.globals.mobskills.beak_lunge.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.bear_killer.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.beatdown.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local attmod = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 1.5, 2, 0, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)
    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 1, 0, 60)

    return dmg
end)

m:addOverride("xi.globals.mobskills.benediction.onMobWeaponSkill", function(target, mob, skill)
    local removables = { xi.effect.FLASH, xi.effect.BLINDNESS, xi.effect.MAX_HP_DOWN, xi.effect.MAX_MP_DOWN, xi.effect.PARALYSIS, xi.effect.POISON,
                        xi.effect.CURSE_I, xi.effect.CURSE_II, xi.effect.DISEASE, xi.effect.PLAGUE, xi.effect.WEIGHT, xi.effect.BIND,
                        xi.effect.BIO, xi.effect.DIA, xi.effect.BURN, xi.effect.FROST, xi.effect.CHOKE, xi.effect.RASP, xi.effect.SHOCK, xi.effect.DROWN,
                        xi.effect.STR_DOWN, xi.effect.DEX_DOWN, xi.effect.VIT_DOWN, xi.effect.AGI_DOWN, xi.effect.INT_DOWN, xi.effect.MND_DOWN,
                        xi.effect.CHR_DOWN, xi.effect.ADDLE, xi.effect.SLOW, xi.effect.HELIX, xi.effect.ACCURACY_DOWN, xi.effect.ATTACK_DOWN,
                        xi.effect.EVASION_DOWN, xi.effect.DEFENSE_DOWN, xi.effect.MAGIC_ACC_DOWN, xi.effect.MAGIC_ATK_DOWN, xi.effect.MAGIC_EVASION_DOWN,
                        xi.effect.MAGIC_DEF_DOWN, xi.effect.MAX_TP_DOWN, xi.effect.SILENCE }

    for _, effect in ipairs(removables) do
        if target:hasStatusEffect(effect) then
            target:delStatusEffect(effect)
        end
    end

    local maxHeal = target:getMaxHP() - target:getHP()
    if mob:hasStatusEffect(xi.effect.HYSTERIA) then
        maxHeal = 0
    end

    target:addHP(maxHeal)
    target:wakeUp()
    skill:setMsg(xi.msg.basic.SELF_HEAL)

    if mob:hasStatusEffect(xi.effect.HYSTERIA) then
        skill:setMsg(xi.msg.basic.NONE)
        mob:delStatusEffect(xi.effect.HYSTERIA)
    end

    return maxHeal
end)

m:addOverride("xi.globals.mobskills.benthic_typhoon.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.MAGIC_DEF_DOWN, 30, 0, 60)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 30, 0, 60)

    return dmg
end)

m:addOverride("xi.globals.mobskills.berserk-ruf.onMobWeaponSkill", function(target, mob, skill)
    local power = 25
    local duration = 180

    local typeEffect = xi.effect.WARCRY
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, duration))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.berserk.onMobWeaponSkill", function(target, mob, skill)
    local power = (116 / 256) * 100

    -- Dolls Berserk is Warcry
    -- TODO: Separate file
    if
        mob:getFamily() == 83 or
        mob:getFamily() == 84 or
        mob:getFamily() == 85 or
        mob:getFamily() == 498
    then
        skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.WARCRY, 33, 0, 120))

        return xi.effect.WARCRY
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BERSERK, power, 0, math.random(120, 180)))
    return xi.effect.BERSERK
end)

m:addOverride("xi.globals.mobskills.big_horn.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local attmod = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.5, 2, 2.5, 0, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.big_scissors.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.bilgestorm.onMobWeaponSkill", function(target, mob, skill)
    local power = math.random(20, 25)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.ACCURACY_DOWN, power, 0, 60)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.ATTACK_DOWN, power, 0, 60)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, power, 0, 60)

    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.binary_absorption.onMobWeaponSkill", function(target, mob, skill)
    -- time to drain HP. 100-200
    local power = math.random(0, 101) + 100
    local dmg = xi.mobskills.mobFinalAdjustments(power, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

        skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.binary_tap.onMobWeaponSkill", function(target, mob, skill)
    -- try to drain buff
    local effectFirst = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
    local effectSecond = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
    local dmg = 0

    if effectFirst ~= 0 then
        local count = 1

        if effectSecond ~= 0 then
            count = count + 1
        end

        skill:setMsg(xi.msg.basic.EFFECT_DRAINED)

        return count
    else
        local power = mob:getMainLvl() * 3.5
        dmg = xi.mobskills.mobFinalAdjustments(power, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))
        return dmg
    end
end)

m:addOverride("xi.globals.mobskills.binding_microtube.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BIND

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 60)

    local dmgmod = 2.45
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.magic.ele.NONE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.NONE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.binding_wave.onMobWeaponSkill", function(target, mob, skill)
    local noresist = 1
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 30, 0, 0, noresist))

    return xi.effect.BIND
end)

m:addOverride("xi.globals.mobskills.bionic_boost.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.COUNTERSTANCE

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 1, 0, 60))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.biotic_boomerang.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PLAGUE, 5, 3, 18)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.black_cloud.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 20, 0, math.random(180, 300))

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)

    return dmg
end)

m:addOverride("xi.globals.mobskills.black_halo.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.1, 1.2, 1.3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.blade_chi.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.8
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.blade_ei.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN) * 3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 1, 0, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.blade_jin.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.ACC_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.blade_ku.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.ACC_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.blade_metsu.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local duration = 60
    local typeEffect = xi.effect.PARALYSIS
    local power = 10

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, power, 0, duration)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.blade_retsu.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1.25

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.NO_EFFECT, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PARALYSIS, 30, 0, skill:getTP() / 1000 * 30)

    return dmg
end)

m:addOverride("xi.globals.mobskills.blade_rin.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)

    if mob:getObjType() == xi.objType.FELLOW then
        info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 2, 3)
    end

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.blade_teki.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN) * 3, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 1, 0, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.blade_to.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.ACC_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.blank_gaze.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.PARALYSIS, 35, 0, 180))

    return xi.effect.PARALYSIS
end)

m:addOverride("xi.globals.mobskills.blank_gaze_dispel.onMobWeaponSkill", function(target, mob, skill)
    local effect = 0
    if target:isFacing(mob) then

        effect = target:dispelStatusEffect()

        if effect == xi.effect.NONE then
            skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
        else
            skill:setMsg(xi.msg.basic.SKILL_ERASE)
        end
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    end

    return effect
end)

m:addOverride("xi.globals.mobskills.blastbomb.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, math.random(30, 60))

    return dmg
end)

m:addOverride("xi.globals.mobskills.blaster.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, math.random(60, 70), 0, 60))

    return xi.effect.PARALYSIS
end)

m:addOverride("xi.globals.mobskills.blast_arrow.onMobWeaponSkill", function(target, mob, skill)
    -- TODO: Accuracy varies with TP
    local numhits = 2
    local accmod = 1.0
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.ACC_VARIES)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.blazing_bound.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.blindeye.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BLINDNESS, 30, 0, 30)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.MAGIC_ACC_DOWN, 30, 0, 30)

    return dmg
end)

m:addOverride("xi.globals.mobskills.blind_vortex.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BLINDNESS, 18, 0, 120)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.blitzstrahl.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.THUNDER, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.blizzard_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.5, 1, xi.magic.ele.ICE, 700)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.ICE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.blizzard_ii.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.ICE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.blizzard_iv.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN) * 4, xi.magic.ele.ICE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.blizzard_meeble_warble.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 9, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 50, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FROST, 50, 3, 60)
    return dmg
end)

m:addOverride("xi.globals.mobskills.blockhead.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.bloodrake.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

        skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.bloody_caress.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1

    -- TODO: Once `Floral Bouquet` TP move is implemented, this skill is eligible to target
    -- the charmed monsters.

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.ACC_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.bloody_claw.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local typeEffect = 136 + math.random(0, 6) -- 136 is xi.effect.STR_DOWN add 0 to 6 for all 7 of the possible attribute reductions

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 20, 3, 120)

    return dmg
end)

m:addOverride("xi.globals.mobskills.blood_drain.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1.5, 1.75, 2)
    local shadow = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    -- Asanbosam (pool id 256) uses a modified blood drain that ignores shadows
    if mob:getPool() == 256 then
        shadow = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    end

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, shadow)
    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.blood_pact.onMobWeaponSkill", function(target, mob, skill)
    -- Fantoccini (ENM: Pulling the Strings)
    if mob:getPool() == 1296 then
        local pet = GetMobByID(mob:getID() + 3)
        pet:setTP(3000)
        pet:setMobMod(xi.mobMod.SKILL_LIST, ID.jobTable[mob:getMainJob()].petSkillList[mob:getLocalVar("petModel")])
        mob:timer(1, function(mobArg)
            pet:setMobMod(xi.mobMod.SKILL_LIST, 0)
        end)
    else
        mob:getPet():setTP(3000)
    end

    skill:setMsg(xi.msg.basic.NONE)

    return 0
end)

m:addOverride("xi.globals.mobskills.blood_saber.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.blood_weapon.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.BLOOD_WEAPON, 1, 0, 30)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.BLOOD_WEAPON
end)

m:addOverride("xi.globals.mobskills.blow.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local attmod = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2, 0, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    return dmg
end)

m:addOverride("xi.globals.mobskills.bludgeon.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.ACC_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.body_slam.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.boiling_blood.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.HASTE, 2500, 0, 60)
    xi.mobskills.mobBuffMove(mob, xi.effect.BERSERK, 50, 0, 60)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.boiling_point.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.MAGIC_DEF_DOWN
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 50, 0, 120))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.bombilation.onMobWeaponSkill", function(target, mob, skill)
    local reset = 0
    if target:getTP() == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        target:setTP(reset)
        skill:setMsg(xi.msg.basic.TP_REDUCED)
    end

    return reset
end)

m:addOverride("xi.globals.mobskills.bomb_toss.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.bomb_toss_suicide.onMobWeaponSkill", function(target, mob, skill)
    local damage = skill:getMobHP() / 3
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:setHP(0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.bonebreaking_barrage.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.MAX_HP_DOWN, 0, 0, 60)

    if not skill:hasMissMsg() then
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 50, 0, 30)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.bone_crunch.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PLAGUE, 5, 0, math.random(15, 60))

    return dmg
end)

m:addOverride("xi.globals.mobskills.bone_crusher.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MELEE, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:addStatusEffect(xi.effect.STUN, 1, 0, 3)
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.brainjack.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.CHARM_I, 0, 0, 60)
    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.brainshaker.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:addStatusEffect(xi.effect.STUN, 1, 0, 3)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.brain_crush.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SILENCE, 1, 0, 30)

    return dmg
end)

m:addOverride("xi.globals.mobskills.brain_drain.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.INT_DOWN, 10, 10, 120)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)

    return dmg
end)

m:addOverride("xi.globals.mobskills.brain_spike.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    local typeEffect = xi.effect.PARALYSIS
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 15, 0, 90)

    return dmg
end)

m:addOverride("xi.globals.mobskills.bubble_armor.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.SHELL
    local power      = 5000
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, 180))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.bubble_curtain.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.SHELL
    local power      = 5000
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, 180))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.bubble_shower.onMobWeaponSkill", function(target, mob, skill)
    local bubbleCap = 0
    local hpdmg = 1 / 16

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, 10, 10, 180)

    if mob:getMaster() then
        bubbleCap = 2000
    else
        bubbleCap = 200
    end

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, hpdmg, 1, xi.magic.ele.WATER, bubbleCap)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)

    return dmg
end)

m:addOverride("xi.globals.mobskills.burning_blade.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 0, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.burst.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.physicalTpBonus.CRIT_VARIES, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.cacodemonia.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.CURSE_I
    local power = 40
    if mob:getZoneID() == xi.zone.DYNAMIS_TAVNAZIA then -- Diabolos Dynamis Tavnazia - 48%
        power = 48
    end

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, 360))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.calamity.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3
    local attmod = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1, 1, 0, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    -- Didn't see any numbers, so just giving it something on par with other AAs.
    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.calcifying_claw.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PETRIFICATION, 50, 0, 30)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.call_beast.onMobWeaponSkill", function(target, mob, skill)
    mob:setLocalVar("CallBeastTime", os.time() + 120 + math.random(30))
    skill:setMsg(xi.msg.basic.NONE)

    mob:entityAnimationPacket("casm")
    mob:timer(3000, function(mobArg)
        if mobArg:isAlive() then
            mobArg:entityAnimationPacket("shsm")
            mobArg:spawnPet()
        end
    end)
end)

m:addOverride("xi.globals.mobskills.call_of_the_grave.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.INT_DOWN, 10, 15, 130))

    return xi.effect.INT_DOWN
end)

m:addOverride("xi.globals.mobskills.call_wyvern.onMobWeaponSkill", function(target, mob, skill)
    if mob:isInDynamis() then
        local mobInfo = xi.dynamis.mobList[mob:getZoneID()][mob:getZone():getLocalVar((string.format("MobIndex_%s", mob:getID())))]

        if mobInfo ~= nil and mobInfo.info[2] == "Apocalyptic Beast" then
            if mob:getLocalVar("CALL_WYVERN") == 1 then
                skill:setMsg(xi.msg.basic.NONE)
                return 0
            end

            for i = 5, 1, -1 do
                xi.dynamis.spawnDynamicPet(mob:getTarget(), mob, xi.job.DRG)
            end
        else
            xi.dynamis.spawnDynamicPet(mob:getTarget(), mob, xi.job.DRG)
        end
    else
        mob:spawnPet()
    end

    skill:setMsg(xi.msg.basic.NONE)

    return 0
end)

m:addOverride("xi.globals.mobskills.camisado.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    -- Diabolos Dynamis Tavnazia - covering skill IDs: single target 656 and AoE 1903
    if mob:getZoneID() == xi.zone.DYNAMIS_TAVNAZIA then
        accmod = 4
        dmgmod = 4
    end

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)

    local shadows = info.hitslanded
    if
        mob:getZoneID() == xi.zone.DYNAMIS_TAVNAZIA and
        skill:getID() == 1903
    then
        shadows = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    end

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, shadows)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.cannonball.onMobWeaponSkill", function(target, mob, skill)
    local numhits   = 1
    local accmod    = 1
    local dmgmod    = 1
    local offcratio = mob:getStat(xi.mod.DEF)
    local info      = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3, offcratio)
    local dmg       = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.carnal_nightmare.onMobWeaponSkill", function(target, mob, skill)
    local reset = 0
    if target:getTP() == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        target:setTP(reset)
        skill:setMsg(xi.msg.basic.TP_REDUCED)
    end

    return reset
end)

m:addOverride("xi.globals.mobskills.carousel.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 4.5, 4.5, 4.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.catapult.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1

    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 3, 3.25, 3.5)

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:addTP(20)
        mob:addTP(80)
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.catastrophe.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.75, 2.75, 2.75)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))
    return dmg
end)

m:addOverride("xi.globals.mobskills.catharsis.onMobWeaponSkill", function(target, mob, skill)
    -- Formula is Max HP * 32/256
    local potency = 1 / 8

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * potency)
end)

m:addOverride("xi.globals.mobskills.chainspell.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.CHAINSPELL, 1, 0, 60)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.CHAINSPELL
end)

m:addOverride("xi.globals.mobskills.chains_of_apathy.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.TERROR
    local power = 30
    local duration = 30

    if
        target:isPC() and
        (
            (target:getRace() == xi.race.HUME_M or target:getRace() == xi.race.HUME_F) and
            not target:hasKeyItem(xi.ki.LIGHT_OF_VAHZL)
        )
    then
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration))
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.chains_of_arrogance.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.TERROR
    local power = 30
    local duration = 30

    if
        target:isPC() and
        (
            (target:getRace() == xi.race.ELVAAN_M or target:getRace() == xi.race.ELVAAN_F) and
            not target:hasKeyItem(xi.ki.LIGHT_OF_MEA)
        )
    then
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration))
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.chains_of_cowardice.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.TERROR
    local power = 30
    local duration = 30

    if
        target:isPC() and
        (
            (target:getRace() == xi.race.TARU_M or target:getRace() == xi.race.TARU_F) and
            not target:hasKeyItem(xi.ki.LIGHT_OF_HOLLA)
        )
    then
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration))
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.chains_of_envy.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.TERROR
    local power = 30
    local duration = 30

    if
        target:isPC() and
        target:getRace() == xi.race.MITHRA and
        not target:hasKeyItem(xi.ki.LIGHT_OF_DEM)
    then
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration))
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.chains_of_rage.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.TERROR
    local power = 30
    local duration = 30

    if
        target:isPC() and
        target:getRace() == xi.race.GALKA and
        not target:hasKeyItem(xi.ki.LIGHT_OF_ALTAIEU)
    then
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration))
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.chaos_blade.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local power = 25
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    mob:lookAt(target:getPos())
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)

    if mob:getPool() == 1100 or mob:getPool() == 1101 then
        power = mob:getLocalVar("chaosBladeLevel")
    end

    -- curse LAST so you don't die
    local typeEffect = xi.effect.CURSE_I
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, 420)

    return dmg
end)

m:addOverride("xi.globals.mobskills.chaos_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.5, 1, xi.magic.ele.DARK, 700)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.chaotic_eye.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.SILENCE, 1, 0, 60))

    return xi.effect.SILENCE
end)

m:addOverride("xi.globals.mobskills.chaotic_strike.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1.1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    local typeEffect = xi.effect.STUN
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 10)

    return dmg
end)

m:addOverride("xi.globals.mobskills.charged_whisker.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.charm.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.CHARM_I
    local power = 0

    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return typeEffect
    end

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 150)
    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        mob:charm(target)
        mob:resetEnmity(target)
    end

    skill:setMsg(msg)

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.charm_copycat.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.CHARM_I
    local power = 100
    local job = target:getMainJob()
    local pos = mob:getPos()
    local id = mob:getID()

    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return typeEffect
    end

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 30)

    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        mob:charm(target)
    end

    local jobs =
    {
        { xi.job.BST, 2 },
        { xi.job.DRG, 3 },
        { xi.job.SMN, 4 },
        { xi.job.PUP, 5 },
    }

    for _, v in pairs(jobs) do
        if job == v[1] then
            GetMobByID(id + v[2]):setSpawn(pos.x, pos.y, pos.z, pos.rot)
            SpawnMob(id + v[2])
            break
        end
    end

    skill:setMsg(msg)

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.chemical_bomb.onMobWeaponSkill", function(target, mob, skill)
    local typeEffectOne = xi.effect.ELEGY
    local typeEffectTwo = xi.effect.SLOW

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffectOne, 5000, 0, 120))
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffectTwo, 5000, 0, 120))

    -- This likely doesn't behave like retail.
    return typeEffectTwo
end)

m:addOverride("xi.globals.mobskills.chimera_ripper.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MELEE, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.choke_breath.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_FLAT, 1, 1, 1)

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PARALYSIS, 25, 0, 60)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SILENCE, 1, 0, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.chomp_rush.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    if not target:hasStatusEffect(xi.effect.HASTE) then
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SLOW, 2500, 0, math.random(120, 180))
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.chthonian_ray.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.DOOM

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 11, 3, 30))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.cimicine_discharge.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.SLOW
    local power = 1950
    local duration = math.random(60, 180)

    if not mob:hasStatusEffect(xi.effect.HASTE) then
        mob:addStatusEffect(xi.effect.HASTE, 1500, 0, duration)
    end

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration))

    return typeEffect

    --[[ Is there suppsoed to be a message about haste?
    local typeEffect = xi.effect.HASTE
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 150, 0, duration))
    return typeEffect
    ]]--
end)

m:addOverride("xi.globals.mobskills.circle_blade.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    if not skill:hasMissMsg() then
        -- About 200-300
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.circle_of_flames.onMobWeaponSkill", function(target, mob, skill)
    local numberOfBombs = 3 - mob:getAnimationSub()
    local bombNum = 50 * numberOfBombs

    if mob:getZoneID() == xi.zone.DYNAMIS_TAVNAZIA then
        bombNum = bombNum * 1.75
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, bombNum, xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1, 1.1, 1.2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, numberOfBombs)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.WEIGHT, 20, 0, 120)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.citadel_buster.onMobWeaponSkill", function(target, mob, skill)
    local basedmg = 2088

    if
        mob:getWeather() == xi.weather.AURORAS or
        mob:getWeather() == xi.weather.STELLAR_GLARE
    then
        basedmg = basedmg + 520
    end

    if VanadielDayElement() == xi.magic.ele.LIGHT then
        basedmg = basedmg + 208
    end

    local damage = basedmg / (1 + (target:getMod(xi.mod.MDEF) / 100))
    local dmg = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    mob:resetEnmity(target)

    return dmg
end)

m:addOverride("xi.globals.mobskills.clarsach_call.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 3
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.5, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    return dmg
end)

m:addOverride("xi.globals.mobskills.claw.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.claw_cyclone.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.claw_storm.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, 7, 3, 60)

    return dmg
end)

m:addOverride("xi.globals.mobskills.cocoon.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 100, 0, 180))

    return xi.effect.DEFENSE_BOOST
end)

m:addOverride("xi.globals.mobskills.cold_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.125, 1, xi.magic.ele.ICE, 600)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.ICE)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 60)

    return dmg
end)

m:addOverride("xi.globals.mobskills.cold_stare.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.SILENCE, 1, 0, math.random(30, 60)))

    return xi.effect.SILENCE
end)

m:addOverride("xi.globals.mobskills.cold_wave.onMobWeaponSkill", function(target, mob, skill)
    local powerFrost = mob:getMainLvl() / 5 * 0.6 + 6

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FROST, powerFrost, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AGI_DOWN, 33, 10, 60)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.colossal_blow.onMobWeaponSkill", function(target, mob, skill)
    local currentHP = target:getHP()
    -- remove all by 5%
    local damage = 0

    -- if have more hp then 30%, then reduce to 5%
    if target:getHPP() > 30 then
        damage = currentHP * .95
    else
        -- else you die
        damage = currentHP
    end

    local dmg = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    mob:resetEnmity(target)
    return dmg
end)

m:addOverride("xi.globals.mobskills.colossal_slam.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.NUMSHADOWS_3)
    local typeEffect = xi.effect.CURSE_II -- Zombie

    -- TODO: The duration needs verification from retail
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 0, 0, 30)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.combo.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.concussive_oscillation.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5, 2.0, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.NUMSHADOWS_3)
    local typeEffect = xi.effect.WEIGHT

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 75, 0, 300)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.condemnation.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 6)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.contagion_transfer.onMobWeaponSkill", function(target, mob, skill)
    local badEffects =
    {
        xi.effect.SLEEP_I,
        xi.effect.POISON,
        xi.effect.PARALYSIS,
        xi.effect.BLINDNESS,
        xi.effect.SILENCE,
        xi.effect.PETRIFICATION,
        xi.effect.DISEASE,
        xi.effect.CURSE_I,
        xi.effect.STUN,
        xi.effect.BIND,
        xi.effect.WEIGHT,
        xi.effect.SLOW,
        xi.effect.SLEEP_II,
        xi.effect.CURSE_II,
        xi.effect.PLAGUE,
        xi.effect.BURN,
        xi.effect.FROST,
        xi.effect.CHOKE,
        xi.effect.RASP,
        xi.effect.SHOCK,
        xi.effect.DROWN,
        xi.effect.DIA,
        xi.effect.BIO,
        xi.effect.STR_DOWN,
        xi.effect.DEX_DOWN,
        xi.effect.VIT_DOWN,
        xi.effect.AGI_DOWN,
        xi.effect.INT_DOWN,
        xi.effect.MND_DOWN,
        xi.effect.CHR_DOWN,
        xi.effect.MAX_HP_DOWN,
        xi.effect.MAX_MP_DOWN,
        xi.effect.ACCURACY_DOWN,
        xi.effect.ATTACK_DOWN,
        xi.effect.EVASION_DOWN,
        xi.effect.DEFENSE_DOWN,
        xi.effect.FLASH,
        xi.effect.DREAD_SPIKES,
        xi.effect.MAGIC_ACC_DOWN,
        xi.effect.MAGIC_ATK_DOWN,
        xi.effect.REQUIEM,
        xi.effect.LULLABY,
        xi.effect.ELEGY,
        xi.effect.THRENODY,
    }
    local goodEffects =
    {
        xi.effect.HASTE,
        xi.effect.BLAZE_SPIKES,
        xi.effect.ICE_SPIKES,
        xi.effect.BLINK,
        xi.effect.STONESKIN,
        xi.effect.SHOCK_SPIKES,
        xi.effect.AQUAVEIL,
        xi.effect.PROTECT,
        xi.effect.SHELL,
        xi.effect.REGEN,
        xi.effect.REFRESH,
        xi.effect.BOOST,
        xi.effect.BERSERK,
        xi.effect.DEFENDER,
        xi.effect.AGGRESSOR,
        xi.effect.FOCUS,
        xi.effect.DODGE,
        xi.effect.COUNTERSTANCE,
        xi.effect.SENTINEL,
        xi.effect.SOULEATER,
        xi.effect.LAST_RESORT,
        xi.effect.COPY_IMAGE,
        xi.effect.THIRD_EYE,
        xi.effect.WARCRY,
        xi.effect.SHARPSHOT,
        xi.effect.BARRAGE,
        xi.effect.HOLY_CIRCLE,
        xi.effect.ARCANE_CIRCLE,
        xi.effect.DIVINE_SEAL,
        xi.effect.ELEMENTAL_SEAL,
        xi.effect.STR_BOOST,
        xi.effect.DEX_BOOST,
        xi.effect.VIT_BOOST,
        xi.effect.AGI_BOOST,
        xi.effect.INT_BOOST,
        xi.effect.MND_BOOST,
        xi.effect.CHR_BOOST,
        xi.effect.MAX_HP_BOOST,
        xi.effect.MAX_MP_BOOST,
        xi.effect.ACCURACY_BOOST,
        xi.effect.ENFIRE,
        xi.effect.ENBLIZZARD,
        xi.effect.ENAERO,
        xi.effect.ENSTONE,
        xi.effect.ENTHUNDER,
        xi.effect.ENWATER,
        xi.effect.ENFIRE,
        xi.effect.ENBLIZZARD_II,
        xi.effect.ENAERO_II,
        xi.effect.ENSTONE_II,
        xi.effect.ENTHUNDER_II,
        xi.effect.ENWATER_II,
        xi.effect.BARFIRE,
        xi.effect.BARBLIZZARD,
        xi.effect.BARAERO,
        xi.effect.BARSTONE,
        xi.effect.BARTHUNDER,
        xi.effect.BARWATER,
        xi.effect.BARSLEEP,
        xi.effect.BARPOISON,
        xi.effect.BARPARALYZE,
        xi.effect.BARBLIND,
        xi.effect.BARSILENCE,
        xi.effect.BARPETRIFY,
        xi.effect.BARVIRUS,
        xi.effect.UNLIMITED_SHOT,
        xi.effect.PHALANX,
        xi.effect.WARDING_CIRCLE,
        xi.effect.ANCIENT_CIRCLE,
        xi.effect.STR_BOOST_II,
        xi.effect.DEX_BOOST_II,
        xi.effect.VIT_BOOST_II,
        xi.effect.AGI_BOOST_II,
        xi.effect.INT_BOOST_II,
        xi.effect.MND_BOOST_II,
        xi.effect.CHR_BOOST_II,
        xi.effect.SHINING_RUBY,
        xi.effect.CHAIN_AFFINITY,
        xi.effect.BURST_AFFINITY,
        xi.effect.MAGIC_ATK_BOOST,
        xi.effect.MAGIC_DEF_BOOST,
        xi.effect.PAEON,
        xi.effect.BALLAD,
        xi.effect.MINNE,
        xi.effect.MINUET,
        xi.effect.MADRIGAL,
        xi.effect.PRELUDE,
        xi.effect.MAMBO,
        xi.effect.AUBADE,
        xi.effect.PASTORAL,
        xi.effect.HUM,
        xi.effect.FANTASIA,
        xi.effect.OPERETTA,
        xi.effect.CAPRICCIO,
        xi.effect.SERENADE,
        xi.effect.ROUND,
        xi.effect.GAVOTTE,
        xi.effect.FUGUE,
        xi.effect.RHAPSODY,
        xi.effect.ARIA,
        xi.effect.MARCH,
        xi.effect.ETUDE,
        xi.effect.CAROL,
        xi.effect.HYMNUS,
        xi.effect.MAZURKA,
        xi.effect.HASSO,
        xi.effect.SEIGAN,
        xi.effect.DRAIN_SAMBA,
        xi.effect.ASPIR_SAMBA,
        xi.effect.HASTE_SAMBA,
        xi.effect.VELOCITY_SHOT,
        xi.effect.RETALIATION,
        xi.effect.FOOTWORK,
        xi.effect.SEKKANOKI,
        xi.effect.PIANISSIMO,
        xi.effect.COMPOSURE,
        xi.effect.YONIN,
        xi.effect.INNIN,
    }

    local effects = target:getStatusEffects()
    local count = 0
    local power = math.ceil(mob:getMainLvl() / 5)

    -- Case for Giant Moa
    if mob:getPool() == 1532 then
        for _, v in pairs(effects) do
            if count < 8 and v ~= nil then
                for y = 1, #badEffects do
                    if target:hasStatusEffect(badEffects[y]) then
                        if badEffects[y] == xi.effect.PETRIFICATION then
                            mob:timer(2000, function(mobArg)
                                mob:addStatusEffect(badEffects[y], power, 3, 60)
                                target:delStatusEffect(badEffects[y])
                                count = count + 1
                            end)
                        else
                            mob:addStatusEffect(badEffects[y], power, 3, 60)
                            target:delStatusEffect(badEffects[y])
                            count = count + 1
                        end
                    end
                end

                for y = 1, #goodEffects do
                    if target:hasStatusEffect(goodEffects[y]) then
                        mob:addStatusEffect(goodEffects[y], power, 3, 60)
                        target:delStatusEffect(goodEffects[y])
                        count = count + 1
                    end
                end
            end
        end

        if count > 0 then
            skill:setMsg(xi.msg.basic.EFFECT_DRAINED)
        else
            skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        end

        return count
    else
        for _, v in pairs (effects) do
            if count < 8 and v ~= nil then
                for y = 1, #badEffects do
                    if mob:hasStatusEffect(badEffects[y]) then
                        target:addStatusEffect(badEffects[y], power, 0, 60)
                        mob:delStatusEffect(badEffects[y])

                        skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
                    end
                end
            end
        end
    end
end)

m:addOverride("xi.globals.mobskills.contamination.onMobWeaponSkill", function(target, mob, skill)
    local badEffects =
    {
        xi.effect.SLEEP_I,
        xi.effect.POISON,
        xi.effect.PARALYSIS,
        xi.effect.BLINDNESS,
        xi.effect.SILENCE,
        xi.effect.PETRIFICATION,
        xi.effect.CURSE_I,
        xi.effect.STUN,
        xi.effect.BIND,
        xi.effect.WEIGHT,
        xi.effect.SLOW,
        xi.effect.SLEEP_II,
        xi.effect.PLAGUE,
        xi.effect.BURN,
        xi.effect.FROST,
        xi.effect.CHOKE,
        xi.effect.RASP,
        xi.effect.SHOCK,
        xi.effect.DROWN,
        xi.effect.DIA,
        xi.effect.BIO,
        xi.effect.STR_DOWN,
        xi.effect.DEX_DOWN,
        xi.effect.VIT_DOWN,
        xi.effect.AGI_DOWN,
        xi.effect.INT_DOWN,
        xi.effect.MND_DOWN,
        xi.effect.CHR_DOWN,
        xi.effect.MAX_HP_DOWN,
        xi.effect.MAX_MP_DOWN,
        xi.effect.ACCURACY_DOWN,
        xi.effect.ATTACK_DOWN,
        xi.effect.EVASION_DOWN,
        xi.effect.DEFENSE_DOWN,
        xi.effect.FLASH,
        xi.effect.DREAD_SPIKES,
        xi.effect.MAGIC_ACC_DOWN,
        xi.effect.MAGIC_ATK_DOWN,
        xi.effect.REQUIEM,
        xi.effect.LULLABY,
        xi.effect.ELEGY,
        xi.effect.THRENODY,
    }
    local effects = mob:getStatusEffects()
    local count = 0
    local power = math.ceil(mob:getMainLvl() / 5)
    local poisonPower = 30

    for _, v in pairs (effects) do
        if count < 8 and v ~= nil then
            for y = 1, #badEffects do
                if mob:hasStatusEffect(badEffects[y]) then
                    if badEffects[y] == xi.effect.POISON then
                        target:addStatusEffect(badEffects[y], poisonPower, 0, 60)
                    else
                        target:addStatusEffect(badEffects[y], power, 0, 60)
                    end

                    mob:delStatusEffect(badEffects[y])
                end
            end
        end
    end

    skill:setMsg(xi.msg.basic.NONE)
end)

m:addOverride("xi.globals.mobskills.core_meltdown.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local damage = skill:getMobHP() / 2

    -- TODO: The damage type should be based off of the Ghrah's element <-- needs verification
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.NONE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    mob:setHP(0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)
    return dmg
end)

m:addOverride("xi.globals.mobskills.coronach.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.corrosive_ooze.onMobWeaponSkill", function(target, mob, skill)
    local typeEffectOne = xi.effect.ATTACK_DOWN
    local typeEffectTwo = xi.effect.DEFENSE_DOWN
    local duration = 120

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffectOne, 15, 0, duration)
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffectTwo, 15, 0, duration)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.cosmic_elucidation.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 21, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, 0)

    dmg = math.min(0, dmg) -- Cosmic Elucidation does not have an absorb message

    target:takeDamage(dmg, mob, xi.attackType.SPECIAL, xi.damageType.ELEMENTAL)
    skill:setMsg(302)

    return dmg
end)

m:addOverride("xi.globals.mobskills.crescent_fang.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 1

    local totaldamage = 0
    local damage = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 0, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    totaldamage = xi.mobskills.mobFinalAdjustments(damage.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, numhits)

    if not skill:hasMissMsg() then
        target:addStatusEffect(xi.effect.PARALYSIS, 50, 0, 90)
        target:takeDamage(totaldamage, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return totaldamage
end)

m:addOverride("xi.globals.mobskills.crescent_moon.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.crimson_howl.onMobWeaponSkill", function(target, mob, skill)
    local power = 25
    local duration = 180

    local typeEffect = xi.effect.WARCRY
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, duration))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.crispy_candle.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 3.5, 3.75, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.critical_bite.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 1, 0, 15)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.cronos_sling_eta.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.cronos_sling_lambda.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.cronos_sling_theta.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.crossthrash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.crosswind.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.cross_attack.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local attmod = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.CRIT_VARIES, 2, 2.5, 3, 0, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.cross_reaper.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.cross_reaver.onMobWeaponSkill", function(target, mob, skill)
    -- TODO: Can skillchain?  Unknown property.

    local numhits = 2
    local accmod = 1
    local dmgmod = 4
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.cryo_jet.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, math.random(10, 15), 3, 120)

    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.ICE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    if target:hasStatusEffect(xi.effect.ELEMENTALRES_DOWN) then
        target:delStatusEffectSilent(xi.effect.ELEMENTALRES_DOWN)
    end

    mob:setLocalVar("nuclearWaste", 0)
    return dmg
end)

m:addOverride("xi.globals.mobskills.crystaline_cocoon.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect1 = xi.effect.PROTECT
    local typeEffect2 = xi.effect.SHELL
    local power1      = 50
    local power2      = 2000
    local duration    = 300

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect1, power1, 0, duration))
    xi.mobskills.mobBuffMove(mob, typeEffect2, power2, 0, duration)

    return typeEffect1
end)

m:addOverride("xi.globals.mobskills.crystal_rain.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.LIGHT, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 1, 2, 2, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.crystal_shield.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.PROTECT, 20, 0, 300))

    return xi.effect.PROTECT
end)

m:addOverride("xi.globals.mobskills.crystal_weapon_fire.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 2, 3, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.crystal_weapon_stone.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.EARTH, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 2, 2, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.crystal_weapon_water.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WATER, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 2, 3, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.crystal_weapon_wind.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WIND, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 2, 3, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.curse.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_I, 25, 0, math.random(900, 2280)))

    return xi.effect.CURSE_I
end)

m:addOverride("xi.globals.mobskills.cursed_sphere.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 2, 3, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.cyclone.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    return dmg
end)

m:addOverride("xi.globals.mobskills.cyclone_wing.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 5, 5, 5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, 60)

    return dmg
end)

m:addOverride("xi.globals.mobskills.cyclonic_torrent.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)

    local typeEffect = xi.effect.MUTE

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 60)

    return dmg
end)

m:addOverride("xi.globals.mobskills.cyclonic_turmoil.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.8, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    local dispel1 = target:dispelStatusEffect()
    local dispel2 = target:dispelStatusEffect()
    local total = 0

    if dispel1 ~= xi.effect.NONE then
        total = total + 1
    end

    if dispel2 ~= xi.effect.NONE then
        total = total + 1
    end

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    if total == 0 then
        return dmg
    else
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
        return total
    end
end)

m:addOverride("xi.globals.mobskills.cyclotail.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.cytokinesis.onMobWeaponSkill", function(target, mob, skill)
    local zoneId = mob:getZoneID()
    local mobId = mob:getID()
    if zones[zoneId].pet and zones[zoneId].pet[mobId] then
        local petIds = zones[zoneId].pet[mobId]
        for i, petId in ipairs(petIds) do
            local pet = GetMobByID(petId)
            if pet and not pet:isSpawned() then
                pet:setSpawn(mob:getXPos(), mob:getYPos(),  mob:getZPos())
                pet:setPos(mob:getXPos(), mob:getYPos(),  mob:getZPos())
                SpawnMob(pet:getID())
                pet:updateEnmity(target)
            end
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.damnation_dive.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.CRIT_VARIES, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 15)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.dancing_chains.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DROWN, 15, 3, 60))

    return xi.effect.DROWN
end)

m:addOverride("xi.globals.mobskills.dancing_edge.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 2, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.danse_macabre.onMobWeaponSkill", function(target, mob, skill)
    local power = 0

    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return xi.effect.CHARM_I
    end

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CHARM_I, power, 3, 60)
    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        mob:charm(target)
        mob:resetEnmity(target)
    end

    skill:setMsg(msg)

    return xi.effect.CHARM_I
end)

m:addOverride("xi.globals.mobskills.dark_harvest.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 1, 0, 1, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.dark_mist.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local typeEffect = xi.effect.WEIGHT

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4.0, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 50, 0, 60)

    return dmg
end)

m:addOverride("xi.globals.mobskills.dark_nova.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3.5, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.dark_orb.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5.5, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.dark_sphere.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 20, 0, 300)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.dark_spore.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BLINDNESS
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 15, 3, 120)

    local cap = 800
    if mob:isInDynamis() and not mob:getMaster() then
        cap = 1055
    end

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.25, 2, xi.magic.ele.DARK, cap)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.dark_wave.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BIO

    local cTime = VanadielHour()
    local power = 8
    if 12 <= cTime then
        power = power + (cTime - 11)
    end

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 60)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.daze.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:addStatusEffect(xi.effect.STUN, 1, 0, 3)
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.daydream.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.CHARM_I
    local power = 0

    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return typeEffect
    end

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 60)
    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        target:delStatusEffect(xi.effect.SLEEP_I)
        mob:charm(target)
    end

    skill:setMsg(msg)

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.deadeye.onMobWeaponSkill", function(target, mob, skill)
    local defDown = false
    local mDefDown = false
    local typeEffect = nil

    defDown = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 50, 0, 120)
    mDefDown = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_DEF_DOWN, 50, 0, 120)

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)

    -- display defense down first, else magic defense down
    if defDown == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.DEFENSE_DOWN
    elseif mDefDown == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.MAGIC_DEF_DOWN
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.deadly_drive.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.deadly_hold.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local crit = 0.3
    local attmod = 2 -- 100%
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.CRIT_VARIES, 1.5, 1.75, 2, crit, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.deafening_tantara.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.SILENCE

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 30))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.deal_out.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    if not skill:hasMissMsg() then
        -- If this move is fully absorbed by shadows - should it still reset hate?
        if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
            mob:resetEnmity(target)
        end

        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.death_ray.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() * 3, xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.death_scissors.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local attmod = 2.5
    local crit = 0.05
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 4, 4.5, 5, crit, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.death_trap.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 10, 3, 300))
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 10))
    mob:resetEnmity(target)

    return xi.effect.POISON, xi.effect.STUN
end)

m:addOverride("xi.globals.mobskills.debonair_rush.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.decayed_filament.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 0, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)
    local typeEffect = xi.effect.POISON

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 18, 3, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.decussate.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, math.random(2, 3) * info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.deep_kiss.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobDrainStatusEffectMove(mob, target))

    return 1
end)

m:addOverride("xi.globals.mobskills.delta_thrust.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    local typeEffect = xi.effect.PLAGUE

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 5, 3, 60)

    return dmg
end)

m:addOverride("xi.globals.mobskills.demonic_flower.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.WEAKNESS
    local dmg1 = mob:getHP() * 0.24
    local dmg2 = dmg1 * 0.5
    -- The dmg amounts and duration are guesstimated based on wiki info.
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 90))

    mob:takeDamage(dmg1)
    target:takeDamage(dmg2, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)

    return dmg2
end)

m:addOverride("xi.globals.mobskills.demonic_howl.onMobWeaponSkill", function(target, mob, skill)
    if target:hasStatusEffect(xi.effect.HASTE) then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return
    else
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 5000, 0, 240))
    end

    return xi.effect.SLOW
end)

m:addOverride("xi.globals.mobskills.demoralizing_roar.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.ATTACK_DOWN
    local power = 500
    local duration = 60

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration)
end)

m:addOverride("xi.globals.mobskills.depuration.onMobWeaponSkill", function(target, mob, skill)
    local effectcount = mob:eraseAllStatusEffect()

    if effectcount == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    else
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    end

    return effectcount
end)

m:addOverride("xi.globals.mobskills.diamondhide.onMobWeaponSkill", function(target, mob, skill)
    local power = 600 -- Guesstimated, def not based on mobs lv+hp*tp like was previously in this script..
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.STONESKIN, power, 0, 300))
    return xi.effect.STONESKIN
end)

m:addOverride("xi.globals.mobskills.diamond_dust.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local dStatMult = 1 -- This allows us to calculate dInt for summoners 2hr
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 9, 9, 9, dStatMult)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.dice_curse.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.CURSE_I

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 30, 0, 300))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.dice_damage.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 6, xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.dice_disease.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.DISEASE

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 180))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.dice_dispel.onMobWeaponSkill", function(target, mob, skill)
    local effect = target:dispelStatusEffect()
    local effect2 = target:dispelStatusEffect()
    local effect3 = target:dispelStatusEffect()
    local num = 0

    if effect ~= xi.effect.NONE then
        num = num + 1
    end

    if effect2 ~= xi.effect.NONE then
        num = num + 1
    end

    if effect3 ~= xi.effect.NONE then
        num = num + 1
    end

    if num == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    end

    return num
end)

m:addOverride("xi.globals.mobskills.dice_heal.onMobWeaponSkill", function(target, mob, skill)
    local heal = target:getMaxHP() - target:getHP()

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    target:addHP(heal)
    target:wakeUp()

    return heal
end)

m:addOverride("xi.globals.mobskills.dice_poison.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.POISON

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 15, 0, 60))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.dice_reset.onMobWeaponSkill", function(target, mob, skill)
    target:resetRecasts()

    skill:setMsg(xi.msg.basic.ABILITIES_RECHARGED)

    return 1
end)

m:addOverride("xi.globals.mobskills.dice_sleep.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.SLEEP_I

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 30))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.dice_slow.onMobWeaponSkill", function(target, mob, skill)
    local slowed = false
    local sleeped = false

    slowed = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 0, 120)
    sleeped = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, 30)

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
    if sleeped then
        return xi.effect.SLEEP_I
    elseif slowed then
        return xi.effect.SLOW
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS) -- no effect
    end

    return nil
end)

m:addOverride("xi.globals.mobskills.dice_stun.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.STUN

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 6))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.dice_tp_loss.onMobWeaponSkill", function(target, mob, skill)
    local reset = 0
    if target:getTP() == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        target:setTP(reset)
        skill:setMsg(xi.msg.basic.TP_REDUCED)
    end

    return reset
end)

m:addOverride("xi.globals.mobskills.diffusion_ray.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.2, 0.65, xi.magic.ele.LIGHT, 500)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.damageType.BREATH, xi.attackType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.LIGHT)

    return dmg
end)

m:addOverride("xi.globals.mobskills.digest.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.dimensional_death.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.25, 2.75, 3.25)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.dirty_claw.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local crit = 0.2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 2, 2.5, 3, 0, crit)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.discharge.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 20, 0, 180)

    local dmgmod = 1.75
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.discharger.onMobWeaponSkill", function(target, mob, skill)
    local typeEffectOne = xi.effect.MAGIC_SHIELD
    local typeEffectTwo = xi.effect.SHOCK_SPIKES

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffectOne, 1, 0, 60))
    xi.mobskills.mobBuffMove(mob, typeEffectTwo, 25, 0, 60)
    return typeEffectOne
end)

m:addOverride("xi.globals.mobskills.discoid.onMobWeaponSkill", function(target, mob, skill)
    local needles = 10000 / skill:getTotalTargets()
    local dmg = xi.mobskills.mobFinalAdjustments(needles, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)

    return dmg
end)

m:addOverride("xi.globals.mobskills.dispelling_wind.onMobWeaponSkill", function(target, mob, skill)
    local dis1 = target:dispelStatusEffect()
    local dis2 = target:dispelStatusEffect()

    if dis1 ~= xi.effect.NONE and dis2 ~= xi.effect.NONE then
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
        return 2
    elseif dis1 ~= xi.effect.NONE or dis2 ~= xi.effect.NONE then
        -- dispeled only one
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
        return 1
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.disseverment.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.ACC_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)
    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    local typeEffect = xi.effect.POISON
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 18, 3, 300)

    return dmg
end)

m:addOverride("xi.globals.mobskills.dissipation.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.TERROR
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 10)

    local count = target:dispelAllStatusEffect()

    if count == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    else
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    end

    return count
end)

m:addOverride("xi.globals.mobskills.dissolve.onMobWeaponSkill", function(target, mob, skill)
    if target:isMob() then
        for _, targ in pairs(target:getEnmityList()) do
            mob:addEnmity(targ.entity, targ.ce, targ.ve)
            if targ.entity:isPC() then
                mob:updateClaim(targ.entity)
                target:resetEnmity(targ.entity)
            end
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.divesting_stampede.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.MAGIC_DEF_DOWN, 30, 0, 60)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 30, 0, 60)

    return dmg
end)

m:addOverride("xi.globals.mobskills.divine_spear.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2.5
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.doctors_orders.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.8, xi.magic.ele.NONE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.NONE, xi.damageType.NONE, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.NONE, xi.damageType.NONE)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.dominion_slash.onMobWeaponSkill", function(target, mob, skill)
    -- TODO: Can skillchain?  Unknown property.

    local numhits = 1
    local accmod = 1
    local dmgmod = 3.25
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    if not skill:hasMissMsg() then
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)

        -- Due to conflicting information, making the dispel resistable.  Correct/tweak if wrong.
        -- Dispel has no status effect or resistance gear, so 0s instead of nulls.
        local resist = xi.mobskills.applyPlayerResistance(mob, 0, target, mob:getStat(xi.mod.INT)-target:getStat(xi.mod.INT), 0, xi.magic.ele.LIGHT)
        if resist > 0.0625 then
            target:dispelStatusEffect()
        end

        -- TODO: Dispel message

        -- Damage is HIGHLY conflicting.  Witnessed anywhere from 300 to 900.
        -- TP DMG VARIES can sort of account for this, but I feel like it's still not right.
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.doom.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.DOOM

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 10, 3, 30))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.double_claw.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.double_down.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local attmod = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3, 0, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.double_kick.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    return dmg
end)

m:addOverride("xi.globals.mobskills.double_punch.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.double_ray.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.double_slap.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.double_thrust.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.dragonfall.onMobWeaponSkill", function(target, mob, skill)
    -- TODO: Can skillchain?  Unknown property.

    local numhits = 1
    local accmod = 1
    local dmgmod = 2.7
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 30)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.dragon_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.2, 1.25, xi.magic.ele.FIRE, 2000)
    dmgmod = utils.conalDamageAdjustment(mob, target, skill, dmgmod, 0.2)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.dragon_kick.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.drainkiss.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_1)
    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.drain_whip.onMobWeaponSkill", function(target, mob, skill)
    local drainEffect = xi.mobskills.drainType.HP
    local dmgmod      = 1
    local info        = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg         = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    local rnd         = math.random(1, 3)

    if rnd == 1 then
        drainEffect = xi.mobskills.drainType.TP
    elseif rnd == 2 then
        drainEffect = xi.mobskills.drainType.MP
    end

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, drainEffect, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.dreadstorm.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.TERROR
    local duration = 10

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 1, 0, duration))

    local dmgmod = 2.5
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.dread_dive.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.dread_shriek.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 50, 0, 60))

    return xi.effect.PARALYSIS
end)

m:addOverride("xi.globals.mobskills.dream_flower.onMobWeaponSkill", function(target, mob, skill)
    local duration = 60

    if mob:getMainLvl() < 10 then
        duration = duration / 2
    end

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, duration))

    return xi.effect.SLEEP_I
end)

m:addOverride("xi.globals.mobskills.dream_shroud.onMobWeaponSkill", function(target, mob, skill)
    local duration = 180
    local hour = VanadielHour()
    local buffvalue = 0
    local multiplier = 1

    -- Diabolos Dynamis Tavnazia
    if mob:getZoneID() == xi.zone.DYNAMIS_TAVNAZIA then
        multiplier = 2
    end

    buffvalue = math.abs(12 - hour) + 1
    target:delStatusEffect(xi.effect.MAGIC_ATK_BOOST)
    target:delStatusEffect(xi.effect.MAGIC_DEF_BOOST)
    target:addStatusEffect(xi.effect.MAGIC_ATK_BOOST, buffvalue * multiplier, 0, duration)
    target:addStatusEffect(xi.effect.MAGIC_DEF_BOOST, (14 - buffvalue) * multiplier, 0, duration)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.drill_branch.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.75, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded * math.random(2, 3))

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BLINDNESS, 50, 0, math.random(20, 45))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.drill_claw.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.MAX_HP_DOWN, 50, 0, 60)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.MAX_TP_DOWN, 50, 0, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.drop_hammer.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded * math.random(2, 3))

    local typeEffect = xi.effect.BIND

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    if mob:getPool() == 6750 then  -- Fahrafahr the Bloodied
        mob:resetEnmity(target)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.dual_strike.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.NONE, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)
    end

    local typeEffect = xi.effect.STUN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    return dmg
end)

m:addOverride("xi.globals.mobskills.dukkeripen_heal.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(mob, math.random(350, 500))
end)

m:addOverride("xi.globals.mobskills.dukkeripen_para.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS

    if xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 20, 0, 120) then
        skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.dukkeripen_shadow.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BLINK, 10, 0, 120))

    return xi.effect.BLINK
end)

m:addOverride("xi.globals.mobskills.dulling_arrow.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.1, 1.2, 1.3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        if math.random(1, 100) < skill:getTP() / 3 then
            target:addStatusEffect(xi.effect.INT_DOWN, 10, 0, 120)
        end

        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.dustvoid.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    for i = xi.slot.MAIN, xi.slot.BACK do
        target:unequipItem(i)
    end

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.dust_cloud.onMobWeaponSkill", function(target, mob, skill)
    local duration = 120

    if mob:getMainLvl() < 10 then
        duration = duration / 2
    end

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 30, 0, duration)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.dynamic_assault.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.dynamic_implosion.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 7)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.eagle_eye_shot.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 9 + math.random()

    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        if dmg > 0 then
            target:addTP(20)
            mob:addTP(80)
        end

        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.eald2_warp_in.onMobWeaponSkill", function(target, mob, skill)
    mob:useMobAbility(mob:getMobMod(xi.mobMod.TELEPORT_END))
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.eald2_warp_out.onMobWeaponSkill", function(target, mob, skill)
    local battletarget = mob:getTarget()
    local t = battletarget:getPos()
    t.rot = battletarget:getRotPos()
    local angle = math.random() * math.pi
    local dist = 1.5
    if mob:getZoneID() == xi.zone.EMPYREAL_PARADOX then
        dist = math.random(1.5, 10) -- Eald'narche in Empyreal Paradox should teleport up to roughly 10' away as shown in captures/videos. (Apoc Nigh)
    end

    local pos = NearLocation(t, dist, angle)
    mob:teleport(pos, battletarget)
    skill:setMsg(xi.msg.basic.NONE)

    return 0
end)

m:addOverride("xi.globals.mobskills.earthbreaker.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.STUN
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 8)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.EARTH, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 1.5, 1.75, 2, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.earthen_fury.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local dStatMult = 1 -- This allows us to calculate dInt for summoners 2hr
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 9, 9, 9, dStatMult)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.earthen_ward.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.STONESKIN
    local base = mob:getMainLvl() * 2 + 50

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, base, 0, 180))

    return xi.effect.STONESKIN
end)

m:addOverride("xi.globals.mobskills.earth_blade.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.ENSTONE
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 65, 0, 60))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.earth_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 1, xi.magic.ele.EARTH, 500)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.EARTH)

    return dmg
end)

m:addOverride("xi.globals.mobskills.earth_crusher.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 4
    local dmgmod = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.NO_EFFECT, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)

    return dmg
end)

m:addOverride("xi.globals.mobskills.earth_maneuver.onMobWeaponSkill", function(target, mob, skill)
    local power = 10
    local duration = 60
    local typeEffect = xi.effect.EARTH_MANEUVER

    -- Fantoccini (ENM: Pulling the Strings)
    if mob:getPool() == 1296 then
        local pet = GetMobByID(mob:getID() + 1)
        pet:addStatusEffect(typeEffect, power, 0, duration)
    else
        mob:getPet():addStatusEffect(typeEffect, power, 0, duration)
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.earth_pounder.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEX_DOWN, 10, 10, 180)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.EARTH, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 2, 3, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.earth_shock.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 0.5, 0.75, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    local typeEffect = xi.effect.STUN
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.echo_drops.onMobWeaponSkill", function(target, mob, skill)
    target:delStatusEffect(xi.effect.SILENCE)
    return 0
end)

m:addOverride("xi.globals.mobskills.eclipse_bite.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.ectosmash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local crit = 0.2
    local attmod = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3, crit, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.electrocharge.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.electromagnetic_field.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.6, xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.emetic_discharge.onMobWeaponSkill", function(target, mob, skill)
    local removables = { xi.effect.FLASH, xi.effect.BLINDNESS, xi.effect.ELEGY, xi.effect.REQUIEM, xi.effect.PARALYSIS, xi.effect.POISON,
                        xi.effect.CURSE_I, xi.effect.CURSE_II, xi.effect.DISEASE, xi.effect.PLAGUE, xi.effect.WEIGHT, xi.effect.BIND,
                        xi.effect.BIO, xi.effect.DIA, xi.effect.BURN, xi.effect.FROST, xi.effect.CHOKE, xi.effect.RASP, xi.effect.SHOCK, xi.effect.DROWN,
                        xi.effect.STR_DOWN, xi.effect.DEX_DOWN, xi.effect.VIT_DOWN, xi.effect.AGI_DOWN, xi.effect.INT_DOWN, xi.effect.MND_DOWN,
                        xi.effect.CHR_DOWN, xi.effect.ADDLE, xi.effect.SLOW, xi.effect.HELIX, xi.effect.ACCURACY_DOWN, xi.effect.ATTACK_DOWN,
                        xi.effect.EVASION_DOWN, xi.effect.DEFENSE_DOWN, xi.effect.MAGIC_ACC_DOWN, xi.effect.MAGIC_ATK_DOWN, xi.effect.MAGIC_EVASION_DOWN,
                        xi.effect.MAGIC_DEF_DOWN, xi.effect.MAX_TP_DOWN, xi.effect.MAX_MP_DOWN, xi.effect.MAX_HP_DOWN }

    local dmg = utils.takeShadows(target, mob, 1, math.random(2, 3)) --removes 2-3 shadows
    --if removed more shadows than were up or there weren't any
    if dmg > 0 then
        for i, effect in ipairs(removables) do
            if mob:hasStatusEffect(effect) then
                local statusEffect = mob:getStatusEffect(effect)
                target:addStatusEffect(effect, statusEffect:getPower(), statusEffect:getTickCount(), statusEffect:getDuration())
                mob:delStatusEffect(effect)
            end
        end
    end

    skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    return 0
end)

m:addOverride("xi.globals.mobskills.empirical_research.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.8, xi.magic.ele.NONE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.NONE, xi.damageType.NONE, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.NONE, xi.damageType.NONE)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.empty_beleaguer.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.empty_crush.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 2, 2.5, 3)

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.empty_cutter.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.empty_cutter_thinker.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local crit = 0.2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 2, 2, 2, crit)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.empty_salvation.onMobWeaponSkill", function(target, mob, skill)
    -- This move is currently coded as blinkable (3 shadows)
    -- Unknown if it should be blinkable
    -- Unknown if the dispels are an additional effect
    target:dispelStatusEffect(xi.effectFlag.DISPELABLE)
    target:dispelStatusEffect(xi.effectFlag.DISPELABLE)
    target:dispelStatusEffect(xi.effectFlag.DISPELABLE)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.empty_seed.onMobWeaponSkill", function(target, mob, skill)
    -- Add knock back!
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0.75, 1.25, 1.75)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, math.random(1, 3))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.empty_thrash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.energy_screen.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PHYSICAL_SHIELD

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 1, 0, 60))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.energy_steal.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 1.5, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.MP, dmg))
    return dmg
end)

m:addOverride("xi.globals.mobskills.enervation.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_DOWN

    local silenced = false
    local blinded = false

    silenced = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 10, 0, 120)

    blinded = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_DEF_DOWN, 8, 0, 120)

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)

    -- display silenced first, else blind
    if silenced == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.DEFENSE_DOWN
    elseif blinded == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.MAGIC_DEF_DOWN
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.entangle.onMobWeaponSkill", function(target, mob, skill)
    if mob:getName() == "Cernunnos" then
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.EARTH, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0)
        local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

        xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg)

        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill,  xi.effect.BIND, 1, 0, 30)

        return dmg
    elseif mob:getPool() == 671 or mob:getPool() == 1346 then -- Cemetery Cherry and leafless Jidra
        local typeEffectOne = xi.effect.BIND
        local typeEffectTwo = xi.effect.POISON

        local numhits = 3
        local accmod = 1
        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

        if not skill:hasMissMsg() then
            mob:resetEnmity(target)
            target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
            skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffectOne, 1, 0, 30))
            xi.mobskills.mobStatusEffectMove(mob, target, typeEffectTwo, 50, 3, 60)
        end

        return typeEffectOne
    else
        local typeEffect = xi.effect.BIND
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 30))
        return typeEffect
    end
end)

m:addOverride("xi.globals.mobskills.entice.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.CHARM_I
    local power = 0

    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return typeEffect
    end

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 1, 30)
    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        mob:charm(target)
    end

    skill:setMsg(msg)

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.envoutement.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local typeEffect = xi.effect.CURSE_I

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 25, 0, 180)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.epoxy_spread.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BIND

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, math.random(30, 90)))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.equalizer.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.erratic_flutter.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 1.5, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg , mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    xi.mobskills.mobBuffMove(mob, xi.effect.HASTE, 2998, 0, 300) -- There is no message for the self buff aspect, only dmg.

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.eternal_damnation.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.DOOM, 10, 3, 30))

    return xi.effect.DOOM
end)

m:addOverride("xi.globals.mobskills.evasion.onMobWeaponSkill", function(target, mob, skill)
    local power = mob:getStat(xi.mod.EVA) * 0.5
    local duration = 180

    local typeEffect = xi.effect.EVASION_BOOST

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, duration))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.everyones_grudge.onMobWeaponSkill", function(target, mob, skill)
    local grudgeKills = 0
    local player = nil

    if target:isPC() then
        grudgeKills = target:getCharVar("EVERYONES_GRUDGE_KILLS")
        player = target
    elseif target:isPet() then
        grudgeKills = target:getMaster():getCharVar("EVERYONES_GRUDGE_KILLS")
        player = target:getMaster()
    end

    local realDmg = 5 * grudgeKills -- Damage is 5 times the amount you have killed

    if
        player and
        player:getEquipID(xi.slot.NECK) == xi.items.UGGALEPIH_NECKLACE
    then
        realDmg = math.floor(realDmg * (1 - (player:getTP() / 3000)))
        player:setTP(0)
    end

    target:takeDamage(realDmg, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)
    return realDmg
end)

m:addOverride("xi.globals.mobskills.everyones_rancor.onMobWeaponSkill", function(target, mob, skill)
    local grudgeKills = 0
    local player = nil

    if target:isPC() then
        grudgeKills = target:getCharVar("EVERYONES_GRUDGE_KILLS")
        player = target
    elseif target:isPet() then
        grudgeKills = target:getMaster():getCharVar("EVERYONES_GRUDGE_KILLS")
        player = target:getMaster()
    end

    local realDmg = 50 * grudgeKills -- Damage is 50 times the amount you have killed

    if
        player and
        player:getEquipID(xi.slot.NECK) == xi.items.UGGALEPIH_NECKLACE
    then
        realDmg = math.floor(realDmg * (1 - (player:getTP() / 3000)))
        player:setTP(0)
    end

    target:takeDamage(realDmg, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)
    return realDmg
end)

m:addOverride("xi.globals.mobskills.evisceration.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 3, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.extremely_bad_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmg = target:getHP()
    target:setHP(0)
    return dmg
end)

m:addOverride("xi.globals.mobskills.exuviation.onMobWeaponSkill", function(target, mob, skill)
    local baseHeal = 500
    local statusHeal = 300
    local effectCount = 0
    local dispel = mob:eraseStatusEffect()

    while (dispel ~= xi.effect.NONE)
    do
        effectCount = effectCount + 1
        dispel = mob:eraseStatusEffect()
    end

    skill:setMsg(xi.msg.basic.SELF_HEAL)
    return xi.mobskills.mobHealMove(mob, statusHeal * effectCount + baseHeal)
end)

m:addOverride("xi.globals.mobskills.eyes_on_me.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = mob:getMobWeaponDmg(xi.slot.MAIN) * 6

    if mob:getZoneID() == bit.bor(xi.zone.TEMENOS, xi.zone.APOLLYON) then
        dmgmod = mob:getMobWeaponDmg(xi.slot.MAIN) * 7
    end

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.SPECIAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.SPECIAL, xi.damageType.DARK)

    return dmg
end)

m:addOverride("xi.globals.mobskills.eye_scratch.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BLINDNESS, 30, 0, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.familiar.onMobWeaponSkill", function(target, mob, skill)
    mob:familiar()

    skill:setMsg(xi.msg.basic.FAMILIAR_MOB)

    return 0
end)

m:addOverride("xi.globals.mobskills.fanatic_dance.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.CHARM_I
    local power = 0

    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return typeEffect
    end

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 60)
    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        mob:charm(target)
    end

    skill:setMsg(msg)

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.fang_rush.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.fantod.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BOOST, 300, 0, 180))

    return xi.effect.BOOST
end)

m:addOverride("xi.globals.mobskills.fast_blade.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.faze.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.TERROR
    local duration = 5

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 1, 0, duration))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.fear_touch.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local crit = 0.2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3, 0, crit)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SLOW, 2500, 0, 300)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.feather_barrier.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.EVASION_BOOST, 25, 0, 180))

    return xi.effect.EVASION_BOOST
end)

m:addOverride("xi.globals.mobskills.feather_maelstrom.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect1 = xi.effect.BIO
    local typeEffect2 = xi.effect.AMNESIA
    local numhits = 1
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect1, 6, 3, 60)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect2, 1, 0, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.feather_storm.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.RANGED, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    local power = math.min(1, mob:getMainLvl() / 7)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, power, 3, 120)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.feather_tickle.onMobWeaponSkill", function(target, mob, skill)
    local tpReduced = 0
    target:setTP(tpReduced)

    skill:setMsg(xi.msg.basic.TP_REDUCED)

    return tpReduced
end)

m:addOverride("xi.globals.mobskills.feeble_bleat.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 25, 0, 90))

    return xi.effect.PARALYSIS
end)

m:addOverride("xi.globals.mobskills.fell_cleave.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.ACC_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.fevered_pitch.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 30, 0, 120)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.fiery_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.2, 1.25, xi.magic.ele.FIRE, 2000)
    dmgmod = utils.conalDamageAdjustment(mob, target, skill, dmgmod, 0.2)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.filamented_hold.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 5000, 0, 180))

    return xi.effect.SLOW
end)

m:addOverride("xi.globals.mobskills.final_exam.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.8, xi.magic.ele.NONE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.FIRE, xi.damageType.MAGICAL, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.final_heaven.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.final_retribution.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, math.random(1, 3))

    local typeEffect = xi.effect.STUN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.final_sting.onMobWeaponSkill", function(target, mob, skill)
    local damage = mob:getHP() * 0.5

    mob:setHP(0)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.LIGHT, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)

    return dmg
end)

m:addOverride("xi.globals.mobskills.fireball.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 2.5, 2.75, 3.0)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.firebomb.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.firespit.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.fire_blade.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.ENFIRE
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 65, 0, 60))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.fire_break.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.5, 1, xi.magic.ele.FIRE, 700)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.fire_ii.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.fire_iv.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.fire_maneuver.onMobWeaponSkill", function(target, mob, skill)
    local power = 10
    local duration = 60
    local typeEffect = xi.effect.FIRE_MANEUVER

    -- Fantoccini (ENM: Pulling the Strings)
    if mob:getPool() == 1296 then
        local pet = GetMobByID(mob:getID() + 1)
        pet:addStatusEffect(typeEffect, power, 0, duration)
    else
        mob:getPet():addStatusEffect(typeEffect, power, 0, duration)
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.fire_meeble_warble.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 9, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 30, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BURN, 50, 3, 60)
    return dmg
end)

m:addOverride("xi.globals.mobskills.fission.onMobWeaponSkill", function(target, mob, skill)
    local id = mob:getID()
    local pos = mob:getPos()

    -- Ingester - ENM: You are what you eat
    if mob:getPool() == 2080 then
        for i = 4, 1, -1 do
            if not GetMobByID(id + i):isSpawned() then
                GetMobByID(id + i):setSpawn(pos.x, pos.y, pos.z)
                SpawnMob(id + i):updateEnmity(mob:getTarget())
                break
            end
        end
    else
        for babyID = id + 1, id + mob:getLocalVar("maxBabies") do
            local baby = GetMobByID(babyID)
            if not baby:isSpawned() then
                SpawnMob(babyID):updateEnmity(mob:getTarget())
                baby:setPos(pos.x, pos.y, pos.z)
                break
            end
        end
    end

    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.flailing_trunk.onMobWeaponSkill", function(target, mob, skill)
    -- add knockback

    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.flame_armor.onMobWeaponSkill", function(target, mob, skill)
    local power = 50
    local duration = 180

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BLAZE_SPIKES, power, 0, duration))

    return xi.effect.BLAZE_SPIKES
end)

m:addOverride("xi.globals.mobskills.flame_arrow.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.flame_blast.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 5
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.flame_blast_alt.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2.5
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    skill:setMsg(xi.msg.basic.HIT_DMG)
    return dmg
end)

m:addOverride("xi.globals.mobskills.flame_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.2, 0.75, xi.magic.ele.FIRE, 600)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    mob:lookAt(target:getPos())
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.flame_thrower.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PLAGUE
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 5, 3, 120)

    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    if target:hasStatusEffect(xi.effect.ELEMENTALRES_DOWN) then
        target:delStatusEffectSilent(xi.effect.ELEMENTALRES_DOWN)
    end

    mob:setLocalVar("nuclearWaste", 0)
    return dmg
end)

m:addOverride("xi.globals.mobskills.flaming_arrow.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.8
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.flaming_crush.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.flat_blade.onMobWeaponSkill", function(target, mob, skill)
    if mob:getPool() == 4006 then -- Trion@Qubia_Arena only
        target:showText(mob, zones[xi.zone.QUBIA_ARENA].text.FLAT_LAND)
    end

    local numhits = 1
    local accmod = 1
    local dmgmod = 1.25
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1.1, 1.2, 1.3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if math.random(1, 100) < skill:getTP() / 3 then
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)
    end

    -- AA EV: Approx 900 damage to 75 DRG/35 THF.  400 to a NIN/WAR in Arhat, but took shadows.
    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.floodlight.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.5
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 15, 3, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FLASH, 200, 3, 20)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.fluid_spread.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local attmod = 1.5 -- 50% attack bonus
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2, 0, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.fluid_toss.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local attmod = 2 -- 100% attack bonus
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.RANGED, 1.5, 1.75, 2.0, 0, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.fluid_toss_claret.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    -- Apply poison if it hits
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, 100, 3, math.random(3, 6) * 3)  -- 3-6 ticks

    return dmg
end)

m:addOverride("xi.globals.mobskills.flurry_of_rage.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.ACC_VARIES, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.flying_hip_press.onMobWeaponSkill", function(target, mob, skill)
    -- Bugbear Matman has more damage (probably only has a higher base damage)
    local damage = 1
    if mob:getPool() == 562 then
        damage = math.random(1.20, 1.30) -- 20-30%  more  base damage roughly
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN) * damage, xi.magic.ele.WIND, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    return dmg
end)

m:addOverride("xi.globals.mobskills.foot_kick.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local crit = 1
    local info = {}

    -- Level 50+ rabbits have a different type of foot kick that has a 2.0 FTP instead of 1.0 This version also crits 100% of the time.
    if mob:getMainLvl() >= 50 then
        info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 2, 2.5, 3, crit)
    else
        info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 1.5, 2, crit)
    end

    if mob:getMaster() then
        info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 1.25, 1.5, crit)
    end

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.forceful_blow.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.formation_attack.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3 -- should be number of bombs left
    local accmod = 1
    local bombNum = 2 -- Base FTP

    if mob:getAnimationSub() == 0 then
        bombNum = bombNum + 3
    elseif mob:getAnimationSub() == 1 then
        bombNum = bombNum + 2
    end

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, bombNum, bombNum, bombNum)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.fortifying_wail.onMobWeaponSkill", function(target, mob, skill)
    local power = 60
    local duration = 300
    local typeEffect = xi.effect.PROTECT

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, duration))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.fossilizing_breath.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PETRIFICATION
    local power = 1

    local duration = 60

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.foul_breath.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DISEASE, 1, 0, 180)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.083, 1, xi.magic.ele.FIRE, 500)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.fountain.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WATER, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.foxfire.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 15)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.freezebite.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 0, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.freeze_rush.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.ICE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.frenetic_rip.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.frenzied_rage.onMobWeaponSkill", function(target, mob, skill)
    local power = 190 / 1024 -- 18.56%
    local duration = 120

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.ATTACK_BOOST, power, 0, duration))
    return xi.effect.ATTACK_BOOST
end)

m:addOverride("xi.globals.mobskills.frenzy_pollen.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.HUNDRED_FISTS, 1, 0, 30)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.HUNDRED_FISTS
end)

m:addOverride("xi.globals.mobskills.frightful_roar.onMobWeaponSkill", function(target, mob, skill)
    -- Player version is 10%.  Mob version is 30% https://www.bg-wiki.com/ffxi/Category:Taurus
    local typeEffect = xi.effect.DEFENSE_DOWN
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 30, 0, 180))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.frigid_shuffle.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 50, 0, math.random(60, 120)))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.frogkick.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local crit = 0.05
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1.5, 1.75, 2, crit)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.frog_cheer.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.MAGIC_ATK_BOOST

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 25, 0, 300))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.frostbite.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.frost_armor.onMobWeaponSkill", function(target, mob, skill)
    local power = 10
    local duration = 180
    local typeEffect = xi.effect.ICE_SPIKES

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, duration))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.frost_blade.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.ENBLIZZARD
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 65, 0, 60))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.frost_breath.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 50, 0, 180)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.083, 1, xi.magic.ele.ICE, 500)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.ICE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.frypan.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, math.random(5, 15)) -- Yes..15 seconds

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.full-force_blow.onMobWeaponSkill", function(target, mob, skill)
    -- Add Knockback Animation
    local numhits = 1
    local accmod = 1
    local attmod = 1.5 -- 50% attack bonus
    local crit = 0.3
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3, crit, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.full_swing.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.fulmination.onMobWeaponSkill", function(target, mob, skill)
    -- TODO: Hits all players near Khimaira, not just alliance.

    local dmgmod = 3
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 40, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.fuscous_ooze.onMobWeaponSkill", function(target, mob, skill)
    -- TODO: Encumberance seems to do nothing?
    local typeEffect = xi.effect.WEIGHT
    local duration = 45

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 50, 0, duration)

    local dmgmod = 1
    local baseDamage = mob:getWeaponDmg() * 3.7
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, baseDamage, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.gaea_stream_eta.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.75
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.gaea_stream_lambda.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.25
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.gaea_stream_theta.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.gala_macabre.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.CHARM_I
    local power = 0

    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return typeEffect
    end

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 60)
    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        mob:charm(target)
        mob:resetEnmity(target)
    end

    skill:setMsg(msg)

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.gale_axe.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.8
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, info.hitslanded)

    if not skill:hasMissMsg() then
        target:addStatusEffect(xi.effect.CHOKE, 1, 0, 120)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.gastric_bomb.onMobWeaponSkill", function(target, mob, skill)
    local duration = 180
    local power = 50

    if skill:getID() == 1886 then -- Nightmare Worm - 90%
        power = 90
    end

    if mob:getMainLvl() < 10 then
        duration = duration / 2
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WATER, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, power, 0, duration)

    return dmg
end)

m:addOverride("xi.globals.mobskills.gas_shell.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 26, 3, math.random(30, 90)))

    return xi.effect.POISON
end)

m:addOverride("xi.globals.mobskills.gates_of_hades.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BURN
    local power = 30

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 60)

    local dmgmod = 1.0
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() * 12.5, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, nil, nil, nil, 1.0)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.gate_of_tartarus.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.5

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local duration = 60
    local typeEffect = xi.effect.ATTACK_DOWN
    local power = 20

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, power, 0, duration)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.geirskogul.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.geist_wall.onMobWeaponSkill", function(target, mob, skill)
    local dispel = target:dispelStatusEffect()

    if dispel == xi.effect.NONE then
        -- no effect
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
    end

    return dispel
end)

m:addOverride("xi.globals.mobskills.geocrush.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.STUN

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 6)

    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.geotic_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.15, 1.25, xi.magic.ele.EARTH, 1150)
    dmgmod = utils.conalDamageAdjustment(mob, target, skill, dmgmod, 0.2)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.gerjis_grip.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.STUN
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 1, 0, 10))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.geush_auto.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 7
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod,  xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    skill:setMsg(xi.msg.basic.HIT_DMG)
    return dmg
end)

m:addOverride("xi.globals.mobskills.gigaflare.onMobWeaponSkill", function(target, mob, skill)
    if mob:getID() == 16896156 then -- BV1 Bahamut
        mob:setLocalVar("tauntShown", 0)
        mob:setMobAbilityEnabled(true) -- enable the spells/other mobskills again
        mob:setMagicCastingEnabled(true)
        mob:setAutoAttackEnabled(true)
        if mob:getBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN)) == 0 then -- re-enable noturn
            mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
        end
    elseif mob:getID() == 16896157 then -- BV2 Bahamut
        local gigaFlareCount = mob:getLocalVar("gigaFlareCount")
        mob:setLocalVar("gigaFlareCount", gigaFlareCount + 1)
        mob:setLocalVar("FlareWait", 0) -- reset the variables for Xflare.
        mob:setLocalVar("tauntShown", 0)
        mob:setMobAbilityEnabled(true) -- re-enable the other actions on success
        mob:setMagicCastingEnabled(true)
        mob:setAutoAttackEnabled(true)
        if mob:getBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN)) == 0 then -- re-enable noturn
            mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
        end
    end

    local dStatMult = 1.5
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, 14 * mob:getMainLvl(), xi.magic.ele.FIRE, nil, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, nil, nil, nil, dStatMult)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.giga_scream.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.giga_slash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.glacial_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.2, 1.25, xi.magic.ele.ICE, 2000)
    dmgmod = utils.conalDamageAdjustment(mob, target, skill, dmgmod, 0.2)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.ICE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.glacier_splitter.onMobWeaponSkill", function(target, mob, skill)
    local numhits = math.random(1, 3)
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local typeEffect = xi.effect.PARALYSIS

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 15, 0, 120)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.gliding_spike.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)
    local typeEffect = xi.effect.STUN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.glittering_ruby.onMobWeaponSkill", function(target, mob, skill)
    --randomly give str/dex/vit/agi/int/mnd/chr (+12)
    local effect = math.random()
    local effectid = xi.effect.STR_BOOST
    if effect <= 0.14 then --STR
        effectid = xi.effect.STR_BOOST
    elseif effect <= 0.28 then --DEX
        effectid = xi.effect.DEX_BOOST
    elseif effect <= 0.42 then --VIT
        effectid = xi.effect.VIT_BOOST
    elseif effect <= 0.56 then --AGI
        effectid = xi.effect.AGI_BOOST
    elseif effect <= 0.7 then --INT
        effectid = xi.effect.INT_BOOST
    elseif effect <= 0.84 then --MND
        effectid = xi.effect.MND_BOOST
    else --CHR
        effectid = xi.effect.CHR_BOOST
    end

    target:addStatusEffect(effectid, math.random(12, 14), 0, 90)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return effectid
end)

m:addOverride("xi.globals.mobskills.gloeosuccus.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 3500, 0, 180))

    return xi.effect.SLOW
end)

m:addOverride("xi.globals.mobskills.goblin_rush.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.gospel_of_the_lost.onMobWeaponSkill", function(target, mob, skill)
    mob:eraseStatusEffect()
    -- Didn't see any msg for the erase in youtube vids.
    skill:setMsg(xi.msg.basic.SELF_HEAL)
    -- Assuming its a 4-6% heal based on its max HP and numbers quoted on wiki.
    return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * (math.random(4, 6) * 0.01))
end)

m:addOverride("xi.globals.mobskills.grand_fall.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 3
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.grand_slam.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    if mob:getPool() == 1792 then -- Gration's Grand Slam hits twice as hard
        dmgmod = 2
    end

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, math.random(1, 3))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.granite_skin.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.PHYSICAL_SHIELD, 3, 0, 30)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.grapple.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.grave_reel.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))
    return dmg
end)

m:addOverride("xi.globals.mobskills.gravitic_horn.onMobWeaponSkill", function(target, mob, skill)
    local currentHP = target:getHP()
    -- remove all by 5%
    local baseDamage = 0

    -- estimation based on "Throat Stab-like damage"
    if currentHP / target:getMaxHP() > 0.2 then
        baseDamage = currentHP * .95
    else
        baseDamage = currentHP
    end

    -- Because shell matters, but we don't want to calculate damage normally via xi.mobskills.mobMagicalMove since this is a % attack
    local damage = baseDamage * xi.magic.getElementalDamageReduction(target, xi.magic.ele.WIND)
    -- we still need final adjustments to handle stoneskin etc though
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    mob:resetEnmity(target)
    return damage
end)

m:addOverride("xi.globals.mobskills.gravity_field.onMobWeaponSkill", function(target, mob, skill)
    if target:hasStatusEffect(xi.effect.HASTE) then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return
    else
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 4500, 0, math.random(240, 420)))
    end

    return xi.effect.SLOW
end)

m:addOverride("xi.globals.mobskills.gravity_wheel.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 1, 0, 30)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.great_bleat.onMobWeaponSkill", function(target, mob, skill)
    if mob:getPool() == 230 then -- Aries
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_HP_DOWN, 75, 0, 90)) -- 75% HP Reduction for 90s
    else
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_HP_DOWN, 75, 0, 60)) -- Regular mobs are also 75%
    end

    return xi.effect.MAX_HP_DOWN
end)

m:addOverride("xi.globals.mobskills.great_sandstorm.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 20, 0, 180)

    local damage = mob:getMainLvl() * 3
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.WIND, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.great_wheel.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        mob:resetEnmity(target)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.great_whirlwind.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CHOKE, 3, 3, 90)

    local damage = mob:getMainLvl() * 4
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.WIND, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.gregale_wing.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 40, 0, 120)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 4, 4, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.gregale_wing_air.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 40, 0, 120)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 5, 5, 5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.grim_halo.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 2.5, 3, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.ground_strike.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 4
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.guided_missile.onMobWeaponSkill", function(target, mob, skill)
    local ftp100 = 2
    local ftp200 = 2.5
    local ftp300 = 3
    local numhits = math.random(1, 3)
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, ftp100, ftp200, ftp300)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.guided_missile_ii.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.guillotine.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 4
    local accmod = 1
    local dmgmod = 1.2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, (skill:getTP() * 30 / 1000) + 30)
        -- 242 to a NIN, but shadows ate some hits
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.gusting_gouge.onMobWeaponSkill", function(target, mob, skill)
    local numhits = math.random(2, 3)
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCE, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.gust_slash.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.8
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.hammer-go-round.onMobWeaponSkill", function(target, mob, skill)
    local numhits = math.random(2, 3)
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.hammer_beak.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.hane_fubuki.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    local typeEffect = xi.effect.POISON

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, math.min(1, mob:getMainLvl() / 7), 3, 120)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.happobarai.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, math.random(2, 3))

    local typeEffect = xi.effect.STUN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.harden_shell.onMobWeaponSkill", function(target, mob, skill)
    local power = 33

    if mob:isNM() then
        power = 80
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, power, 0, 60))

    return xi.effect.DEFENSE_BOOST
end)

m:addOverride("xi.globals.mobskills.hard_membrane.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.EVASION_BOOST, 25, 0, 180))

    return xi.effect.EVASION_BOOST
end)

m:addOverride("xi.globals.mobskills.hard_slash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.havoc_spiral.onMobWeaponSkill", function(target, mob, skill)
    -- TODO: Can skillchain?  Unknown property.

    local numhits = 1
    local accmod = 1
    local dmgmod = 3
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, math.random(2, 3))

    if not skill:hasMissMsg() then
        -- Witnessed 280 to a melee, 400 to a BRD, and 500 to a wyvern
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, math.random(30, 60))
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.haymaker.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.AMNESIA, 1, 0, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.head_butt.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    -- Mandragora Head Butt does not Stun
    if mob:getFamily() ~= 178 then
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)
    end

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.head_butt_turtle.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    -- Large Knockdown
    local typeEffect = xi.effect.ACCURACY_DOWN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 50, 0, math.random(120, 180))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.head_snatch.onMobWeaponSkill", function(target, mob, skill)
    local targetCurrentHP = target:getHP()
    local targetmaxHP = target:getMaxHP()
    local hpset = targetmaxHP * 0.10
    local dmg = 0

    if targetCurrentHP > hpset then
        dmg = targetCurrentHP - hpset
    end

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.healing_breeze.onMobWeaponSkill", function(target, mob, skill)
    -- Healing value is max hp * 172 / 1024
    local potency = 172 / 1024

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(target, target:getMaxHP() * potency)
end)

m:addOverride("xi.globals.mobskills.healing_ruby.onMobWeaponSkill", function(target, mob, skill)
    local potency = skill:getParam()

    if potency == 0 then
        potency = 13
    end

    potency = potency - math.random(0, potency / 4)

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * potency / 100)
end)

m:addOverride("xi.globals.mobskills.healing_ruby_ii.onMobWeaponSkill", function(target, mob, skill)
    local potency = skill:getParam()

    if potency == 0 then
        potency = 25
    end

    potency = potency - math.random(0, potency / 4)

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * potency / 100)
end)

m:addOverride("xi.globals.mobskills.heat_barrier.onMobWeaponSkill", function(target, mob, skill)
    -- TODO: Enfire power, Blaze Spikes reduced power in Salvage zones
    local typeEffectOne = xi.effect.BLAZE_SPIKES
    -- local typeEffectTwo = xi.effect.ENFIRE
    local randy = math.random(50, 67)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffectOne, randy, 0, 180))
    -- xi.mobskills.mobBuffMove(mob, typeEffectTwo, ???, 0, 180)

    return typeEffectOne
end)

m:addOverride("xi.globals.mobskills.heat_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.125, 1, xi.magic.ele.FIRE, 500)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.heavenly_strike.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2.7
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.magic.ele.ICE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.heavy_armature.onMobWeaponSkill", function(target, mob, skill)
    -- Not much info on how much haste this gives. Supposed to be "high". Went with Magic Haste Cap
    xi.mobskills.mobBuffMove(mob, xi.effect.HASTE, 4375, 0, 180)
    xi.mobskills.mobBuffMove(mob, xi.effect.PROTECT, 100, 0, 180)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BLINK, math.random(10, 25), 0, 120))

    return xi.effect.BLINK
end)

m:addOverride("xi.globals.mobskills.heavy_bellow.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 6))

    return xi.effect.STUN
end)

m:addOverride("xi.globals.mobskills.heavy_blow.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.heavy_stomp.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    local typeEffect = xi.effect.PARALYSIS
    local duration = 360
    local power = 30

    if mob:getPool() == 3575 then
        duration = 960
        power    = 70
    end

    mob:lookAt(target:getPos())

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, power, 0, duration)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.heavy_strike.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local crit = 0.15
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.5, 2, 2.5, crit)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local typeEffect = xi.effect.SLOW

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1250, 0, 120)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.heavy_swing.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.heavy_whisk.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 3.5, 3.75, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.hecatomb_wave.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 30, 0, 120)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 1.5, xi.magic.ele.WIND, 260)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.hellclap.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 10
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded * math.random(2, 3))
    local typeEffect = xi.effect.WEIGHT

    if not skill:hasMissMsg() then
        xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 40, 0, 60)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.helldive.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.hellfire_arrow.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BURN
    local power = math.random(10, 30)

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 60)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.7, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    return dmg
end)

m:addOverride("xi.globals.mobskills.hellsnap.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    return xi.effect.STUN
end)

m:addOverride("xi.globals.mobskills.hell_slash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local crit = 0.2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3, crit)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.hexagon_belt.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_BOOST
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 20, 0, 180))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.hexa_strike.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 6
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1.1, 1.2, 1.3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.hexidiscs.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 6
    local accmod = 1
    local dmgmod = .7
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.hex_eye.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 60, 0, 60))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.hex_palm.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.hi-freq_field.onMobWeaponSkill", function(target, mob, skill)
    local evasion = target:getStat(xi.mod.EVA) * 0.25

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.EVASION_DOWN, evasion, 0, 180))

    return xi.effect.EVASION_DOWN
end)

m:addOverride("xi.globals.mobskills.hiden_sokyaku.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    local typeEffect = xi.effect.STUN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    return dmg
end)

m:addOverride("xi.globals.mobskills.hiemal_storm.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.3, 1, xi.magic.ele.ICE, 1300)
    dmgmod = utils.conalDamageAdjustment(mob, target, skill, dmgmod, 0.9)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.ICE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.ICE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.high-tension_discharger.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.STUN
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 3, 2)

    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    if target:hasStatusEffect(xi.effect.ELEMENTALRES_DOWN) then
        target:delStatusEffectSilent(xi.effect.ELEMENTALRES_DOWN)
    end

    mob:setLocalVar("nuclearWaste", 0)
    return dmg
end)

m:addOverride("xi.globals.mobskills.hoof_volley.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 4, 4.25, 4.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        mob:resetEnmity(target)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.horrible_roar.onMobWeaponSkill", function(target, mob, skill)
    local count = 0

    for i = 1, 4 do
        local dispel = target:dispelStatusEffect()
        if dispel ~= xi.effect.NONE then
            count = count + 1
        end
    end

    if count > 0 then
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    end

    return count
end)

m:addOverride("xi.globals.mobskills.horrid_roar_1.onMobWeaponSkill", function(target, mob, skill)
    local dispel = target:dispelStatusEffect(bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.FOOD))

    if dispel == xi.effect.NONE then
        -- no effect
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
    end

    mob:lowerEnmity(target, 20)

    return dispel
end)

m:addOverride("xi.globals.mobskills.horrid_roar_2.onMobWeaponSkill", function(target, mob, skill)
    local dispel =  target:dispelAllStatusEffect(bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.FOOD))

    if dispel == 0 then
        -- no effect
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    end

    mob:lowerEnmity(target, 45)

    return dispel
end)

m:addOverride("xi.globals.mobskills.horrid_roar_3.onMobWeaponSkill", function(target, mob, skill)
    local dispel =  target:dispelAllStatusEffect(bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.FOOD))

    if dispel == 0 then
        -- no effect
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    end

    mob:resetEnmity(target)

    return dispel
end)

m:addOverride("xi.globals.mobskills.horror_cloud.onMobWeaponSkill", function(target, mob, skill)
    local noResist = 1

    -- 2 minute unresisted duration.
    if target:hasStatusEffect(xi.effect.HASTE) then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return
    else
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 5000, 0, 120, 0, 0, noResist))
    end

    return xi.effect.SLOW
end)

m:addOverride("xi.globals.mobskills.hot_shot.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.8
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.howl.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.WARCRY, 25, 0, 180))

    return xi.effect.WARCRY
end)

m:addOverride("xi.globals.mobskills.howling.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, math.random(30, 40), 0, 60))

    return xi.effect.PARALYSIS
end)

m:addOverride("xi.globals.mobskills.howling_fist.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local attmod = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.5, 2.5, 0, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.howling_moon.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local dStatMult = 1 -- This allows us to calculate dInt for summoners 2hr
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 9, 9, 9, dStatMult)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.hundred_fists.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.HUNDRED_FISTS, 1, 0, 45)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.HUNDRED_FISTS
end)

m:addOverride("xi.globals.mobskills.hungry_crunch.onMobWeaponSkill", function(target, mob, skill)
    local power = math.random(0, 151) + 150
    local dmg = xi.mobskills.mobFinalAdjustments(power, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    if not skill:hasMissMsg() then
        local tpDrain = math.random(100, 200)
        target:addTP(-tpDrain)
        mob:addTP(tpDrain)

        if target:hasStatusEffect(xi.effect.FOOD) then
            target:delStatusEffect(xi.effect.FOOD)
        elseif target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
            target:delStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
        end

        skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.hurricane_wing.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BLINDNESS
    local dmgmod = 5

    if mob:getName() == "Nidhogg" then
        dmgmod = 6
        xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 160, 0, 30)
    else
        xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 100, 0, 30)
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.hurricane_wing_flying.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 60, 0, 30)

    local dmgmod = 4
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.hydro_ball.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, 33, 10, 120)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WATER, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 1.5, 2, 2.5, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.hydro_canon.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, 30, 3, 120)

    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    if target:hasStatusEffect(xi.effect.ELEMENTALRES_DOWN) then
        target:delStatusEffectSilent(xi.effect.ELEMENTALRES_DOWN)
    end

    mob:setLocalVar("nuclearWaste", 0)
    return dmg
end)

m:addOverride("xi.globals.mobskills.hydro_shot.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 3, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        mob:resetEnmity(target)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.hyper-potion.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.msg.basic.SELF_HEAL)
    return xi.mobskills.mobHealMove(target, 250)
end)

m:addOverride("xi.globals.mobskills.hyper_pulse.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, math.random(5, 15))
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 50, 0, 30)

    return dmg
end)

m:addOverride("xi.globals.mobskills.hypnogenesis.onMobWeaponSkill", function(target, mob, skill)
    -- Deals a large percent of hp dmg, can be resisted (rarely), and cannot kill
    local percent = math.random(0, 10) -- percent hp remaining - no joke https://youtu.be/Bvp-T3_U7xA?t=31
    local damage = math.max(0, target:getHP() - target:getHP() * (percent / 100))
    local dmg = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    -- only allow a maximum of % damage even if modifiers would increase the damage
    dmg = math.min(damage, dmg)

    if dmg >= target:getHP() then
        dmg = target:getHP() - 1
    end

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.hypnosis.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.SLEEP_I, 1, 0, math.random(45, 60)))

    return xi.effect.SLEEP_I
end)

m:addOverride("xi.globals.mobskills.hypnotic_sway.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.AMNESIA
    local power = 1
    local duration = 60

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.hypothermal_combustion.onMobWeaponSkill", function(target, mob, skill)
    local damage = skill:getMobHP() / 3
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.ICE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:setHP(0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.hysteric_assault.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.hysteric_barrage.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local dmgmod = .7
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.ice_break.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BIND

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.ICE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 30)

    return dmg
end)

m:addOverride("xi.globals.mobskills.ice_maneuver.onMobWeaponSkill", function(target, mob, skill)
    local power = 10
    local duration = 60
    local typeEffect = xi.effect.ICE_MANEUVER

    -- Fantoccini (ENM: Pulling the Strings)
    if mob:getPool() == 1296 then
        local pet = GetMobByID(mob:getID() + 1)
        pet:addStatusEffect(typeEffect, power, 0, duration)
    else
        mob:getPet():addStatusEffect(typeEffect, power, 0, duration)
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.ice_roar.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.ICE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)

    return dmg
end)

m:addOverride("xi.globals.mobskills.ichor_stream.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.POISON

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 5, 0, 120))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.ill_wind.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.5, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:dispelStatusEffect()
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    return dmg
end)

m:addOverride("xi.globals.mobskills.immortal_anathema.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.CURSE_I

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 25, 0, 300)

    skill:setMsg(msg)

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.impact_roar.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WIND, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1.5, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.impact_stream.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 60, 0, 60)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.LIGHT, 1, 0, 0, 0, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.impale.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local attmod = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2, 0, attmod)
    local shadows = info.hitslanded

    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        shadows = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
        typeEffect = xi.effect.POISON

        if not skill:hasMissMsg() then
            mob:resetEnmity(target)
        end
    end

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, shadows)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 20, 0, 120)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.impalement.onMobWeaponSkill", function(target, mob, skill)
    local damage = target:getHP() * 0.95

    local dmg = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

    mob:resetEnmity(target)
    return dmg
end)

m:addOverride("xi.globals.mobskills.implosion.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.impulse_drive.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 2, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.impulsion.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1

    local mobhpp = mob:getHPP()
    local baseDmgMult = 2.75
    local basePetrifyDuration = 15
    -- Baha v1 or v2 in gigaflare mode then double the damage and petrify duration
    if
        (mob:getID() == 16896156 and mobhpp <= 10) or
        (mob:getID() == 16896157 and mobhpp <= 50)
    then
        baseDmgMult = 5.5
        basePetrifyDuration = 30
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() * baseDmgMult, xi.magic.ele.NONE, dmgmod, xi.mobskills.magicalTpBonus.TP_NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)

    local typeEffect1 = xi.effect.PETRIFICATION
    local typeEffect2 = xi.effect.BLINDNESS
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect1, 1, 0, basePetrifyDuration)
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect2, 15, 0, 60)

    return dmg
end)

m:addOverride("xi.globals.mobskills.incensed_pummel.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    -- Random stat down
    local typeEffect = 136 + math.random(0, 6) -- 136 is xi.effect.STR_DOWN add 0 to 6 for all 7 of the possible attribute reductions

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 20, 3, 120)

    return dmg
end)

m:addOverride("xi.globals.mobskills.incessant_fists.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.incinerate.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1375, 1, xi.magic.ele.FIRE, 700)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.infernal_deliverance.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 0, 0, 10)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.infernal_pestilence.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 3, 780)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 1, xi.magic.ele.WATER, 200)
    local dmg    = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.inferno.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local dStatMult = 1 -- This allows us to calculate dInt for summoners 2hr
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 9, 9, 9, dStatMult)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.inferno_blast.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 7, 7, 7)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.inferno_blast_alt.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 4, 4, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    skill:setMsg(xi.msg.basic.HIT_DMG)
    return dmg
end)

m:addOverride("xi.globals.mobskills.infrasonics.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.EVASION_DOWN, 40, 0, 180))

    return xi.effect.EVASION_DOWN
end)

m:addOverride("xi.globals.mobskills.ink_cloud.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BLINDNESS
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 15, 0, 120))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.ink_jet.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 80, 0, 120)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.ink_jet_alt.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.5, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 20, 0, 180)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.insipid_nip.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if xi.mobskills.mobPhysicalHit(skill) then
        target:dispelStatusEffect()
    end

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.inspirit.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.msg.basic.SELF_HEAL)

    -- Todo: verify/correct maths
    return xi.mobskills.mobHealMove(mob, math.floor(mob:getHP() / 7) * 2)
end)

m:addOverride("xi.globals.mobskills.intimidate.onMobWeaponSkill", function(target, mob, skill)
    local power = 2500
    if skill:getID() == 1864 then -- Nightmare Makara - 12s Haste recast w/o slow.  20s w/.  Overwrites Haste
        power = 6600
    end

    if target:hasStatusEffect(xi.effect.HASTE) and skill:getID() ~= 1864 then
        -- Does this really belong here?  Shouldnt the effect power handle this?
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return
    else
        skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.SLOW, power, 0, 120))
    end

    return xi.effect.SLOW
end)

m:addOverride("xi.globals.mobskills.invincible.onMobWeaponSkill", function(target, mob, skill)
    local duration = 30

    -- Hotupuku ENM: Bugard in the Clouds
    if mob:getPool() == 1992 then
        duration = 900
    end

    xi.mobskills.mobBuffMove(mob, xi.effect.INVINCIBLE, 1, 0, duration)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.INVINCIBLE
end)

m:addOverride("xi.globals.mobskills.ion_efflux.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 20, 0, 180))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.ion_shower.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.STUN

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 5)

    local dmgmod = 1
    -- JoL already has base weapon dmg bonus of 3x so no need for additional multiplier
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 2, 2, 2, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.iridal_pierce.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3.5, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.iron_tempest.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.0, 1.5, 2.0)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.jamming_wave.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.SILENCE

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 120))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.javelin_throw.onMobWeaponSkill", function(target, mob, skill)
    mob:setAnimationSub(1)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobRangedMoveMobRangedMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.jettatura.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.TERROR, 1, 0, 10))

    return xi.effect.TERROR
end)

m:addOverride("xi.globals.mobskills.jet_stream.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.CRIT_VARIES, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.judgment.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 0.6
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.ACC_VARIES, 2.0, 2.5, 3.0)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.judgment_bolt.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local dStatMult = 1 -- This allows us to calculate dInt for summoners 2hr
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 9, 9, 9, dStatMult)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.jump.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.jumping_thrust.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.kartstrahl.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.ICE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SLEEP_I, 1, 0, math.random(30, 90))

    return dmg
end)

m:addOverride("xi.globals.mobskills.keen_edge.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.kibosh.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.AMNESIA
    local power = 1
    local duration = 60

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.kick_back.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.kick_out.onMobWeaponSkill", function(target, mob, skill)
    local numhits = math.random(2, 3)
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    local typeEffect = xi.effect.BLINDNESS

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 20, 0, 120)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.king_cobra_clamp.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.knife_edge_circle.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 20, 3, math.random(60, 120)))
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, math.random(5, 15))

    return xi.effect.POISON, xi.effect.STUN
end)

m:addOverride("xi.globals.mobskills.knights_of_round.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.knockout.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:addStatusEffect(xi.effect.EVASION_DOWN, 15, 0, 120)
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.lamb_chop.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.lamentation.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DIA, 8, 3, 30, 0, 20.3)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.LIGHT, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.laser_shower.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.2, 1.25, xi.magic.ele.LIGHT, 1600)
    local dis = ((mob:checkDistance(target) * 2) / 20)

    dmgmod = dmgmod * dis
    dmgmod = utils.clamp(dmgmod, 50, 1600)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 25, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.LIGHT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.lateral_slash.onMobWeaponSkill", function(target, mob, skill)
    if mob:getFamily() == 271 then -- Jailer of Love, uses only animation.
        skill:setMsg(xi.msg.NONE)
        return 0
    end

    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 83, 0, 30)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.lateral_slash_2hr.onMobWeaponSkill", function(target, mob, skill)
    if mob:getPool() == 1507 then -- Geush Urvan
        local typeEffect = xi.effect.COUNTERSTANCE

        xi.mobskills.mobBuffMove(mob, typeEffect, 10, 0, 60)
        skill:setMsg(xi.msg.basic.NONE)
        return 0
    else
        skill:setMsg(xi.msg.basic.NONE)
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.lava_spit.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.lead_breath.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.WEIGHT

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 50, 0, 300))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.leafstorm.onMobWeaponSkill", function(target, mob, skill)
    if
        mob:getName() == "Cernunnos" or
        mob:getPool() == 671 or
        mob:getPool() == 1346
    then
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 128, 3, 120)

        local count = target:dispelAllStatusEffect(bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.FOOD))
        if count == 0 then
            skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        else
            skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
        end
    end

    local ftp100 = 1
    local ftp200 = 1.5
    local ftp300 = 2

    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        ftp100 = 5
        ftp200 = 5
        ftp300 = 5
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WIND, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, ftp100, ftp200, ftp300)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.leaf_dagger.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.RANGED, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    local power = math.floor(mob:getMainLvl() / 10) + 1
    local duration = 90

    if mob:getMainLvl() < 10 then
        duration = duration / 2
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, power, 3, duration)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.leaping_cleave.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 3
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.leg_sweep.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:addStatusEffect(xi.effect.STUN, 1, 0, 3)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.lesson_in_pain.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.8, xi.magic.ele.NONE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.NONE, xi.damageType.NONE, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.NONE, xi.damageType.NONE)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.lethe_arrows.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 3
    local dmgmod = 4
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AMNESIA, 1, 0, 120)

    return dmg
end)

m:addOverride("xi.globals.mobskills.level_5_petrify.onMobWeaponSkill", function(target, mob, skill)
    if target:getMainLvl() % 5 == 0 then
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PETRIFICATION, 1, 0, 30))
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    end

    return xi.effect.PETRIFICATION
end)

m:addOverride("xi.globals.mobskills.lightning_armor.onMobWeaponSkill", function(target, mob, skill)
    local power = 10
    local duration = 180
    local typeEffect = xi.effect.SHOCK_SPIKES

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, duration))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.lightning_blade.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.ENTHUNDER
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 65, 0, 60))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.lightning_roar.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.LIGHTNING, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.light_blade.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 7
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.SLASHING, info.hitslanded)
    -- TODO: There's no MOBPARAM_RANGED, but MOBPARAM doesn't appear to do anything?
    -- Guessing ~40-100% damage based on range (20/50+).
    -- TODO: Find better data?
    -- ~400-450ish at tanking/melee range for a PLD with defender up and earth staff.
    -- ~750 for a DRG/BLU w/o Cocoon up at melee range.
    -- Wiki says 1k, videos were actually less, so trusting videos.
    if not skill:hasMissMsg() then
        local distance = mob:checkDistance(target)
        distance = utils.clamp(distance, 0, 40)
        dmg = dmg * ((50 - distance) / 50)

        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.light_of_penance.onMobWeaponSkill", function(target, mob, skill)
    local tpReduced = 0
    target:setTP(tpReduced)

    local duration = math.random(30, 60)

    xi.mobskills.mobGazeMove(mob, target, xi.effect.BLINDNESS, 100, 0, duration)
    xi.mobskills.mobGazeMove(mob, target, xi.effect.BIND, 1, 0, duration)

    skill:setMsg(xi.msg.basic.TP_REDUCED)

    return tpReduced
end)

m:addOverride("xi.globals.mobskills.lodesong.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 50, 0, 50))

    return nil
end)

m:addOverride("xi.globals.mobskills.lowing.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 0, math.random(45, 120)))

    return xi.effect.PLAGUE
end)

m:addOverride("xi.globals.mobskills.luminous_drape.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.CHARM_I
    local power = 0

    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return typeEffect
    end

    local charmDuration = 60
    if mob:getName() == "Jailer_of_Love" then
        charmDuration = 10
    end

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, charmDuration)

    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        mob:charm(target)
        mob:resetEnmity(target)
    end

    skill:setMsg(msg)

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.luminous_lance.onMobWeaponSkill", function(target, mob, skill)
    local ID = require("scripts/zones/Empyreal_Paradox/IDs")
    mob:showText(mob, ID.text.SELHTEUS_TEXT + 1)

    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    mob:entityAnimationPacket("ids0")
    mob:setLocalVar("lanceTime", mob:getBattleTime())
    mob:setLocalVar("lanceOut", 0)
    target:setAnimationSub(3)

    -- Cannot be resisted
    -- intentionally not gated with "if not skill:hasMissMsg() then".  This is thematic npc vs monster
    target:addStatusEffect(xi.effect.TERROR, 0, 0, 20)

    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.lunar_cry.onMobWeaponSkill", function(target, mob, skill)
    local moon = VanadielMoonPhase()
    local buffvalue = 1

    if moon > 90 then
        buffvalue = 31
    elseif moon > 75 then
        buffvalue = 26
    elseif moon > 60 then
        buffvalue = 21
    elseif moon > 40 then
        buffvalue = 16
    elseif moon > 25 then
        buffvalue = 11
    elseif moon > 10 then
        buffvalue = 6
    end

    target:addStatusEffect(xi.effect.ACCURACY_DOWN, buffvalue, 0, 180)
    target:addStatusEffect(xi.effect.EVASION_DOWN, 32-buffvalue, 0, 180)
    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_2)
    return 0
end)

m:addOverride("xi.globals.mobskills.lunar_revolution.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.lunar_roar.onMobWeaponSkill", function(target, mob, skill)
    local effects = target:getStatusEffects()
    local num = 0

    for i, effect in pairs(effects) do
        -- check mask bit for xi.effectFlag.DISPELABLE
        if
            utils.mask.getBit(effect:getFlag(), 0) and
            effect:getType() ~= xi.effect.RERAISE and
            num < 10
        then
            target:delStatusEffect(effect:getType())
            num = num + 1
        end
    end

    skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    if num == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return num
end)

m:addOverride("xi.globals.mobskills.lunatic_voice.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.MUTE

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 60))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.lux_arrow.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.5, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.maats_bash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    local typeEffect = xi.effect.STUN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.maelstrom.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, 10, 10, 180)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WATER, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.magic_barrier.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_SHIELD, 1, 0, 60))

    return xi.effect.MAGIC_SHIELD
end)

m:addOverride("xi.globals.mobskills.magic_fruit.onMobWeaponSkill", function(target, mob, skill)
    local potency = 188 / 1024

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * potency)
end)

m:addOverride("xi.globals.mobskills.magic_hammer.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.MP, dmg)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.magic_mortar.onMobWeaponSkill", function(target, mob, skill)
    local hpdmgMod = math.floor(mob:getMaxHP() * (math.floor(0.016 * mob:getTP()) + 16) / 256)

    target:takeDamage(hpdmgMod, mob, xi.attackType.BREATH, xi.damageType.ELEMENTAL)
    return hpdmgMod
end)

m:addOverride("xi.globals.mobskills.magma_fan.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.5, 1.25, xi.magic.ele.FIRE, 600)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.magma_hoplon.onMobWeaponSkill", function(target, mob, skill)
    local typeEffectOne = xi.effect.STONESKIN
    local typeEffectTwo = xi.effect.BLAZE_SPIKES
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffectOne, 750, 0, 300))
    xi.mobskills.mobBuffMove(mob, typeEffectTwo, 20, 0, 900)
    local effect1 = mob:getStatusEffect(typeEffectOne)
    effect1:unsetFlag(xi.effectFlag.DISPELABLE)

    return typeEffectOne
end)

m:addOverride("xi.globals.mobskills.magnetite_cloud.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.WEIGHT
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 75, 0, 60)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.15, 1, xi.magic.ele.EARTH, 600)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.malediction.onMobWeaponSkill", function(target, mob, skill)
    local baseDmg = mob:getMainLvl() * 4
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, baseDmg, xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.malevolent_blessing.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.CURSE_I
    local dmgmod = 1.25
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
        xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 35, 0, 45)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.manafont.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.MANAFONT, 1, 0, 60)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.MANAFONT
end)

m:addOverride("xi.globals.mobskills.mana_screen.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.MAGIC_SHIELD

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 1, 0, 60))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.mana_storm.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.MP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.mandible_bite.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local crit = 0.2
    local attmod = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5, 2, 2.5, crit, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.mandibular_bite.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local attmod = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.CRIT_VARIES, 2, 2.5, 3, 0, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.mangle.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = .8
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.mantle_pierce.onMobWeaponSkill", function(target, mob, skill)
    local numhits = math.random(1, 3)
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    local typeEffect = xi.effect.WEIGHT

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 50, 0, 120)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.marionette_dice_2hr.onMobWeaponSkill", function(target, mob, skill)
    local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
    local ability = ID.jobTable[target:getMainJob()].twoHour

    if ability > 0 then
        mob:timer(5000, function(mobArg)
            target:useMobAbility(ability)
            mobArg:messageText(mobArg, ID.text.NOT_YOUR_LUCKY_DAY)
        end)
    end

    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.marionette_dice_attk.onMobWeaponSkill", function(target, mob, skill)
    local power = 15
    local duration = 25
    local typeEffect = xi.effect.ATTACK_BOOST

    mob:timer(5000, function(mobArg)
        target:addStatusEffect(typeEffect, power, 0, duration)
    end)

    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.marionette_dice_def.onMobWeaponSkill", function(target, mob, skill)
    local power = 15
    local duration = 25
    local typeEffect = xi.effect.DEFENSE_BOOST

    mob:timer(5000, function(mobArg)
        target:addStatusEffect(typeEffect, power, 0, duration)
    end)

    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.marionette_dice_hp.onMobWeaponSkill", function(target, mob, skill)
    local amount = 150

    mob:timer(5000, function(mobArg)
        target:addHP(amount)
        target:wakeUp()
    end)

    skill:setMsg(xi.msg.basic.SKILL_RECOVERS_HP)
    return amount
end)

m:addOverride("xi.globals.mobskills.marionette_dice_hp_mp.onMobWeaponSkill", function(target, mob, skill)
    local amount = 150

    mob:timer(5000, function(mobArg)
        target:addHP(amount)
        target:addMP(amount)
        target:wakeUp()
    end)

    skill:setMsg(xi.msg.basic.RECOVERS_HP_AND_MP)
    return amount
end)

m:addOverride("xi.globals.mobskills.marionette_dice_ja_reset.onMobWeaponSkill", function(target, mob, skill)
    local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
    mob:timer(5000, function(mobArg)
        mobArg:showText(mobArg, ID.text.NOT_HOW)
        target:resetRecasts()
    end)

    skill:setMsg(xi.msg.basic.ABILITIES_RECHARGED)
    return 0
end)

m:addOverride("xi.globals.mobskills.marionette_dice_mp.onMobWeaponSkill", function(target, mob, skill)
    local amount = 150

    mob:timer(5000, function(mobArg)
        target:addMP(amount)
    end)

    skill:setMsg(xi.msg.basic.SKILL_RECOVERS_MP)
    return amount
end)

m:addOverride("xi.globals.mobskills.marionette_dice_special.onMobWeaponSkill", function(target, mob, skill)
    local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
    local ability = ID.jobTable[target:getMainJob()].ability
    local spells = ID.jobTable[target:getMainJob()].spellListID

    -- Fantoccini can use abilities and spells
    -- TODO: Fix mobMod SPELL_LIST
    mob:timer(5000, function(mobArg)
        mobArg:messageText(mobArg, ID.text.GO_GO)

        if ability > 0 and spells > 0 then
            if math.random() > 0.5 then
                target:useMobAbility(ability)
            else
                target:setSpellList(spells)
            end
        elseif ability > 0 and spells == 0 then
            target:useMobAbility(ability)
        else
            target:setSpellList(spells)
        end

        mobArg:timer(1000, function(mobArg1)
            target:setSpellList(0)
        end)
    end)

    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.marionette_dice_tp.onMobWeaponSkill", function(target, mob, skill)
    local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
    -- Force Fantoccini to use an ability
    local skillList = ID.jobTable[target:getLocalVar("job")].skillList
    target:setTP(3000)

    mob:timer(5000, function(mobArg)
        mobArg:showText(mobArg, ID.text.HA_HA)
        target:setMobMod(xi.mobMod.SKILL_LIST, skillList)

        mobArg:timer(1000, function(mobArg1)
            target:setMobMod(xi.mobMod.SKILL_LIST, 0)
        end)
    end)

    skill:setMsg(xi.msg.basic.TP_INCREASE)
    return target:getTP()
end)

m:addOverride("xi.globals.mobskills.marionette_dice_tp_player.onMobWeaponSkill", function(target, mob, skill)
    mob:timer(5000, function(mobArg)
        target:setTP(target:getTP() + math.random(50, 1000))
    end)

    return target:getTP()
end)

m:addOverride("xi.globals.mobskills.marrow_drain.onMobWeaponSkill", function(target, mob, skill)
    local mpDrain = 5 + mob:getMainLvl() * 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mpDrain, xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.MP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.material_fend.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.EVASION_BOOST
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 40, 0, 120))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.max_potion.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.msg.basic.SELF_HEAL)
    return xi.mobskills.mobHealMove(target, 500)
end)

m:addOverride("xi.globals.mobskills.meditate.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.MEDITATE
    local duration = 15
    local power = 20

    mob:addStatusEffectEx(typeEffect, 0, power, 3, duration)
end)

m:addOverride("xi.globals.mobskills.medusa_javelin.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    local typeEffect = xi.effect.PETRIFICATION

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 60)

    return dmg
end)

m:addOverride("xi.globals.mobskills.megaflare.onMobWeaponSkill", function(target, mob, skill)
    local megaFlareCount = mob:getLocalVar("megaFlareCount")
    mob:setLocalVar("megaFlareCount", megaFlareCount + 1)
    mob:setLocalVar("FlareWait", 0) -- reset the variables for Megaflare.
    mob:setLocalVar("tauntShown", 0)
    mob:setMobAbilityEnabled(true) -- re-enable the other actions on success
    mob:setMagicCastingEnabled(true)
    mob:setAutoAttackEnabled(true)
    if bit.band(mob:getBehaviour(), xi.behavior.NO_TURN) == 0 then -- re-enable noturn
        mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    end

    local dStatMult = 1.5
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, 10 * mob:getMainLvl(), xi.magic.ele.FIRE, nil, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, nil, nil, nil, dStatMult)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.megalith_throw.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    local typeEffect = xi.effect.SLOW

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1000, 0, 120)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.mega_holy.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 3
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.meikyo_shisui.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.MEIKYO_SHISUI, 1, 0, 30)

    skill:setMsg(xi.msg.basic.USES)

    mob:addTP(3000)

    return xi.effect.MEIKYO_SHISUI
end)

m:addOverride("xi.globals.mobskills.meltdown.onMobWeaponSkill", function(target, mob, skill)
    local damage = skill:getMobHP() / 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.LIGHT, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:setHP(0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.memento_mori.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_ATK_BOOST, 25, 0, 30))

    return xi.effect.MAGIC_ATK_BOOST
end)

m:addOverride("xi.globals.mobskills.memory_of_dark.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.mercurial_strike.onMobWeaponSkill", function(target, mob, skill)
    local _, dmg = utils.randomEntry({ 111, 222, 333, 444, 555, 666, 777, 888, 999, 1111 })
    mob:setLocalVar("MERCURIAL_STRIKE_DAMAGE", dmg)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.mercy_stroke.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.metallic_body.onMobWeaponSkill", function(target, mob, skill)
    local power = 25 -- ffxiclopedia claims its always 25 on the crabs page. Tested on wootzshell in mt zhayolm..
    --[[
    if mob:isNM() then
        power = ???  Betting NMs aren't 25 but I don't have data..
    end
    ]]
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.STONESKIN, power, 0, 300))
    return xi.effect.STONESKIN
end)

m:addOverride("xi.globals.mobskills.metatron_torment.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local duration = 60
    local typeEffect = xi.effect.DEFENSE_DOWN
    local power = 19

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, power, 0, duration)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.meteor.onMobWeaponSkill", function(target, mob, skill)
    local damage = 14 + mob:getMainLvl() * 30
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.NONE, 1, xi.mobskills.magicalTpBonus.PDIF_BONUS, 0, 0, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.NONE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.meteorite.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.meteor_strike.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.methane_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 1, xi.magic.ele.FIRE, 400)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.miasma.onMobWeaponSkill", function(target, mob, skill)
    -- local duration = 180
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, math.min(1, mob:getMainLvl() / 3), 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 3, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, math.min(1, mob:getMainLvl() / 3), 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 128, 3, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 3, 60)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.microquake.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, math.random(2, 3))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.mighty_snort.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WIND, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 4.5, 4.75, 5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    mob:resetEnmity(target)

    return dmg
end)

m:addOverride("xi.globals.mobskills.mighty_strikes.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.MIGHTY_STRIKES, 1, 0, 45)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.MIGHTY_STRIKES
end)

m:addOverride("xi.globals.mobskills.mijin_gakure.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local hpmod = skill:getMobHPP() / 100
    local basePower = (mob:getFamily() == 335) and 4 or 6 -- Maat has a weaker (4) Mijin than usual (6)
    local power = hpmod * 10 + basePower
    local baseDmg = mob:getWeaponDmg() * power
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, baseDmg, xi.magic.ele.NONE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)

    return dmg
end)

m:addOverride("xi.globals.mobskills.mind_blast.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 20, 0, 180)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 6, xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.mind_break.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.MAX_MP_DOWN, 42, 0, 120))

    return xi.effect.MAX_MP_DOWN
end)

m:addOverride("xi.globals.mobskills.mind_drain.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MND_DOWN, 14, 10, 180))

    return xi.effect.MND_DOWN
end)

m:addOverride("xi.globals.mobskills.mind_purge.onMobWeaponSkill", function(target, mob, skill)
    local dispel =  target:dispelAllStatusEffect(bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.FOOD))
    local msg -- to be set later

    if dispel == 0 then
        msg = xi.msg.basic.SKILL_NO_EFFECT -- no effect
    else
        msg = xi.msg.basic.DISAPPEAR_NUM
    end

    skill:setMsg(msg)

    return dispel
end)

m:addOverride("xi.globals.mobskills.mind_wall.onMobWeaponSkill", function(target, mob, skill)
    local magicType =
    {
        xi.mod.FIRE_ABSORB,
        xi.mod.ICE_ABSORB,
        xi.mod.WIND_ABSORB,
        xi.mod.EARTH_ABSORB,
        xi.mod.LTNG_ABSORB,
        xi.mod.WATER_ABSORB,
        xi.mod.LIGHT_ABSORB,
        xi.mod.DARK_ABSORB,
    }

    -- Temporary fix until MAGIC_ABSORB mod works
    for i = 1, 8 do
        mob:setMod(magicType[i], 1000)
    end

    mob:timer(1000 * math.random(28, 32), function(mobArg)
        for i = 1, 8 do
            mobArg:delMod(magicType[i], 1000)
        end
    end)

    skill:setMsg(xi.msg.basic.NONE)

    return 0
end)

m:addOverride("xi.globals.mobskills.mine_blast.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 20

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.mirage.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.EVASION_BOOST, 40, 0, 180))

    return xi.effect.EVASION_BOOST
end)

m:addOverride("xi.globals.mobskills.mistral_axe.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.mix_antidote.onMobWeaponSkill", function(target, mob, skill)
    target:delStatusEffect(xi.effect.POISON)
    return 0
end)

m:addOverride("xi.globals.mobskills.mix_dark_potion.onMobWeaponSkill", function(target, mob, skill)
    return 666
end)

m:addOverride("xi.globals.mobskills.mix_dragon_shield.onMobWeaponSkill", function(target, mob, skill)
    if not target:hasStatusEffect(xi.effect.MAGIC_DEF_BOOST) then
        target:addStatusEffect(xi.effect.MAGIC_DEF_BOOST, 10, 0, 60)
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.mix_dry_ether_concoction.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.msg.basic.SKILL_RECOVERS_MP)
    target:addMP(160)
    return 0
end)

m:addOverride("xi.globals.mobskills.mix_elemental_power.onMobWeaponSkill", function(target, mob, skill)
    if not target:hasStatusEffect(xi.effect.MAGIC_ATK_BOOST) then
        target:addStatusEffect(xi.effect.MAGIC_ATK_BOOST, 20, 0, 60)
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.mix_guard_drink.onMobWeaponSkill", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mix_life_water.onMobWeaponSkill", function(target, mob, skill)
    if not target:hasStatusEffect(xi.effect.REGEN) then
        target:addStatusEffect(xi.effect.REGEN, 20, 3, 60)
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.mix_max_potion.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.msg.basic.SELF_HEAL)
    return xi.mobskills.mobHealMove(target, 700)
end)

m:addOverride("xi.globals.mobskills.mix_panacea-1.onMobWeaponSkill", function(target, mob, skill)
    local statii =
    {
        xi.effect.PARALYSIS,
        xi.effect.BIND,
        xi.effect.WEIGHT,
        xi.effect.ADDLE,
        xi.effect.BURN,
        xi.effect.FROST,
        xi.effect.CHOKE,
        xi.effect.RASP,
        xi.effect.SHOCK,
        xi.effect.DROWN,
        xi.effect.DIA,
        xi.effect.BIO,
        xi.effect.STR_DOWN,
        xi.effect.DEX_DOWN,
        xi.effect.VIT_DOWN,
        xi.effect.AGI_DOWN,
        xi.effect.INT_DOWN,
        xi.effect.MND_DOWN,
        xi.effect.CHR_DOWN,
        xi.effect.MAX_HP_DOWN,
        xi.effect.MAX_MP_DOWN,
        xi.effect.ATTACK_DOWN,
        xi.effect.EVASION_DOWN,
        xi.effect.DEFENSE_DOWN,
        xi.effect.MAGIC_DEF_DOWN,
        xi.effect.INHIBIT_TP,
        xi.effect.MAGIC_ACC_DOWN,
        xi.effect.MAGIC_ATK_DOWN,
    }
    for _, effect in pairs(statii) do
        target:delStatusEffect(effect)
    end

    skill:setMsg(xi.msg.basic.SKILL_ERASE)
    return 0
end)

m:addOverride("xi.globals.mobskills.mix_samsons_strength.onMobWeaponSkill", function(target, mob, skill)
    local statii =
    {
        xi.effect.STR_BOOST,
        xi.effect.DEX_BOOST,
        xi.effect.VIT_BOOST,
        xi.effect.AGI_BOOST,
        xi.effect.INT_BOOST,
        xi.effect.MND_BOOST,
        xi.effect.CHR_BOOST,
    }
    for _, effect in pairs(statii) do
        if not target:hasStatusEffect(effect) then
            target:addStatusEffect(effect, 10, 0, 60)
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.moblin_1343.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(0)
    return 0
end)

m:addOverride("xi.globals.mobskills.moblin_1344.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(0)
    return 0
end)

m:addOverride("xi.globals.mobskills.moblin_1345.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(0)
    return 0
end)

m:addOverride("xi.globals.mobskills.molluscous_mutation.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_BOOST
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 75, 0, 60))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.molting_burst.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.moonlight.onMobWeaponSkill", function(target, mob, skill)
    local mpRecoverAmt = mob:getWeaponDmg() * 1.25
    local maxmp = target:getMaxMP()
    local currmp = target:getMP()
    if mpRecoverAmt + currmp > maxmp then
            mpRecoverAmt = maxmp - currmp
        end
    skill:setMsg(xi.msg.basic.RECOVERS_MP, 0, mpRecoverAmt)
end)

m:addOverride("xi.globals.mobskills.moonlit_charge.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 1

    local totaldamage = 0
    local damage = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 0, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    totaldamage = xi.mobskills.mobFinalAdjustments(damage.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, numhits)

    if not skill:hasMissMsg() then
        target:addStatusEffect(xi.effect.BLINDNESS, 20, 0, 30)
        target:takeDamage(totaldamage, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return totaldamage
end)

m:addOverride("xi.globals.mobskills.mortal_ray.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.DOOM

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 10, 3, 30))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.mortal_revolution.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.mountain_buster.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    local typeEffect = xi.effect.BIND

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.mow.onMobWeaponSkill", function(target, mob, skill)
    local numhits = math.random(2, 3)
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local power = mob:getMainLvl() / 4 + 3

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, power, 3, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.mp_absorption.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() * 1.5, xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.MP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.mp_drainkiss.onMobWeaponSkill", function(target, mob, skill)
    local damage = 1.5 + mob:getStat(xi.mod.INT) * 1.5
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.MP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.mucus_spread.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.SLOW

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 2500, 0, math.random(30, 90)))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.murk.onMobWeaponSkill", function(target, mob, skill)
    local slowed = false
    local weight = false
    local typeEffect

    if not target:hasStatusEffect(xi.effect.HASTE) then
        slowed = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 8500, 0, math.random(45, 90))
    end

    weight = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 44, 0, 60)

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)

    -- display slow first, else weight
    if slowed == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.SLOW
    elseif weight == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.WEIGHT
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.mysterious_light.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.WEIGHT

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 50, 0, 60)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3.5, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.namas_arrow.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.75, 2.75, 2.75)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.necrobane.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_I, 1, 0, 60)

    return dmg
end)

m:addOverride("xi.globals.mobskills.necropurge.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 10
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_I, 1, 0, 60)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.needleshot.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3)

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.negative_whirl.onMobWeaponSkill", function(target, mob, skill)
    local damage = mob:getMainLvl() * 2
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        damage = mob:getMainLvl() * 3
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.WIND, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 8500, 0, 60)

    return dmg
end)

m:addOverride("xi.globals.mobskills.nepenthean_hum.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.AMNESIA

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 60))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.nerve_gas.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_I, 50, 0, 420))
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 20, 3, 60)
    return xi.effect.CURSE_I
end)

m:addOverride("xi.globals.mobskills.netherspikes.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local crit = 0.2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2, crit)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 1, 0, 30)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.nether_blast.onMobWeaponSkill", function(target, mob, skill)
    local multiplier = 5
    -- Diabolos Dynamis Tavnazia tosses nether blast for ~1k
    if mob:getZoneID() == xi.zone.DYNAMIS_TAVNAZIA then
        multiplier = 10
    end

    local dmg = mob:getMainLvl() * multiplier + 10 -- http://wiki.ffo.jp/html/4045.html
    local dmgmod = 1
    local ignoreres = true

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, dmg, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, ignoreres)

    dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.nether_tempest.onMobWeaponSkill", function(target, mob, skill)
    -- Diabolos Dynamis Tavnazia tosses nether tempest for a reported 661 dmg
    -- Diabolos are lvl 85.   A multiplier of 7.77 hits 661
    local multiplier = 7.77
    local dmg = mob:getMainLvl() * multiplier -- http://wiki.ffo.jp/html/4045.html
    local dmgmod = 1
    local ignoreres = true

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, dmg, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, ignoreres)

    dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.nightmare.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.SLEEP_I
    local power = 20
    local tick = 3
    local duration = 60     -- Unresisted, 20 ticks at 21 hp/tick = 420hp per target
    local subEffect = xi.effect.BIO
    local subPower = 21 -- 21 HP/tick drain

    -- Adjust parameters for CoP Diabolos.  This is an estimate, will need some battletesting
    local copDiabolos = 16818177
    if mob:getID() >= copDiabolos and mob:getID() <= copDiabolos + 14 then  -- three possible instances of Diabolos
        power = 10
        duration = 30
        subPower = 14       -- Unresisted, 10 ticks at 14 hp/tick = 140hp per target
    end

    if mob:getZoneID() == xi.zone.DYNAMIS_TAVNAZIA then -- Diabolos Dynamis Tavnazia - 35/tick, at least 60s
        duration = 60
        subPower = 35
    end

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, tick, duration, subEffect, subPower))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.nightmare_scythe.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:addStatusEffect(xi.effect.BLINDNESS, 20, 0, 120)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.nihility_song.onMobWeaponSkill", function(target, mob, skill)
    local dispel =  target:dispelStatusEffect(bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.FOOD))

    if dispel == xi.effect.NONE then
        -- no effect
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
    end

    return dispel
end)

m:addOverride("xi.globals.mobskills.nimble_snap.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.noctoshield.onMobWeaponSkill", function(target, mob, skill)
    local power = 13
    -- Diabolos Dynamis Tavnazia
    if mob:getZoneID() == xi.zone.DYNAMIS_TAVNAZIA then
        power = 35
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.PHALANX, power, 0, 120))
    return xi.effect.PHALANX
end)

m:addOverride("xi.globals.mobskills.nocturnal_combustion.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local bombTossHPP = skill:getMobHPP() / 100

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 20 * bombTossHPP, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    mob:setHP(0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.noisome_powder.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.ATTACK_DOWN
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 40, 0, 120))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.nuclear_waste.onMobWeaponSkill", function(target, mob, skill)
    mob:setLocalVar("nuclearWaste", 1)
    local typeEffect = xi.effect.ELEMENTALRES_DOWN
    local resist = xi.mobskills.applyPlayerResistance(mob, typeEffect, target, mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT), 0, 1)
    if resist >= 0.25 then
        target:addStatusEffectEx(typeEffect, 0, 50, 0, 60)
        skill:setMsg(xi.msg.basic.NONE)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.nullifying_dropkick.onMobWeaponSkill", function(target, mob, skill)
    local ID = require("scripts/zones/Empyreal_Paradox/IDs")
    mob:showText(mob, ID.text.PRISHE_TEXT + 5)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    target:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
    target:delStatusEffect(xi.effect.MAGIC_SHIELD)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.numbing_breath.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 20, 0, math.random(120, 180))

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 1, xi.magic.ele.ICE, 500)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.ICE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.numbing_glare.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 25, 0, 180))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.numbing_noise.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 5))

    return xi.effect.STUN
end)

m:addOverride("xi.globals.mobskills.numbshroom.onMobWeaponSkill", function(target, mob, skill)
    mob:setAnimationSub(2)

    local numhits = 1
    local accmod = 1
    local crit = 0.05
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5, 1.75, 2, crit)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PARALYSIS, 25, 0, 180)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.obfuscate.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BLINDNESS

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 20, 0, 120))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.oblivion_smash.onMobWeaponSkill", function(target, mob, skill)
    local dmg = 0

    if mob:getHPP() <= 25 then
        dmg = target:getHP()
        target:setHP(0)
        return dmg
    end

    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BLINDNESS, 20, 0, 120)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SILENCE, 0, 0, 120)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 0, 0, 120)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.WEIGHT, 50, 0, 120)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.occultation.onMobWeaponSkill", function(target, mob, skill)
    local base = math.random(10, 25)

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BLINK, base, 0, 120))
    return xi.effect.BLINK
end)

m:addOverride("xi.globals.mobskills.ochre_blast.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 5, 5, 5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.ochre_blast_alt.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    skill:setMsg(xi.msg.basic.HIT_DMG)
    return dmg
end)

m:addOverride("xi.globals.mobskills.oisoya.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 2, 2.75, 2.75, 2.75)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.omega_javelin.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PETRIFICATION, 1, 0, 45)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        mob:resetEnmity(target)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.one-ilm_punch.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.one_inch_punch.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.onrush.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.onslaught.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local duration = 60
    local typeEffect = xi.effect.ACCURACY_DOWN
    local power = 30

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, power, 0, duration)

    if not skill:hasMissMsg() then
        -- About 300-400 to a DD.
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.optic_induration.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PETRIFICATION

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 60)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 15, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    mob:resetEnmity(target)

    return dmg
end)

m:addOverride("xi.globals.mobskills.optic_induration_charge.onMobWeaponSkill", function(target, mob, skill)
    local chargeCount = mob:getLocalVar("chargeCount")
    if chargeCount == 0 then
        mob:setAutoAttackEnabled(false)
        mob:setLocalVar("chargeCount", 1)
        mob:setLocalVar("chargeTotal", math.random(3, 5))
        mob:timer(4000, function(mobArg)
            mob:useMobAbility(1464)
        end)
    else
        chargeCount = chargeCount + 1
        local chargeTotal = mob:getLocalVar("chargeTotal")
        if chargeCount == chargeTotal then
            mob:timer(4000, function(mobArg)
                mob:useMobAbility(1465, mob:getTarget())
            end)

            mob:timer(4500, function(mobArg)
                mob:setAutoAttackEnabled(true)
                mob:setLocalVar("chargeCount", 0)
                mob:setLocalVar("chargeTotal", 0)
            end)
        else
            mob:setLocalVar("chargeCount", chargeCount)
            mob:timer(4000, function(mobArg)
                mob:useMobAbility(1464)
            end)
        end
    end

    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.ore_toss.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    if skill:getID() == 1123 then
        -- Skill ID is Ore Toss used by Dynamis Quadavs as a ranged attack.
        -- against a 298 defense character - dmgmod of 1 produces hits of low 100s to high 100s by Masons in Bastok.
        dmgmod = 1
    end

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.RANGED, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.osmosis.onMobWeaponSkill", function(target, mob, skill)
    -- local effect = mob:stealStatusEffect(target)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.painful_whip.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local crit = 0.33
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.CRIT_VARIES, 3, 3.25, 3.5, crit)

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.palsynyxis.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.5, 1.75, 2.0)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PARALYSIS, 25, 0, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.palsy_pollen.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 30, 0, 180))

    return xi.effect.PARALYSIS
end)

m:addOverride("xi.globals.mobskills.pandemic_nip.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.panzerfaust.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.panzerschreck.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local crit = 0.2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.RANGED, 2, 2.5, 3, crit)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.paralysis_shower.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 20, 0, 120))

    return xi.effect.PARALYSIS
end)

m:addOverride("xi.globals.mobskills.paralyzing_microtube.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 20, 0, 60)

    local dmgmod = 2.45
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.magic.ele.NONE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.NONE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.parry.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_BOOST
    local power = 25 -- 25% Defense Boost

    if mob:isInDynamis() then
        typeEffect = xi.effect.EVASION_BOOST
        power      = mob:getMod(xi.mod.EVA) * 0.25 -- 25% Evasion Boost in Dyna
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, 60))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.particle_shield.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_BOOST

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 50, 0, 300))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.peacebreaker.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    -- TODO: This should be Increases Magic Damage Taken, but this was faster/easier
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.MAGIC_DEF_DOWN, 50, 0, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.pecking_flurry.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 4
    local accmod = 1
    local dmgmod = 0.9
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.penta_thrust.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 1, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.penumbral_impact.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.percussive_foin.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, math.random(2, 3))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.perdition.onMobWeaponSkill", function(target, mob, skill)
    if
        target:isUndead() or
        target:hasStatusEffect(xi.effect.MAGIC_SHIELD) or
        -- Todo: DeathRes has no place in the resistance functions so far..
        math.random(1, 100) <= target:getMod(xi.mod.DEATHRES)
    then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end

    skill:setMsg(xi.msg.basic.FALL_TO_GROUND)
    target:setHP(0)

    return 0
end)

m:addOverride("xi.globals.mobskills.perfect_defense.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.PERFECT_DEFENSE, 1, 0, skill:getParam())

    skill:setMsg(xi.msg.basic.USES)
    return xi.effect.PERFECT_DEFENSE
end)

m:addOverride("xi.globals.mobskills.perfect_dodge.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.PERFECT_DODGE, 1, 0, 30)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.PERFECT_DODGE
end)

m:addOverride("xi.globals.mobskills.pestilent_penance.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PLAGUE

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 10, 0, 120)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.petal_pirouette.onMobWeaponSkill", function(target, mob, skill)
    local tpReduced = 0
    target:setTP(tpReduced)

    skill:setMsg(xi.msg.basic.TP_REDUCED)

    return tpReduced
end)

m:addOverride("xi.globals.mobskills.petribreath.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PETRIFICATION, 1, 0, math.random(60, 120)))

    return xi.effect.PETRIFICATION
end)

m:addOverride("xi.globals.mobskills.petrifaction.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PETRIFICATION
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 1, 0, 25))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.petrifactive_breath.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PETRIFICATION

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, math.random(15, 45)))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.petro_eyes.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PETRIFICATION
    mob:lookAt(target:getPos())

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 1, 0, 60))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.petro_gaze.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.PETRIFICATION, 1, 0, math.random(15, 45)))

    return xi.effect.PETRIFICATION
end)

m:addOverride("xi.globals.mobskills.pet_flame_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target,  0.15, 0.25, xi.magic.ele.FIRE, 125)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.pet_frost_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.15, 0.25, xi.magic.ele.ICE, 125)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.ICE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.pet_gust_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.15, 0.25, xi.magic.ele.WIND, 125)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.pet_hydro_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.15, 0.25, xi.magic.ele.WATER, 125)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.pet_lightning_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.15, 0.25, xi.magic.ele.LIGHTNING, 125)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.pet_sand_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.15, 0.25, xi.magic.ele.EARTH, 125)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.phantasmal_dance.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BIND
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 30)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.phase_shift_1.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.phase_shift_2.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 3.5, 3.5, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 15)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.phase_shift_3.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 4, 4, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 15)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 1, 0, 30)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    mob:setUnkillable(false)
    return dmg
end)

m:addOverride("xi.globals.mobskills.photosynthesis.onMobWeaponSkill", function(target, mob, skill)
    local power = math.min(1, math.floor(mob:getMainLvl() / 10))
    local duration = 120

    -- Sabotender have longer duration
    if mob:getFamily() ~= 178 then
        duration = 180
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.REGEN, power, 3, duration))

    return xi.effect.REGEN
end)

m:addOverride("xi.globals.mobskills.piercing_arrow.onMobWeaponSkill", function(target, mob, skill)
    -- TODO: ignore DEF based on TP
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.pile_pitch.onMobWeaponSkill", function(target, mob, skill)
    local currentHP = target:getHP()
    local damage = currentHP * .90
    local typeEffect = xi.effect.BIND
    local dmg = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.NONE)
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 30)
    mob:resetEnmity(target)
    return dmg
end)

m:addOverride("xi.globals.mobskills.pinecone_bomb.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = 0
    local dmg = 0

    if mob:getPool() == 671 or mob:getPool() == 1346 then -- Cemetery Cherry and leafless Jidra (This probably just need base wep damage increase)
        dmgmod = 2
    end

    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 2, 2.5, 3)
        dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

        if not skill:hasMissMsg() then
            target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
        end

    else
        info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 2, 2.5, 3)
        dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

        if not skill:hasMissMsg() then
            target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
        end
    end

    if mob:getPool() ~= 671 and mob:getPool() ~= 1346 then
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SLEEP_I, 1, 0, 60)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.pit_ambush.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 10
    local dmgmod = 3
    if skill:getID() == 1844 then -- Nightmare Antlion - Reported to almost one shot paladins
        dmgmod = 10
    end

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    -- These are here as it doesn't look right otherwise
    mob:hideName(false)
    mob:setUntargetable(false)
    mob:setAnimationSub(1)
    mob:setLocalVar("AMBUSH", 1) -- Used it for the last time!

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.plague_breath.onMobWeaponSkill", function(target, mob, skill)
    local power = math.max(1, mob:getMainLvl() / 10)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 3, 60)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.0625, 1, xi.magic.ele.WATER, 500)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.plague_swipe.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIO, 7, 3, 60)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PLAGUE, 5, 3, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.plasma_charge.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.SHOCK_SPIKES
    local randy = math.random(15, 30)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, randy, 0, 180))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.pleiades_ray.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 7, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    local duration = 120
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 40, 3, duration)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 40, 3, duration)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 10, 3, duration)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 3, duration)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, duration)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, duration)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 0, duration)

    return dmg
end)

m:addOverride("xi.globals.mobskills.pl_body_slam.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.pl_chaos_blade.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)

    -- curse LAST so you don't die
    local typeEffect = xi.effect.CURSE_I
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 25, 0, 60)

    return dmg
end)

m:addOverride("xi.globals.mobskills.pl_heavy_stomp.onMobWeaponSkill", function(target, mob, skill)
    local numhits = math.random(2, 3)
    local accmod = 1
    local dmgmod = .7
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)
    local typeEffect = xi.effect.PARALYSIS

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 15, 0, 360)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.pl_hellstorm.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.5
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.pl_petro_eyes.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PETRIFICATION

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 1, 0, 30))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.pl_vulcanian_impact.onMobWeaponSkill", function(target, mob, skill)
    local targetcurrentHP = target:getHP()
    local targetmaxHP = target:getMaxHP()
    local hpset = targetmaxHP * 0.10
    local typeEffect = xi.effect.BIND
    local dmg = 0
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 30)

    if targetcurrentHP > hpset then
        dmg = targetcurrentHP - hpset
    end

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.pod_ejection.onMobWeaponSkill", function(target, mob, skill)
    mob:timer(3000, function(mobArg)
        if mob:isAlive() then
            local gunpod = GetMobByID(mob:getID() + 1)
            gunpod:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos(), mob:getRotPos())
            gunpod:spawn()
            gunpod:updateEnmity(utils.randomEntry(mob:getBattlefield():getPlayers()))
        end
    end)

    skill:setMsg(0)
    return 0
end)

m:addOverride("xi.globals.mobskills.poison_breath.onMobWeaponSkill", function(target, mob, skill)
    local power = math.ceil(mob:getMainLvl() / 5)
    mob:lookAt(target:getPos())

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 3, 60)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 1, xi.magic.ele.WATER, 400)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.poison_nails.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, 1, 3, 300)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.poison_pick.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    local power = 5

    if mob:getMainLvl() >= 56 then
        power = power + (mob:getMainLvl() - 55)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, power, 3, 180)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.poison_sting.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local attmod = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2, 0, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, 1, 3, 210)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.polar_blast.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.01, 0.1, xi.magic.ele.ICE, 700)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 15, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.ICE)

    if
        mob:getFamily() == 313 and
        bit.band(mob:getBehaviour(), xi.behavior.NO_TURN) == 0 and
        mob:getAnimationSub() == 1
    then
        -- re-enable no turn if third head is dead (Tinnin), else it's re-enabled after the upcoming Pyric Blast
        mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.polar_bulwark.onMobWeaponSkill", function(target, mob, skill)
    -- addEx to pervent dispel
    mob:addStatusEffectEx(xi.effect.MAGIC_SHIELD, 0, 1, 0, 45)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    if mob:getFamily() == 313 then -- Tinnin follows this up immediately with Nerve Gas
        mob:useMobAbility(1580)
    end

    return xi.effect.MAGIC_SHIELD
end)

m:addOverride("xi.globals.mobskills.pollen.onMobWeaponSkill", function(target, mob, skill)
    local potency = 12

    if mob:getPool() == 385 then
        potency = 25
        potency = potency - math.random(0, 5)
    end

    potency = potency - math.random(0, potency / 4)

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    if mob:getPool() == 979 then -- Demonic Tiphia pollen recovers 3k+ HP
        return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * potency / 30)
    elseif mob:getPool() == 385 then
        return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * potency / 100)
    else
        return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * (147 / 1024))
    end
end)

m:addOverride("xi.globals.mobskills.pounce.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.power_attack.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local attmod = 2 -- 100% attack boost
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2, 0, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.power_attack_beetle.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    -- In testing lvl 60 blu vs lvl 25-28 beetles (Diving Beetles) - 50 out of 50 power attacks hit for similar damage as a critical hit
    local crit = 1 -- mobPhysicalMove does not actually caclulate CRIT_VARIES, crit param required
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 1.5, 2, crit)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.power_attack_weapon.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.power_slash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.predator_claws.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.ACC_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.primal_drill.onMobWeaponSkill", function(target, mob, skill)
    local numhits = math.random(2, 3)
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    local typeEffect = xi.effect.BIND
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, math.random(45, 90))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.prishe_item_1.onMobWeaponSkill", function(target, mob, skill)
    local ID = require("scripts/zones/Empyreal_Paradox/IDs")
    skill:setMsg(xi.msg.basic.NONE)
    if mob:getTarget() and mob:getTarget():getFamily() == 478 then
        -- using Ambrosia!
        target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4511)
        mob:messageText(mob, ID.text.PRISHE_TEXT + 8, false)
    else
        -- using Daedalus Wing!
        mob:addTP(3000)
        mob:messageText(mob, ID.text.PRISHE_TEXT + 9, false)
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.prishe_item_2.onMobWeaponSkill", function(target, mob, skill)
    local ID = require("scripts/zones/Empyreal_Paradox/IDs")
    skill:setMsg(xi.msg.basic.NONE)
    if
        mob:hasStatusEffect(xi.effect.PLAGUE) or
        mob:hasStatusEffect(xi.effect.CURSE_I) or
        mob:hasStatusEffect(xi.effect.MUTE)
    then
        -- use Remedy!
        mob:messageText(mob, ID.text.PRISHE_TEXT + 12, false)
        mob:delStatusEffect(xi.effect.PLAGUE)
        mob:delStatusEffect(xi.effect.CURSE_I)
        mob:delStatusEffect(xi.effect.MUTE)
    elseif math.random() < 0.5 then
        -- Carnal Incense!
        mob:messageText(mob, ID.text.PRISHE_TEXT + 10, false)
        mob:addStatusEffect(xi.effect.PHYSICAL_SHIELD, 1, 0, 30)
    else
        -- Spiritual Incense!
        mob:messageText(mob, ID.text.PRISHE_TEXT + 11, false)
        mob:addStatusEffect(xi.effect.MAGIC_SHIELD, 1, 0, 30)
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.proboscis_shower.onMobWeaponSkill", function(target, mob, skill)
    local potency = skill:getParam()

    if potency == 0 then
        potency = 13
    end

    potency = potency - math.random(0, potency / 4)

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * potency / 100)
end)

m:addOverride("xi.globals.mobskills.prodigious_spike.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 3, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded * math.random(2, 3))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.promyvion_barrier.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_BOOST
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 20, 0, 180))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.promyvion_brume.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 9, 3, 180)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WATER, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.provoke.onMobWeaponSkill", function(target, mob, skill)
    target:addEnmity(mob, 1, 1800)
    skill:setMsg(xi.msg.basic.NONE)
end)

m:addOverride("xi.globals.mobskills.psychomancy.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 1.7, 1.7, 1.7)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.MP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.punch.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.purulent_ooze.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local baseDamage = mob:getWeaponDmg() * 3
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, baseDamage, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIO, 5, 3, 120, 0, 10)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_HP_DOWN, 10, 0, 120)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.pw_calcifying_deluge.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded * math.random(2, 3))
    local typeEffect = xi.effect.PETRIFICATION

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 30)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.pw_gorgon_dance.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PETRIFICATION
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 1, 0, math.random(60, 180)))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.pw_groundburst.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.pw_pinning_shot.onMobWeaponSkill", function(target, mob, skill)
    local numhits = math.random(2, 3)
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)
    local typeEffect = xi.effect.BIND

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 30)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.pw_shadow_thrust.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.pyric_blast.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.01, 0.1, xi.magic.ele.FIRE, 700)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 3, 60)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.FIRE)

    if
        mob:getFamily() == 313 and
        bit.band(mob:getBehaviour(), xi.behavior.NO_TURN) == 0
    then
        -- re-enable no turn if all three heads are up
        mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.pyric_bulwark.onMobWeaponSkill", function(target, mob, skill)
    -- addEx to pervent dispel
    mob:addStatusEffectEx(xi.effect.PHYSICAL_SHIELD, 0, 1, 0, 45)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    if mob:getFamily() == 313 then -- Tinnin follows this up immediately with Nerve Gas
        mob:useMobAbility(1580)
    end

    return xi.effect.PHYSICAL_SHIELD
end)

m:addOverride("xi.globals.mobskills.quadrastrike.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 4
    local attmod = 1.25
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 4, 4.5, 5, 0, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.quadratic_continuum.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 4
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 4, 4, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.quake_stomp.onMobWeaponSkill", function(target, mob, skill)
    local power = 1
    local duration = 60

    local typeEffect = xi.effect.BOOST

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, duration))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.queasyshroom.onMobWeaponSkill", function(target, mob, skill)
    mob:setAnimationSub(1)
    local numhits = 1
    local accmod = 1
    local crit = 0.05
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5, 1.75, 2, crit)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    local power = math.floor(mob:getMainLvl() / 10) + 1

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, power, 3, 60)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.questionmarks_needles.onMobWeaponSkill", function(target, mob, skill)
    -- from http://ffxiclopedia.wikia.com/wiki/%3F%3F%3F_Needles
    -- "Seen totals ranging from 15, 000 to 55, 000 needles."
    local needles = math.random(15000, 55000) / skill:getTotalTargets()

    local dmg = xi.mobskills.mobFinalAdjustments(needles, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.LIGHT)

    return dmg
end)

m:addOverride("xi.globals.mobskills.radiant_breath.onMobWeaponSkill", function(target, mob, skill)
    local typeEffectOne = xi.effect.SLOW
    local typeEffectTwo = xi.effect.SILENCE

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffectOne, 1250, 0, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffectTwo, 1, 0, 120)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.2, 0.75, xi.magic.ele.LIGHT, 700)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.LIGHT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.radiant_sacrament.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 5
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_DEF_DOWN, 20, 0, 60) -- Needs adjusted to retail values for power/duration

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.rage.onMobWeaponSkill", function(target, mob, skill)
    local duration = 120
    local power = (116 / 256) * 100

    if mob:isPet() then
        local player = mob:getMaster()
        if player ~= nil and player:hasJugPet() then
            local tp = skill:getTP()
            duration = math.max(60, 60 * (tp / 1000))
        end
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BERSERK, power, 0, duration))
    return xi.effect.BERSERK
end)

m:addOverride("xi.globals.mobskills.raging_axe.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:addStatusEffect(xi.effect.STUN, 1, 0, 3)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.raging_fists.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local dmgmod = 1.1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.raging_rush.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.ACC_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.raiden_thrust.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.8
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.rail_cannon.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BIND

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:delHP(dmg)

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 30)

    return dmg
end)

m:addOverride("xi.globals.mobskills.rail_cannon_1.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BIND

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:delHP(dmg)

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 30)

    return dmg
end)

m:addOverride("xi.globals.mobskills.rail_cannon_2.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BIND

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:delHP(dmg)

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 30)

    return dmg
end)

m:addOverride("xi.globals.mobskills.rail_cannon_3.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BIND

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:delHP(dmg)

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 30)

    return dmg
end)

m:addOverride("xi.globals.mobskills.rampage.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local dmgmod = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        -- Witnessed 1100 to a DD.  Going with it :D
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.rampant_gnaw.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local attmod = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 2, 2.5, 3, 0, attmod)

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PARALYSIS, 5, 0, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.ram_charge.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.randgrith.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local duration = 60
    local typeEffect = xi.effect.EVASION_DOWN
    local power = 32

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, power, 0, duration)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.random_kiss.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.9, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    local drainType = math.random(0, 2)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, drainType, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.ranged_attack.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if skill:getMsg() ~= xi.msg.basic.SHADOW_ABSORB then
        if dmg > 0 then
            skill:setMsg(xi.msg.basic.RANGED_ATTACK_HIT)
        else
            skill:setMsg(xi.msg.basic.RANGED_ATTACK_MISS)
        end

        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.rapid_molt.onMobWeaponSkill", function(target, mob, skill)
    mob:eraseAllStatusEffect()
    local typeEffect = xi.effect.REGEN

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 10, 3, 180))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.razor_fang.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.reactive_armor.onMobWeaponSkill", function(target, mob, skill)
    local power = math.random(20, 30)
    local duration = 180
    local typeEffect = xi.effect.SHOCK_SPIKES
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, duration))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.reactive_shield.onMobWeaponSkill", function(target, mob, skill)
    local power = math.random(20, 30)
    -- local duration = 180
    local typeEffect = xi.effect.SHOCK_SPIKES
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, 180))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.reactor_cool.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect  = xi.effect.ICE_SPIKES
    local typeEffect2 = xi.effect.DEFENSE_BOOST

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, math.random(15, 30), 0, 60))
    local effect1 = mob:getStatusEffect(xi.effect.ICE_SPIKES)
    effect1:unsetFlag(xi.effectFlag.DISPELABLE)
    xi.mobskills.mobBuffMove(mob, typeEffect2, 26, 0, 60)
    local effect2 = mob:getStatusEffect(xi.effect.DEFENSE_BOOST)
    effect2:unsetFlag(xi.effectFlag.DISPELABLE)

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.reactor_overheat.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 0, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, info.hitslanded)
    local typeEffect = xi.effect.PLAGUE

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.reactor_overload.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 0, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.NONE, info.hitslanded)
    local typeEffect = xi.effect.SILENCE

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.rear_lasers.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PETRIFICATION

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 30))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.recoil_dive.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local crit = 0.33
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.CRIT_VARIES, 2, 2.5, 3, crit)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.red_lotus_blade.onMobWeaponSkill", function(target, mob, skill)
    if mob:getPool() == 4006 then -- Trion@QuBia_Arena only
        target:showText(mob, zones[xi.zone.QUBIA_ARENA].text.RLB_LAND)
    elseif mob:getPool() == 4249 then -- Volker@Throne_Room only
        target:showText(mob, zones[xi.zone.THRONE_ROOM].text.FEEL_MY_PAIN)
    end

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 0, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.refueling.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.HASTE, 2000, 0, 180))

    return xi.effect.HASTE
end)

m:addOverride("xi.globals.mobskills.regain_hp.onMobWeaponSkill", function(target, mob, skill)
    local hp = target:getMaxHP() - target:getHP()

    skill:setMsg(xi.msg.basic.AOE_REGAIN_HP)

    target:addHP(hp)
    target:wakeUp()

    return hp
end)

m:addOverride("xi.globals.mobskills.regain_mp.onMobWeaponSkill", function(target, mob, skill)
    local mp = target:getMaxMP() - target:getMP()

    skill:setMsg(xi.msg.basic.AOE_REGAIN_MP)

    target:addMP(mp)

    return mp
end)

m:addOverride("xi.globals.mobskills.regeneration.onMobWeaponSkill", function(target, mob, skill)
    local power = math.min(1, math.floor(((mob:getMainLvl() - 3) / 2)))
    local duration = 60

    if
        mob:getFamily() == 218 or
        mob:getFamily() == 219
    then
        power = math.min(1, math.floor(((mob:getMainLvl() - 1) / 2) / 2))
        duration = 300
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.REGEN, power, 3, duration))
    return xi.effect.REGEN
end)

m:addOverride("xi.globals.mobskills.regurgitation.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BIND

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 30)

    return dmg
end)

m:addOverride("xi.globals.mobskills.rejuvenation.onMobWeaponSkill", function(target, mob, skill)
    local hp = target:getMaxHP() - target:getHP()
    target:addHP(hp)
    target:addMP(target:getMaxMP() - target:getMP())
    target:addTP(3000 - target:getTP())

    skill:setMsg(xi.msg.basic.SELF_HEAL)
    return hp
end)

m:addOverride("xi.globals.mobskills.rending_deluge.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:dispelStatusEffect()

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.reprobation.onMobWeaponSkill", function(target, mob, skill)
    local dispel =  target:dispelAllStatusEffect(bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.FOOD))
    local msg = xi.msg.basic.SKILL_NO_EFFECT

    if dispel > 0 then
        msg = xi.msg.basic.DISAPPEAR_NUM
    end

    skill:setMsg(msg)

    return dispel
end)

m:addOverride("xi.globals.mobskills.restoral.onMobWeaponSkill", function(target, mob, skill)
    --[[
    The only calculations available on the net are for the players blue magic version,
    which does not seem to fit with retail in game observations on the mobskill version..
    So math.random() for now!
    ]]
    local heal = math.random(900, 1400)
    if mob:getPool() == 243 then
        heal = heal * 2.5
    end

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(mob, heal)
end)

m:addOverride("xi.globals.mobskills.revelation.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.5
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.rhino_attack.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local attmod = 2 -- 100% attack boost
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 1.5, 2, 0, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.rhino_guard.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.EVASION_BOOST, 30, 0, 180))

    return xi.effect.EVASION_BOOST
end)

m:addOverride("xi.globals.mobskills.riceball.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.riddle.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_MP_DOWN, math.floor(39.5 + (target:getStat(xi.mod.INT) / 2)), 0, 60))

    return xi.effect.MAX_MP_DOWN
end)

m:addOverride("xi.globals.mobskills.rime_spray.onMobWeaponSkill", function(target, mob, skill)
    -- local typeEffect = xi.effect.FROST
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FROST, 15, 3, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, 20, 10, 180)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.VIT_DOWN, 20, 10, 180)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEX_DOWN, 20, 10, 180)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AGI_DOWN, 20, 10, 180)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MND_DOWN, 20, 10, 180)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.INT_DOWN, 20, 10, 180)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CHR_DOWN, 20, 10, 180)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.magic.ele.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.rinpyotosha.onMobWeaponSkill", function(target, mob, skill)
    local power = 25
    local duration = 180

    local typeEffect = xi.effect.WARCRY
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, duration))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.ripper_fang.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local attmod = 1.3
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.5, 1.75, 2, 0, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.roar.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 50, 0, math.random(45, 120)))

    return xi.effect.PARALYSIS
end)

m:addOverride("xi.globals.mobskills.rock_crusher.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.5
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.rock_smash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    local typeEffect = xi.effect.PETRIFICATION
    local power = math.random(25, 40) + mob:getMainLvl() / 3

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 50, 0, power)

    return dmg
end)

m:addOverride("xi.globals.mobskills.rock_throw.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.rot_gas.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DISEASE, 1, 0, 360))

    return xi.effect.DISEASE
end)

m:addOverride("xi.globals.mobskills.royal_bash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    local typeEffect = xi.effect.STUN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.royal_savior.onMobWeaponSkill", function(target, mob, skill)
    local power = 175
    local duration = 300

    local typeEffect = xi.effect.PROTECT

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, duration))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.ruinous_omen.onMobWeaponSkill", function(target, mob, skill)
    local dINT = math.floor(mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))

    -- Target HPP decrease seems to be about 66% unresisted.
    -- Maximum observed 72% (weakness to darkness?)
    -- Minimum observed 44% (high resist)
    local hppTarget = 66
    local hppMin = 44
    local hppMax = 75
    local dmgmod = 0.7   -- Estimated from keeping with a max of ~72% reduction
    local ratio = 4

    -- Diabolos Dynamis Tavnazia - Observed 60%-95%, with most being above 80%
    if mob:getZoneID() == xi.zone.DYNAMIS_TAVNAZIA then
        hppTarget = 80
        hppMax = 95
        hppMin = 60
    end

    if dINT >= 0 then
        ratio = 6
    end  -- Tilt the curve so that a small dINT doesn't tip too far in Diabolos' favour.

    hppTarget = hppTarget + (dINT / ratio)    -- A wild estimate.  Diabolos INT is 131 in Waking Dreams.

    -- hpp and damage do not correlate, but we can use the system to scale damage numbers
    hppTarget = xi.mobskills.mobMagicalMove(mob, target, skill, hppTarget, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus, 0)
    hppTarget = xi.mobskills.mobAddBonuses(mob, target, hppTarget.dmg, xi.magic.ele.DARK)
    hppTarget = xi.mobskills.mobFinalAdjustments(hppTarget, mob, skill, target, xi.attackType.SPECIAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    -- Clamp the HPP reduction to a 75% total cap and a 40% total Minimum
    hppTarget = utils.clamp(hppTarget, hppMin, hppMax)

    -- Convert the reduction into a player-specific amount based on their current HP
    local damage = target:getHP() * hppTarget / 100

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return damage
end)

m:addOverride("xi.globals.mobskills.rumble.onMobWeaponSkill", function(target, mob, skill)
    local eva = mob:getStat(xi.mod.EVA) * 0.1
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.EVASION_DOWN, eva, 0, math.random(45, 120)))

    return xi.effect.EVASION_DOWN
end)

m:addOverride("xi.globals.mobskills.rush.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.rushing_drub.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 4
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.rushing_slash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 4
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.rushing_stab.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 4
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.sable_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.2, 1.25, xi.magic.ele.DARK, 1150)
    dmgmod = utils.conalDamageAdjustment(mob, target, skill, dmgmod, 0.2)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.saline_coat.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.MAGIC_DEF_BOOST
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 50, 0, 60))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.sandspin.onMobWeaponSkill", function(target, mob, skill)
    local power = 25
    if skill:getID() == 1887 then -- Nightmare Worm - increased ACCURACY_DOWN
        power = 200
    end

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ACCURACY_DOWN, power, 0, 180)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.EARTH, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.sandspray.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BLINDNESS
    local power = 25
    local duration = 90

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.sandstorm.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BLINDNESS
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 30, 0, 120))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.sand_blast.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 40, 0, 180))

    if mob:getPool() == 1318 and mob:getLocalVar("SAND_BLAST") == 1 then -- Feeler Anltion
        local alastorId = mob:getID() + 6
        local alastor = GetMobByID(alastorId)
        if not alastor:isSpawned() then -- Alastor Antlion
            mob:setLocalVar("SAND_BLAST", 0) -- Don't spawn more NMs
            alastor:setSpawn(mob:getXPos() + 1, mob:getYPos() + 1, mob:getZPos() + 1) -- Set its spawn location.
            SpawnMob(alastorId, 120):updateClaim(target)
        end
    end

    if skill:getID() == 1841 then -- Nightmare Antlion - Adds SILENCE
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 180))
        return xi.effect.SILENCE
    end

    return xi.effect.BLINDNESS
end)

m:addOverride("xi.globals.mobskills.sand_breath.onMobWeaponSkill", function(target, mob, skill)
    local power = 20
    if skill:getID() == 1873 then -- Nightmare Leech - -80 acc BLINDNESS
        power = 80
    end

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, power, 0, 180)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.085, 1, xi.magic.ele.EARTH, 333)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.sand_pit.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 60))

    -- Different mechanics based on the antlion using it
    local poolID = mob:getPool()

    if poolID == 1318 then -- if the pool ID == Feeler Antlion ID
        local npcX = mob:getXPos()
        local npcY = mob:getYPos()
        local npcZ = mob:getZPos()
        local spawnId = 0

        -- Spawn an Executioner Antlion. There are only 5 in the database.
        if not GetMobByID(mob:getID() + 1):isSpawned() then -- if not spawned, set variable to spawn later.
            spawnId = mob:getID() + 1
        elseif not GetMobByID(mob:getID() + 2):isSpawned() then
            spawnId = mob:getID() + 2
        elseif not GetMobByID(mob:getID() + 3):isSpawned() then
            spawnId = mob:getID() + 3
        elseif not GetMobByID(mob:getID() + 4):isSpawned() then
            spawnId = mob:getID() + 4
        elseif not GetMobByID(mob:getID() + 5):isSpawned() then
            spawnId = mob:getID() + 5
        else
            spawnId = 0 -- If they are all up, then don't spawn any more.
        end

        if spawnId > 0 then
            local executioner = GetMobByID(spawnId)
            executioner:setSpawn(npcX-1, npcY-2, npcZ-1) -- Set its spawn location.
            SpawnMob(spawnId):updateEnmity(target)
        end
    elseif poolID == 4046 then
        -- Tuchulcha (Sheep in Antlion's Clothing)
        -- Resets all enmity
        local allies = mob:getBattlefield():getAllies()
        for _, enmAlly in pairs(allies) do
            mob:resetEnmity(enmAlly)
        end

        -- Removes all enfeebling effects
        mob:delStatusEffectsByFlag(xi.effectFlag.ERASABLE)
    end

    return xi.effect.BIND
end)

m:addOverride("xi.globals.mobskills.sand_shield.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_BOOST
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 50, 0, 90))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.sand_trap.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PETRIFICATION

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, math.random(12, 20)))

    -- reset everyones enmity
    mob:resetEnmity(target)

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.sand_veil.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.EVASION_BOOST
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 100, 0, 120))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.saucepan.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 0.8
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    if target:hasStatusEffect(xi.effect.FOOD) then
        target:delStatusEffectSilent(xi.effect.FOOD)
    elseif target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        target:delStatusEffectSilent(xi.effect.FIELD_SUPPORT_FOOD)
    end

    target:addStatusEffectEx(xi.effect.FIELD_SUPPORT_FOOD, xi.effect.FOOD, 255, 0, 1800)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.savage_blade.onMobWeaponSkill", function(target, mob, skill)
    if mob:getPool() == 4006 then -- Trion@QuBia_Arena only
        target:showText(mob, zones[xi.zone.QUBIA_ARENA].text.SAVAGE_LAND)
    end

    local numhits = 2
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.1, 1.2, 1.3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        -- AA EV: Approx 900 damage to 75 DRG/35 THF.  400 to a NIN/WAR in Arhat, but took shadows.
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.scintillant_lance.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.5
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.5, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.scission_thrust.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded * math.random(2, 3))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.scissor_guard.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 100, 0, 60))

    return xi.effect.DEFENSE_BOOST
end)

m:addOverride("xi.globals.mobskills.scorching_lash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.scourge.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.scouring_bubbles.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2.45
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.scratch.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local typeEffect = xi.effect.BLINDNESS

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 18, 0, 120)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.scream.onMobWeaponSkill", function(target, mob, skill)
    local power = target:getStat(xi.mod.MND) * 0.25
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MND_DOWN, power, 10, 180))

    return xi.effect.MND_DOWN
end)

m:addOverride("xi.globals.mobskills.screwdriver.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local crit = 0.33
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1.5, 2, 2.5, crit)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.scutum.onMobWeaponSkill", function(target, mob, skill)
    local power = 70
    if skill:getID() == 1860 then -- Nightmare Bugard - 2x DEFENSE_BOOST
        power = 100
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, power, 0, 180))

    return xi.effect.DEFENSE_BOOST
end)

m:addOverride("xi.globals.mobskills.scythe_tail.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 10)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.seal_of_quiescence.onMobWeaponSkill", function(target, mob, skill)
    local ID = require("scripts/zones/Empyreal_Paradox/IDs")
    mob:showText(mob, ID.text.PROMATHIA_TEXT + 6)
    local typeEffect = xi.effect.MUTE
    local power = 30
    local duration = 75

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.searing_light.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local dStatMult = 1 -- This allows us to calculate dInt for summoners 2hr
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 9, 9, 9, dStatMult)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.secretion.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.EVASION_BOOST, 25, 0, 180))

    return xi.effect.EVASION_BOOST
end)

m:addOverride("xi.globals.mobskills.seedspray.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 8, 0, 120)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.seismostomp.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod  = 1
    local dmgmod  = 2.3

    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        dmgmod = dmgmod + math.random()
    end

    local info           = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local shadowsRemoved = math.random(1, 2)
    local dmg            = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, shadowsRemoved)
    local typeEffect     = xi.effect.STUN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.self-destruct.onMobWeaponSkill", function(target, mob, skill)
    local damage = skill:getMobHP() / 3
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:setHP(0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.self-destruct_1.onMobWeaponSkill", function(target, mob, skill)
    local damage = skill:getMobHP() / 3

    if skill:getID() == 1855 then -- Nightmare Cluster - increased damage
        damage = skill:getMobHP()
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1, 1.1, 1.2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:setHP(0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.self-destruct_2.onMobWeaponSkill", function(target, mob, skill)
    local damage = skill:getMobHP() / 6

    if skill:getID() == 1855 then -- Nightmare Cluster - increased damage
        damage = skill:getMobHP() / 2
    end

    -- Razon - ENM: Fire in the Sky
    if mob:getHPP() <= 33 and mob:getPool() == 3333 then
        damage = 0
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 1, 1.1, 1.2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:setAnimationSub(2)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.self-destruct_2death.onMobWeaponSkill", function(target, mob, skill)
    local damage = skill:getMobHP() / 6
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1, 1.1, 1.2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:setHP(0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.self-destruct_3.onMobWeaponSkill", function(target, mob, skill)
    local damage = skill:getMobHP() / 9

    if skill:getID() == 1853 then -- Nightmare Cluster - increased damage
        damage = skill:getMobHP() / 3
    end

    -- Razon - ENM: Fire in the Sky
    if mob:getHPP() <= 66 and mob:getPool() == 3333 then
        damage = 0
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 1, 1.1, 1.2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:setAnimationSub(1)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.self-destruct_321.onMobWeaponSkill", function(target, mob, skill)
    local amount = 9999

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, amount, xi.magic.ele.FIRE, 2.1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:setHP(0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.self-destruct_3death.onMobWeaponSkill", function(target, mob, skill)
    local damage = skill:getMobHP() / 9
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1, 1.1, 1.2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:setHP(0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.sentinel.onMobWeaponSkill", function(target, mob, skill)
    target:addEnmity(mob, 1, 1800)
    skill:setMsg(xi.msg.basic.NONE)
end)

m:addOverride("xi.globals.mobskills.seraph_blade.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.25
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.seraph_strike.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.6
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.serpentine_tail.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 3, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.severing_fang.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 30, 0, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.shackled_fists.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 2.5, 3.0, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.shadowstitch.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 2, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
        local resist = xi.magic.applyResistanceAddEffect(mob, target, xi.magic.ele.ICE, xi.effect.BIND, 0)
        if not target:hasStatusEffect(xi.effect.BIND) and resist >= 0.5 then
            local duration = (5 + 5) * resist
            target:addStatusEffect(xi.effect.BIND, 1, 0, duration)
        end
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.shadow_claw.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BLINDNESS, 30, 0, 30)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.shadow_of_death.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.8
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.shadow_spread.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = 0
    local currentMsg = xi.msg.basic.NONE
    local msg = xi.msg.basic.NONE

    msg = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_I, 20, 0, 180)

    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.CURSE_I
        currentMsg = msg
    end

    msg = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 100, 0, 180)

    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.BLINDNESS
        currentMsg = msg
    end

    msg = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, 60)

    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.SLEEP_I
        currentMsg = msg
    end

    skill:setMsg(currentMsg)

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.shakeshroom.onMobWeaponSkill", function(target, mob, skill)
    mob:setAnimationSub(3)

    local numhits = 1
    local accmod = 1
    local crit = 0.05
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5, 1.75, 2, crit)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DISEASE, 1, 0, 720)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.shantotto_ii_melee.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.magic.ele.NONE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.NONE)
    skill:setMsg(xi.msg.basic.HIT_DMG)
    return dmg
end)

m:addOverride("xi.globals.mobskills.shark_bite.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.sharp_sting.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.sharp_strike.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.ATTACK_BOOST, 50, 0, 180))

    return xi.effect.ATTACK_BOOST
end)

m:addOverride("xi.globals.mobskills.sheep_charge.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.sheep_charge_melee.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.sheep_song.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, 45))

    return xi.effect.SLEEP_I
end)

m:addOverride("xi.globals.mobskills.shell_bash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.shell_crusher.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:addStatusEffect(xi.effect.DEFENSE_DOWN, 15, 0, 120)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.shell_guard.onMobWeaponSkill", function(target, mob, skill)
    local defBoost = 25
    if mob:isInDynamis() then
        defBoost = 50
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, defBoost, 0, 60))

    return xi.effect.DEFENSE_BOOST
end)

m:addOverride("xi.globals.mobskills.shibaraku.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded * math.random(2, 3))

    local typeEffect = xi.effect.STUN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.shield_bash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 0.8
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 5)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.shield_break.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.25
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.EVASION_DOWN, 40, 0, 120 + (skill:getTP() / 1000 * 60))
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    return dmg
end)

m:addOverride("xi.globals.mobskills.shield_strike.onMobWeaponSkill", function(target, mob, skill)
    -- TODO: Knockback

    local numhits = 1
    local accmod = 1
    local dmgmod = 0.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    -- <100 damage to pretty much anything, except on rare occasions.
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.shiko_no_mitate.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_BOOST
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 15, 0, 300))

    -- Extra stuff for Trust: Gessho
    if mob:getObjType() == xi.objType.TRUST then
        mob:addStatusEffect(xi.effect.ISSEKIGAN, 25, 0, 300)
        mob:addStatusEffect(xi.effect.STONESKIN, 300, 0, 300)
    end

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.shining_blade.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.shining_strike.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.7
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.shockwave.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.5
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN) * 3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    local typeEffect = xi.effect.SLEEP_I

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, math.random(20, 40), 3, 60)
    return dmg
end)

m:addOverride("xi.globals.mobskills.shock_strike.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.shock_wave.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WIND, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 0.6, 0.8, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.shoulder_attack.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.shoulder_slam.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.shoulder_tackle.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.25
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)

    return dmg
end)

m:addOverride("xi.globals.mobskills.shuffle.onMobWeaponSkill", function(target, mob, skill)
    local effect = target:dispelStatusEffect()

    if effect == xi.effect.NONE then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
    end

    return effect
end)

m:addOverride("xi.globals.mobskills.sic.onMobWeaponSkill", function(target, mob, skill)
    -- Fantoccini (ENM: Pulling the Strings)
    if mob:getPool() == 1296 then
        local pet = GetMobByID(mob:getID() + 1) -- Fantoccini's monster
        pet:setTP(3000)
        pet:setMobMod(xi.mobMod.SKILL_LIST, ID.jobTable[mob:getMainJob()].petSkillList)
        mob:timer(5000, function(mobArg)
            pet:setMobMod(xi.mobMod.SKILL_LIST, 0)
        end)
    else
        mob:getPet():setTP(3000)
    end

    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.sickle_moon.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5, 2, 2.75)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.sickle_slash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local crit = 0.4
    local attmod = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 1.5, 2, crit, attmod)
    local shadows = info.hitslanded

    if
        mob:getFamily() >= 122 and -- Ghrah
        mob:getFamily() <= 124
    then
        shadows = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    end

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, shadows)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.sideswipe.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        mob:resetEnmity(target)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.sidewinder.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 0.8
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.ACC_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.sigh.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.EVASION_BOOST, 200, 0, 15))

    return xi.effect.EVASION_BOOST
end)

m:addOverride("xi.globals.mobskills.silence_gas.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)

    local dmgmod = 1
    if mob:getMaster() then
        dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 2, xi.magic.ele.DARK, 300)
    else
        dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.25, 2, xi.magic.ele.DARK, 800)
    end

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.silence_seal.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 120))

    return xi.effect.SILENCE
end)

m:addOverride("xi.globals.mobskills.silencing_microtube.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.SILENCE

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 60)

    local dmgmod = 2.45
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.magic.ele.NONE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.NONE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.sinuate_rush.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded * math.random(2, 3))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.siphon_discharge.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 1.25, xi.magic.ele.WATER, 200)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.skewer.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 3, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.skullbreaker.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.1, 1.2, 1.3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        if math.random(1, 100) < skill:getTP() / 3 then
            target:addStatusEffect(xi.effect.INT_DOWN, 10, 10, 120)
        end

        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.slam_dunk.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 1, 0, math.random(30, 60))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.slapstick.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.slaverous_gale.onMobWeaponSkill", function(target, mob, skill)
    local typeEffectOne = xi.effect.PLAGUE
    local typeEffectTwo = xi.effect.SLOW
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffectOne, 1, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffectTwo, 1250, 0, 60)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * math.random(4, 6), xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.sledgehammer.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, 3 * info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PETRIFICATION, 1, 0, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.sleet_blast.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 5, 5, 5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.sleet_blast_alt.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    skill:setMsg(xi.msg.basic.HIT_DMG)
    return dmg
end)

m:addOverride("xi.globals.mobskills.slice.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.sling_bomb.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.slipstream.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ACCURACY_DOWN, 25, 0, math.random(120, 180)))

    return xi.effect.ACCURACY_DOWN
end)

m:addOverride("xi.globals.mobskills.slumber_powder.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, 30))

    return xi.effect.SLEEP_I
end)

m:addOverride("xi.globals.mobskills.smash_axe.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:addStatusEffect(xi.effect.STUN, 1, 0, 3)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.smite_of_fury.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.smite_of_rage.onMobWeaponSkill", function(target, mob, skill)
    if mob:getFamily() == 271 then -- Jailer of Love, uses only animation.
        skill:setMsg(xi.msg.NONE)
        return 0
    end

    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.smite_of_rage_2hr.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.smokebomb.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 20, 0, 120))

    return xi.effect.BLINDNESS
end)

m:addOverride("xi.globals.mobskills.smoke_discharger.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PETRIFICATION
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 3, math.random(30, 45))

    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    if target:hasStatusEffect(xi.effect.ELEMENTALRES_DOWN) then
        target:delStatusEffectSilent(xi.effect.ELEMENTALRES_DOWN)
    end

    mob:setLocalVar("nuclearWaste", 0)
    return dmg
end)

m:addOverride("xi.globals.mobskills.snatch_morsel.onMobWeaponSkill", function(target, mob, skill)
    if target:hasStatusEffect(xi.effect.FOOD) then
        -- 99% sure retail doesn't do this. Uncomment if you want it to happen.
        -- local foodID = target:getStatusEffect(xi.effect.FOOD):getSubType()
        -- local duration = target:getStatusEffect(xi.effect.FOOD):getDuration()
        -- mob:addStatusEffect(xi.effect.FOOD, 0, 0, duration, foodID) -- Gives Colibri the players food.
        target:delStatusEffect(xi.effect.FOOD)
        skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
    elseif target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        -- 99% sure retail doesn't do this. Uncomment if you want it to happen.
        -- local foodID = target:getStatusEffect(xi.effect.FIELD_SUPPORT_FOOD):getpower()
        -- local duration = target:getStatusEffect(xi.effect.FIELD_SUPPORT_FOOD):getDuration()
        -- mob:addStatusEffect(xi.effect.FIELD_SUPPORT_FOOD, foodID, 0, duration) -- Gives Colibri the players FoV/GoV food.
        target:delStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
        skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS) -- no effect
    end

    return xi.effect.FOOD
end)

m:addOverride("xi.globals.mobskills.sniper_shot.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.1, 1.2, 1.3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        if math.random(1, 100) < skill:getTP() / 3 then
            target:addStatusEffect(xi.effect.INT_DOWN, 10, 0, 120)
        end

        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.snort.onMobWeaponSkill", function(target, mob, skill)
    local dStatMult = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WIND, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 2, 2.5, 3, dStatMult)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.snowball.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.ICE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.snow_cloud.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 30, 0, 120)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.ICE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.somersault.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local attmod = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3, 0, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.somersault_kick.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.sonic_blade.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.sonic_boom.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, 25, 0, math.random(120, 180)))

    return xi.effect.ATTACK_DOWN
end)

m:addOverride("xi.globals.mobskills.sonic_buffet.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.5, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    for i = 1, math.random(2, 3) do
        target:dispelStatusEffect(xi.effectFlag.DISPELABLE)
    end

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    return dmg
end)

m:addOverride("xi.globals.mobskills.sonic_wave.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 40, 0, math.random(150, 180)))

    return xi.effect.DEFENSE_DOWN
end)

m:addOverride("xi.globals.mobskills.soporific.onMobWeaponSkill", function(target, mob, skill)
    if mob:getZoneID() == xi.zone.DYNAMIS_VALKURM then
        local effect = xi.effect.SLEEP_I
        local resist = xi.mobskills.applyPlayerResistance(mob, nil, target, mob:getStat(xi.mod.INT)-target:getStat(xi.mod.INT), 1, xi.magic.ele.DARK)
        local duration = math.ceil(60 + math.floor(31 * math.random()) * resist) -- wiki: duration variable from 30 to 90. can be thought of random 60-90 with possible half resist making it range 30-90
        if resist >= 0.5 then
            if
                not (target:hasImmunity(xi.immunity.SLEEP) or
                target:hasStatusEffect(xi.effect.SLEEP_I) or
                target:hasStatusEffect(xi.effect.SLEEP_II) or
                target:hasStatusEffect(xi.effect.LULLABY)) and
                -- use nightmare tick with 50 hp every 3 seconds
                target:addStatusEffect(effect, 20, 3, duration, 135, 50)
            then
                skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
            else
                skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
            end
        else
            skill:setMsg(xi.msg.basic.SKILL_MISS)
        end

        return effect
    else
        local typeEffect = xi.effect.SLEEP_I
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 90))
        return typeEffect
    end
end)

m:addOverride("xi.globals.mobskills.soulshattering_roar.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.TERROR
    -- local duration = 10
    local dmgmod = 2.0

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 30)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)

    -- TODO: Temporary immunity to a single weapon damage type

    return dmg
end)

m:addOverride("xi.globals.mobskills.soul_accretion.onMobWeaponSkill", function(target, mob, skill)
    -- try to drain buff
    local effect1 = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
    local effect2 = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
    local effect3 = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)

    if effect1 ~= 0 then
        local count = 1
        if effect2 ~= 0 then
            count = count + 1
        end

        if effect3 ~= 0 then
            count = count + 1
        end

        skill:setMsg(xi.msg.basic.EFFECT_DRAINED)
        return count
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end
end)

m:addOverride("xi.globals.mobskills.soul_drain.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.soul_voice.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.SOUL_VOICE, 1, 0, 180)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.SOUL_VOICE
end)

m:addOverride("xi.globals.mobskills.sound_blast.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.INT_DOWN, 10, 10, 180))

    return xi.effect.INT_DOWN
end)

m:addOverride("xi.globals.mobskills.sound_vacuum.onMobWeaponSkill", function(target, mob, skill)
    local duration = 90

    if mob:getMainLvl() < 10 then
        duration = duration / 2
    end

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, duration))

    return xi.effect.SILENCE
end)

m:addOverride("xi.globals.mobskills.spectral_barrier.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.MAGIC_SHIELD

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 1, 0, 60))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.spider_web.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 5000, 0, math.random(120, 180)))

    return xi.effect.SLOW
end)

m:addOverride("xi.globals.mobskills.spikeball.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, 16, 3, math.random(30, 60))

    return dmg
end)

m:addOverride("xi.globals.mobskills.spike_flail.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 4, 4, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.spinal_cleave.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 3
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.spine_lash.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PLAGUE

    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 0, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.NONE, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.spinning_attack.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded * math.random(2, 3))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.spinning_axe.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.spinning_claw.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded * math.random(2, 3))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.spinning_dive.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.spinning_fin.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded * math.random(2, 3))

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.spinning_scythe.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    if not skill:hasMissMsg() then
        -- 150-200 damage
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.spinning_top.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 4
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.spiral_hell.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 2, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.spiral_spin.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local typeEffect = xi.effect.ACCURACY_DOWN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 50, 0, 120)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.spirits_within.onMobWeaponSkill", function(target, mob, skill)
    if mob:getPool() == 4249 then -- Volker@Throne_Room only
        target:showText(mob, zones[xi.zone.THRONE_ROOM].text.RETURN_TO_THE_DARKNESS)
    end

    local tp = skill:getTP()
    local hp = mob:getHP()
    local dmg = 0

    -- spirits within for monsters no longer takes TP into consideration - This was causing it to WILDLY do more damage than it was sopposed to
    -- it is now more inline with retail captures also was going 2.5x damage

    dmg = math.floor(hp * (math.floor(0.016 * tp) + 16) / 256)

    dmg = target:breathDmgTaken(dmg)

    -- Handling phalanx
    dmg = dmg - target:getMod(xi.mod.PHALANX)

    if dmg < 0 then
        return 0
    end

    dmg = utils.rampart(target, dmg)
    dmg = utils.stoneskin(target, dmg)

    if dmg > 0 then
        target:wakeUp()
        target:updateEnmityFromDamage(mob, dmg)
    end

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.ELEMENTAL)
    return dmg
end)

m:addOverride("xi.globals.mobskills.spirit_absorption.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 3.5, 4, 4.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.spirit_tap.onMobWeaponSkill", function(target, mob, skill)
    -- try to drain buff
    local effect = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
    local dmg = 0

    if effect ~= 0 then
        skill:setMsg(xi.msg.basic.EFFECT_DRAINED)
        return 1
    else
        local power = mob:getMainLvl() * 2
        dmg = xi.mobskills.mobFinalAdjustments(power, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.spirit_vacuum.onMobWeaponSkill", function(target, mob, skill)
    local tpStolen = target:getTP() * 26 / 30 -- stole 2600/3000 TP per capture - 87%
    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.TP, tpStolen))

    return tpStolen
end)

m:addOverride("xi.globals.mobskills.splash_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 1, xi.magic.ele.WATER, 400)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.spoil.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, 10, 10, 300))

    return xi.effect.STR_DOWN
end)

m:addOverride("xi.globals.mobskills.spore.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 15, 0, 180))

    return xi.effect.PARALYSIS
end)

m:addOverride("xi.globals.mobskills.spring_breeze.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, 20))
    target:setTP(target:getTP() * 0.5)

    return xi.effect.SLEEP_I
end)

m:addOverride("xi.globals.mobskills.spring_water.onMobWeaponSkill", function(target, mob, skill)
    -- Formula needs redone with retail MOB VERSION not players avatar
    local base = mob:getMainLvl() + 2 * mob:getMainLvl() * (skill:getTP() / 1000) --base is around 5~150 level depending
    -- local m = 5
    local multiplier = 1 + (1 - (mob:getHP() / mob:getMaxHP())) * 5    --higher multiplier the lower your HP. at 15% HP, multiplier is 1+0.85*M
    base = base * multiplier

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(target, base)
end)

m:addOverride("xi.globals.mobskills.sprout_smack.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    local typeEffect = xi.effect.SLOW

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 3000, 0, 90)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.sprout_spin.onMobWeaponSkill", function(target, mob, skill)
    -- Knockback
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.stampede.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.starburst.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.8
    local attkType = xi.damageType.DARK
    local element = xi.magic.ele.DARK

    if math.random() > 0.5 then
        attkType = xi.damageType.LIGHT
        element = xi.magic.ele.DARK
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, element, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, attkType, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, attkType)
    return dmg
end)

m:addOverride("xi.globals.mobskills.starlight.onMobWeaponSkill", function(target, mob, skill)
    local mpRecoverAmt = mob:getWeaponDmg() * 1.75
    local maxmp = target:getMaxMP()
    local currmp = target:getMP()
    if mpRecoverAmt + currmp > maxmp then
            mpRecoverAmt = maxmp - currmp
        end
    skill:setMsg(xi.msg.basic.RECOVERS_MP, 0, mpRecoverAmt)
end)

m:addOverride("xi.globals.mobskills.stasis.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.0, 1.25, 1.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    local typeEffect = xi.effect.PARALYSIS

    if not skill:hasMissMsg() then
        mob:resetEnmity(target)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 40, 0, 60)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)

    return dmg
end)

m:addOverride("xi.globals.mobskills.static_filament.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 0, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.NONE, info.hitslanded)
    local typeEffect = xi.effect.STUN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.stave_toss.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    mob:setAnimationSub(1) -- Mob loses Staff on using Stave Toss

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.stellar_arrow.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.stellar_burst.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.magic.ele.NONE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, info.hitslanded * math.random(2, 3))
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 30)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.NONE)
    mob:resetEnmity(target)
    return dmg
end)

m:addOverride("xi.globals.mobskills.sticky_thread.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 0, 180))

    return xi.effect.SLOW
end)

m:addOverride("xi.globals.mobskills.stinking_gas.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.VIT_DOWN, 10, 15, 180))

    return xi.effect.VIT_DOWN
end)

m:addOverride("xi.globals.mobskills.stomping.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local attmod = 1.5 -- 50% attack bonus
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5, 1.75, 2, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.stone_ii.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.stone_iv.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.stone_meeble_warble.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 9, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PETRIFICATION, 30, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.RASP, 50, 3, 60)
    return dmg
end)

m:addOverride("xi.globals.mobskills.stone_throw.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.RANGED, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.BLUNT, info.hitslanded)

    -- 50% chance
    if math.random(1, 2) == 1 then
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PARALYSIS, 20, 0, 60)
    end

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.stormwind.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1

    if mob:getName() == "Kreutzet" then
        local stormwindDamage = mob:getLocalVar("stormwindDamage")
        if stormwindDamage == 2 then
            dmgmod = 1.1
        elseif stormwindDamage == 3 then
            dmgmod = 1.15
        end
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.strap_cutter.onMobWeaponSkill", function(target, mob, skill)
-- todo make a random for which gear to remove and how many pieces
    local remove = 0xFFFF

    target:addStatusEffectEx(xi.effect.ENCUMBRANCE_I, xi.effect.ENCUMBRANCE_I, remove, 0, 60)
end)

m:addOverride("xi.globals.mobskills.string_clipper.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MELEE, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.stun_cannon.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.5
    local typeEffect = xi.effect.PARALYSIS

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 20, 0, 120)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.sturmwind.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.stygian_flatus.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 30, 0, 120))

    return xi.effect.PARALYSIS
end)

m:addOverride("xi.globals.mobskills.stygian_vapor.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 0, 120))

    return xi.effect.PLAGUE
end)

m:addOverride("xi.globals.mobskills.sub-zero_smash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1  -- Hits once, despite the animation looking like it hits twice.
    local dmgmod = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PARALYSIS, 10, 0, 100)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.subsonics.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 25, 0, 180))

    return xi.effect.DEFENSE_DOWN
end)

m:addOverride("xi.globals.mobskills.substitute.onMobWeaponSkill", function(target, mob, skill)
    local resistances =
    {
        xi.mod.SLASH_SDT,
        xi.mod.PIERCE_SDT,
        xi.mod.IMPACT_SDT,
        xi.mod.HTH_SDT,
    }

    -- Marquis Andrealphus
    if mob:getPool() == 2571 then
        local party = target:getParty()
        local control = false

        -- Ability is only used when there is another party
        -- member in the party, or party size > 1
        if mob:getPool() == 2571 then
            if #party > 1 then
                for _, v in ipairs(target:getParty()) do
                    if v:getZone() == target:getZone() then
                        control = true
                    end
                end
            else
                control = true
            end
        end

        if control then
            mob:timer(1000, function(mobArg)
                mobArg:injectActionPacket(target:getID(), 4, 261, 0, 0, 0, 10, 1)
                mobArg:timer(3000, function(mobArg1)
                    xi.teleport.escape(target)
                end)
            end)
        end

    -- Die by the Sword BCNM
    else
        local oldAnim = mob:getAnimationSub()
        local newAnim = oldAnim

        while newAnim == oldAnim do
            newAnim = math.random(1, 3)
        end

        mob:setAnimationSub(newAnim)

        for i = 1, 4 do
            if i == newAnim then
                mob:setMod(resistances[i], 1000)
            else
                mob:setMod(resistances[i], -2500)
            end
        end

        if newAnim == 3 then
            mob:setMod(resistances[4], 1000)
        else
            mob:setMod(resistances[4], -2500)
        end
    end

    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.suction.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.suctorial_tentacle.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 5, 3, 90))
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 90)

    return xi.effect.POISON, xi.effect.BIND
end)

m:addOverride("xi.globals.mobskills.sudden_lunge.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 0)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    local typeEffect = xi.effect.STUN
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    local currentHP = mob:getHP()
    local newHP = currentHP - (currentHP * (math.random(5, 15) / 100))
    mob:setHP(newHP)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)

    return dmg
end)

m:addOverride("xi.globals.mobskills.sulfurous_breath.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local ftp100 = 2.0
    local ftp200 = 2.5
    local ftp300 = 3.0

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, ftp100, ftp200, ftp300)
    local conaldmg = utils.conalDamageAdjustment(mob, target, skill, info.dmg, 0.2)
    local dmg = xi.mobskills.mobFinalAdjustments(conaldmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded * math.random(1, 2))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.summer_breeze.onMobWeaponSkill", function(target, mob, skill)
    local erase = mob:eraseStatusEffect()

    if erase ~= xi.effect.NONE then
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
        return erase
    else
        skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.REGAIN, 10, 3, 60))
        return xi.effect.REGAIN
    end
end)

m:addOverride("xi.globals.mobskills.summonshadows.onMobWeaponSkill", function(target, mob, skill)
    local zeidId = mob:getID()
    local shadowOne = GetMobByID(zeidId + 1)
    local shadowTwo = GetMobByID(zeidId + 2)

    if not shadowOne:isSpawned() and not shadowTwo:isSpawned() then
        local xPos = mob:getXPos()
        local yPos = mob:getYPos()
        local zPos = mob:getZPos()

        shadowOne:spawn()
        shadowTwo:spawn()
        shadowOne:setPos(xPos, yPos, zPos)
        shadowTwo:setPos(xPos, yPos, zPos)
        shadowOne:updateEnmity(target)
        shadowTwo:updateEnmity(target)
    end

    skill:setMsg(xi.msg.basic.NONE)

    return 0
end)

m:addOverride("xi.globals.mobskills.sunburst.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.8
    local attkType = xi.damageType.DARK
    local element = xi.magic.ele.DARK

    if math.random() > 0.5 then
        attkType = xi.damageType.LIGHT
        element = xi.magic.ele.DARK
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, element, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, attkType, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, attkType)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.super_buff.onMobWeaponSkill", function(target, mob, skill)
    target:addStatusEffectEx(xi.effect.SUPER_BUFF, 0, 50, 0, 30)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.sweep.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded * math.random(2, 3))

    local typeEffect = xi.effect.STUN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.sweeping_flail.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded * math.random(2, 3))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.sweeping_somnolence.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 4
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    if not skill:hasMissMsg() then
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.WEIGHT, 50, 0, 120)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.sweet_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, 30)

    return dmg
end)

m:addOverride("xi.globals.mobskills.swift_blade.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.ACC_VARIES)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        -- Around 700 damage from AA HM
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tachi_enpi.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tachi_gekko.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.56, 1.88, 2.50)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)
        -- About 300-400 to a DD.
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tachi_goten.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.8
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tachi_hobaku.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.25
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.NO_EFFECT, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    return dmg
end)

m:addOverride("xi.globals.mobskills.tachi_jinpu.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1.6
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.ACC_VARIES, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tachi_kagero.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.8
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tachi_kaiten.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tachi_kasha.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.56, 1.88, 2.50)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 25, 0, 60)
        -- About 400-500
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tachi_koki.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.8
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tachi_yukikaze.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.56, 1.88, 2.50)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 25, 0, 60)
        -- Never actually got a good damage sample.  Putting it between Gekko and Kasha.
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tackle.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    local typeEffect = xi.effect.STUN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tail_blow.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tail_crush.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local power = mob:getMainLvl() / 10 + 10
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, power, 3, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tail_roll.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tail_slap.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.ATK_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    local typeEffect = xi.effect.STUN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tail_smash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 1, 0, 90)

    return dmg
end)

m:addOverride("xi.globals.mobskills.tail_swing.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 1, 0, 90)

    return dmg
end)

m:addOverride("xi.globals.mobskills.tail_thrust.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PARALYSIS, 15, 0, 120)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tail_whip.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    local typeEffect = xi.effect.WEIGHT
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 50, 0, 120)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.target_analysis.onMobWeaponSkill", function(target, mob, skill)
    local attributesDown =
    {
        xi.effect.STR_DOWN,
        xi.effect.DEX_DOWN,
        xi.effect.VIT_DOWN,
        xi.effect.AGI_DOWN,
        xi.effect.MND_DOWN,
        xi.effect.INT_DOWN,
        xi.effect.CHR_DOWN,
    }

    local drained = 0

    for i = 1, 7 do
        if math.random(0, 100) < 40 then
            skill:setMsg(xi.mobskills.mobDrainAttribute(mob, target, attributesDown[i], 14, 3, 120))
            drained = drained + 1
        end
    end

    return drained
end)

m:addOverride("xi.globals.mobskills.tarutaru_warp_ii.onMobWeaponSkill", function(target, mob, skill)
    local t = mob:getSpawnPos()
    local angle = math.random() * 2 * math.pi
    local pos = NearLocation(t, 18.0, angle)
    mob:teleport(pos, target)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.tebbad_wing.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PLAGUE

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 10, 0, 120)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 6, 6, 6)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.tebbad_wing_air.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PLAGUE

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 10, 0, 120)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 7, 7, 7)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.tempest_wing.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() * 4.75, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 50, 0, 60)
    return dmg
end)

m:addOverride("xi.globals.mobskills.temporal_shift.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.STUN

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 5))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.tenebrous_mist.onMobWeaponSkill", function(target, mob, skill)
    local reset = 0
    if target:getTP() == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        target:setTP(reset)
        skill:setMsg(xi.msg.basic.TP_REDUCED)
    end

    return reset
end)

m:addOverride("xi.globals.mobskills.tentacle.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tenzen_ranged_alt.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, dmgmod, 0)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:addTP(20)
        mob:addTP(80)
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    skill:setMsg(352) -- fixes incorrect messages on ranged attacks
    return dmg
end)

m:addOverride("xi.globals.mobskills.teraflare.onMobWeaponSkill", function(target, mob, skill)
    mob:setLocalVar("TeraFlare", 1) -- When set to 1 the script won't call it.
    mob:setLocalVar("tauntShown", 0)
    mob:setMobAbilityEnabled(true) -- enable the spells/other mobskills again
    mob:setMagicCastingEnabled(true)
    mob:setAutoAttackEnabled(true)
    if bit.band(mob:getBehaviour(), xi.behavior.NO_TURN) == 0 then -- re-enable noturn
        mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    end

    local dStatMult = 1.5
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, 20 * mob:getMainLvl(), xi.magic.ele.FIRE, nil, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, nil, nil, nil, dStatMult)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    return dmg
end)

m:addOverride("xi.globals.mobskills.tera_slash.onMobWeaponSkill", function(target, mob, skill)
    local dmg = 0
    if mob:getHPP() <= 25 and math.random() > 0.50 then
        dmg = target:getHP()
        target:setHP(0)
        return dmg
    end

    local numhits = 1
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.terror_eye.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.TERROR
    local duration = 30

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 1, 0, duration))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.terror_touch.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local crit = 0.2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2, crit)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.ATTACK_DOWN, 70, 0, 90)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.thermal_pulse.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BLINDNESS

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 20, 0, 60)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.the_wrath_of_gudha.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.WEIGHT

    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 0, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.NONE, info.hitslanded)

    if not skill:hasMissMsg() then
        xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 80, 0, 10)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.thornsong.onMobWeaponSkill", function(target, mob, skill)
    local power = mob:getMainLvl() * 2
    local duration = 180
    local typeEffect = xi.effect.BLAZE_SPIKES
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, duration))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.thrashing_assault.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 4
    local accmod = 1
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 15)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_BOOST, 50, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.throat_stab.onMobWeaponSkill", function(target, mob, skill)
    -- Set player to 5% of max HP
    local damage = math.max(0, target:getMaxHP() * 0.95 - (target:getMaxHP() - target:getHP()))

    local dmg = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    -- only allow a maximum of 95% damage even if modifiers would increase the damage
    -- like weakness to piercing
    dmg = math.min(damage, dmg)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    mob:resetEnmity(target)
    return dmg
end)

m:addOverride("xi.globals.mobskills.throat_stab_2hr.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.thunderbolt.onMobWeaponSkill", function(target, mob, skill)
    local duration = math.random(8, 14)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, duration)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 0.6, 0.8, 1.0)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.thunderbolt_breath.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 7)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.083, 1, xi.magic.ele.THUNDER, 500)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.thunderous_yowl.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect1 = xi.effect.PLAGUE
    local typeEffect2 = xi.effect.CURSE_I

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect1, 5, 3, 60)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect2, 25, 0, 60))

    return typeEffect2
end)

m:addOverride("xi.globals.mobskills.thunderspark.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 30, 0, 60)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.LIGHTNING, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.thunderstorm.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.thunderstrike.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 3
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.LIGHTNING, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.thunder_break.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.STUN

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, math.random(10, 20))

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.THUNDER, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.thunder_breath.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.5, 1, xi.magic.ele.THUNDER, 700)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.thunder_ii.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.LIGHTNING, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.thunder_iv.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.thunder_maneuver.onMobWeaponSkill", function(target, mob, skill)
    local power = 10
    local duration = 60
    local typeEffect = xi.effect.THUNDER_MANEUVER

    -- Fantoccini (ENM: Pulling the Strings)
    if mob:getPool() == 1296 then
        local pet = GetMobByID(mob:getID() + 1)
        pet:addStatusEffect(typeEffect, power, 0, duration)
    else
        mob:getPet():addStatusEffect(typeEffect, power, 0, duration)
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.thunder_meeble_warble.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 9, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 30, 0, 15)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SHOCK, 50, 3, 60)
    return dmg
end)

m:addOverride("xi.globals.mobskills.thunder_thrust.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.7
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.thundris_shriek.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.TERROR

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 15)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.tidal_dive.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BIND

    local numhits = math.random(2, 3)
    local accmod = 1
    local dmgmod = .8
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.NONE, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 30)

    typeEffect = xi.effect.WEIGHT
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 50, 0, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tidal_slash.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 3
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3.5, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tidal_wave.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local dStatMult = 1 -- This allows us to calculate dInt for summoners 2hr
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 9, 9, 9, dStatMult)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.tormentful_glare.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.CURSE_I

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 30, 0, 360))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.torpid_glare.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.SLEEP_I

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 1, 0, 30))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.torrent.onMobWeaponSkill", function(target, mob, skill)
    for i = xi.slot.MAIN, xi.slot.BACK do
        target:unequipItem(i)
    end

    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.tortoise_song.onMobWeaponSkill", function(target, mob, skill)
    local count = target:dispelAllStatusEffect(bit.bor(xi.effectFlag.SONG, xi.effectFlag.ROLL))

    if count == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    else
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    end

    return count
end)

m:addOverride("xi.globals.mobskills.tortoise_stomp.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    local typeEffect = xi.effect.DEFENSE_DOWN
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 25, 0, math.random(120, 180))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.touchdown.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0.75, 0.75, 0.75)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    mob:delStatusEffect(xi.effect.ALL_MISS)
    mob:setMobSkillAttack(0)
    mob:setAnimationSub(2)
    return dmg
end)

m:addOverride("xi.globals.mobskills.touchdown_bahamut.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local ftp100 = 1.5
    local ftp200 = 1.75
    local ftp300 = 2.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, ftp100, ftp200, ftp300)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tourbillion.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    local duration = 20 * (skill:getTP() / 1000)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 20, 0, duration)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.toxic_pick.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local power = math.ceil(mob:getMainLvl() / 5)
    local poisonPower

    if mob:getPool() == 1532 then
        poisonPower = 30
    else
        poisonPower = math.ceil(mob:getMainLvl() / 5)
    end

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, poisonPower, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, power, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 1, 0, 60)

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.toxic_spit.onMobWeaponSkill", function(target, mob, skill)
    local power = mob:getMainLvl() / 5 + 3

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 3, 180)
end)

m:addOverride("xi.globals.mobskills.tp_drainkiss.onMobWeaponSkill", function(target, mob, skill)
    local tpStolen = target:getTP() / 2 -- 50% of targets TP according to JP Wikis
    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.TP, tpStolen))

    return tpStolen
end)

m:addOverride("xi.globals.mobskills.train_fall.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local shadow = xi.mobskills.shadowBehavior.NUMSHADOWS_3

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, shadow)
    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.trample.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BIND
    local duration = math.random(40, 60)

    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local ftp100 = 1.5
    local ftp200 = 1.75
    local ftp300 = 2.0

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, ftp100, ftp200, ftp300)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded * math.random(2, 3))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, duration)

    return dmg
end)

m:addOverride("xi.globals.mobskills.transfusion.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.HP, dmg, xi.attackType.MAGICAL, xi.damageType.DARK))

    return dmg
end)

m:addOverride("xi.globals.mobskills.transmogrification.onMobWeaponSkill", function(target, mob, skill)
    mob:setMod(xi.mod.PHYS_ABSORB, 1000)
    mob:timer(1000 * math.random(28, 32), function(mobArg)
        mobArg:delMod(xi.mod.PHYS_ABSORB, 1000)
    end)

    skill:setMsg(xi.msg.basic.NONE)

    return 0
end)

m:addOverride("xi.globals.mobskills.trebuchet.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.trembling.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    local dispelled = math.random(2, 3)

    if info.hitslanded ~= 0 then
        for i = 1, dispelled do
            target:dispelStatusEffect()
        end
    end

    -- TODO: Dispelled messages.  No examples of damage+dispel working to crib notes from.

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end)

m:addOverride("xi.globals.mobskills.tremorous_tread.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded * math.random(2, 3))

    local typeEffect = xi.effect.STUN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 3)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.tremors.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEX_DOWN, 10, 10, 180)
    local damageMod = 1
    if skill:getID() == 1888 then -- Nightmare Worm - increased damage
        damageMod = 3
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN) * damageMod, xi.magic.ele.EARTH, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.tribulation.onMobWeaponSkill", function(target, mob, skill)
    local blinded = false
    local bio = false
    local typeEffect = nil

    blinded = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 20, 0, 120)
    bio = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIO, 39, 0, 120)

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)

    -- display blind first, else bio
    if blinded == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.BLINDNESS
    elseif bio == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.BIO
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.triclip.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEX_DOWN, 10, 10, 180)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.trinary_absorption.onMobWeaponSkill", function(target, mob, skill)
    -- time to drain HP. 50-100
    local power = math.random(0, 151) + 150
    local dmg = xi.mobskills.mobFinalAdjustments(power, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.trinary_tap.onMobWeaponSkill", function(target, mob, skill)
    -- try to drain buff
    local effect1 = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
    local effect2 = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
    local effect3 = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
    local dmg = 0

    if effect1 ~= 0 then
        local count = 1
        if effect2 ~= 0 then
            count = count + 1
        end

        if effect3 ~= 0 then
            count = count + 1
        end

        skill:setMsg(xi.msg.basic.EFFECT_DRAINED)

        return count
    else
        local power = mob:getMainLvl() * 5
        dmg = xi.mobskills.mobFinalAdjustments(power, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

        skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))
        return dmg
    end
end)

m:addOverride("xi.globals.mobskills.triple_attack.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.triumphant_roar.onMobWeaponSkill", function(target, mob, skill)
    local power = 15
    local duration = 90
    local typeEffect = xi.effect.ATTACK_BOOST

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, duration))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.true_strike.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 0.6
    local dmgmod = 1.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.ACC_VARIES, 1.1, 1.2, 1.3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.turbofan.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.SILENCE
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 3, 120)

    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    if target:hasStatusEffect(xi.effect.ELEMENTALRES_DOWN) then
        target:delStatusEffectSilent(xi.effect.ELEMENTALRES_DOWN)
    end

    mob:setLocalVar("nuclearWaste", 0)
    return dmg
end)

m:addOverride("xi.globals.mobskills.turbulence.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WIND, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    return dmg
end)

m:addOverride("xi.globals.mobskills.tusk.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local damageMod = 1

    if skill:getID() == 1859 then -- Nightmare Bugard - Additional damage
        damageMod = 2
    end

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, damageMod, xi.mobskills.magicalTpBonus.NO_EFFECT, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.twirling_dervish.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 3, 5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.typhoon.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.25, 1.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded * math.random(2, 4))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    if mob:getName() == "Faust" then
        if
            mob:getLocalVar("Typhoon") == 0 and
            mob:getTarget() ~= nil and
            mob:checkDistance(mob:getTarget()) <= 10
        then
            mob:useMobAbility(539)
            mob:setLocalVar("Typhoon", 1)
        else
            mob:setLocalVar("Typhoon", 0)
        end
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.typhoon_wing.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BLINDNESS

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 60, 0, 30)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 5, 5, 5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.tyrannic_blare.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.8, xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end)

m:addOverride("xi.globals.mobskills.ultimate_terror.onMobWeaponSkill", function(target, mob, skill)
    -- Diabolos Dynamis Tavnazia -- adds TERROR
    if mob:getZoneID() == xi.zone.DYNAMIS_TAVNAZIA then
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.TERROR, 1, 0, 30)
    end

    local drained = 0
    local threshold = 3 / 7

    local effects =
    {
        { xi.effect.STR_DOWN, 10, 10, 180 },
        { xi.effect.DEX_DOWN, 10, 10, 180 },
        { xi.effect.VIT_DOWN, 10, 10, 180 },
        { xi.effect.AGI_DOWN, 10, 10, 180 },
        { xi.effect.INT_DOWN, 10, 10, 180 },
        { xi.effect.MND_DOWN, 10, 10, 180 },
        { xi.effect.CHR_DOWN, 10, 10, 180 }
    }

    for _, eff in pairs(effects) do
        if math.random() < threshold then
            skill:setMsg(xi.mobskills.mobDrainAttribute(mob, target, eff[1], eff[2], eff[3], eff[4]))
            drained = drained + 1
        end
    end

    return drained
end)

m:addOverride("xi.globals.mobskills.ultrasonics.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.EVASION_DOWN, 25, 0, 180))

    return xi.effect.EVASION_DOWN
end)

m:addOverride("xi.globals.mobskills.ululation.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, math.random(18, 22), 0, 120))

    return xi.effect.PARALYSIS
end)

m:addOverride("xi.globals.mobskills.umbra_smash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 0, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.unblessed_armor.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.SHELL
    local power      = 5000

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, 180))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.unblest_jambiya.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1.3
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.undead_mold.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DISEASE, 1, 0, 660)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end)

m:addOverride("xi.globals.mobskills.uppercut.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local crit = 0.05
    local attmod = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3.25, 3.5, crit, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.uranos_cascade_eta.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.25
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 1, 0, 10)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.uranos_cascade_lambda.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.75
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 1, 0, 10)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.uranos_cascade_theta.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 1, 0, 10)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.vacuous_osculation.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PLAGUE, 5, 3, 30)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, math.min(1, mob:getMainLvl() / 6), 3, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.vampiric_lash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    if mob:getLocalVar("vampiriclashpower") ~= 0 then
        dmgmod = mob:getLocalVar("vampiriclashpower")
    end

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_1)
    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))
    return dmg
end)

m:addOverride("xi.globals.mobskills.vampiric_root.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end)

m:addOverride("xi.globals.mobskills.vanity_dive.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.vanity_drive.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.vanity_strike.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local crit = 0.2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2, crit)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.vapor_spray.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.3, 0.75, xi.magic.ele.WATER, 600)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.velocious_blade.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.venom.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.POISON
    local power = 1

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 240)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WATER, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.venom_breath.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, math.random(35, 50), 3, 60)

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
    return xi.effect.POISON
end)

m:addOverride("xi.globals.mobskills.venom_shell.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 12, 3, 300))

    return xi.effect.POISON
end)

m:addOverride("xi.globals.mobskills.venom_spray.onMobWeaponSkill", function(target, mob, skill)
    local power = 10
    if skill:getID() == 1843 then -- Nightmare Antlion - increased Poison
        power = 50
    end

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 3, 120)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 1.8, xi.magic.ele.WATER, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.venom_sting.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local power = 50
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, power, 3, 30)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.venom_storm.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, math.random(20, 30), 3, 120))

    return xi.effect.POISON
end)

m:addOverride("xi.globals.mobskills.vertical_cleave.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.vertical_slash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.ACCURACY_DOWN, 100, 0, 30)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.vicious_claw.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.victory_beacon.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 4
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5, 3, 4.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.victory_smite.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 4
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1.1, 1.25, 1.45)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.violent_rupture.onMobWeaponSkill", function(target, mob, skill)
    local power = 50
    local duration = 120

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, power, 10, duration)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 1, xi.magic.ele.FIRE, 500)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.viper_bite.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    if not skill:hasMissMsg() then
        target:addStatusEffect(xi.effect.POISON, 3, 3, 60)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.viscid_emission.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AMNESIA, 1, 0, 60))
    return nil
end)

m:addOverride("xi.globals.mobskills.viscid_nectar.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.SLOW
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1250, 0, 120))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.viscid_secretion.onMobWeaponSkill", function(target, mob, skill)
    local slow = xi.effect.SLOW
    local gravity = xi.effect.WEIGHT
    local duration = math.random(120, 180)

    local gravityMessage = xi.mobskills.mobStatusEffectMove(mob, target, gravity, 50, 0, duration)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, slow, 5000, 0, duration))

    if
        skill:getMsg() == xi.msg.basic.SKILL_MISS or
        skill:getMsg() == xi.msg.basic.SKILL_NO_EFFECT
    then
        skill:setMsg(gravityMessage)
        return gravity
    end

    return slow
end)

m:addOverride("xi.globals.mobskills.vitriolic_barrage.onMobWeaponSkill", function(target, mob, skill)
    local needles = 1000 / skill:getTotalTargets()
    local typeEffect = xi.effect.POISON

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 20, 3, 60)

    local dmg = xi.mobskills.mobFinalAdjustments(needles, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.WATER)

    return dmg
end)

m:addOverride("xi.globals.mobskills.vitriolic_shower.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BURN
    local power = math.random(15, 35)

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 60)

    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.7, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    -- NOTE: nil value was undefined MOBPARAM_FIRE
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, nil, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.vitriolic_spray.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BURN
    local power = math.random(10, 30)

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 60)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.7, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.voiceless_storm.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.SILENCE

    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.voidsong.onMobWeaponSkill", function(target, mob, skill)
    mob:eraseAllStatusEffect()
    local count = target:dispelAllStatusEffect()
    count = count + target:eraseAllStatusEffect()

    if count == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    else
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    end

    return count
end)

m:addOverride("xi.globals.mobskills.void_of_repentance.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.TERROR, 1, 0, 30))

    return xi.effect.TERROR
end)

m:addOverride("xi.globals.mobskills.voracious_trunk.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobDrainStatusEffectMove(mob, target))

    return 1
end)

m:addOverride("xi.globals.mobskills.vorpal_blade.onMobWeaponSkill", function(target, mob, skill)
    if mob:getPool() == 4249 then -- Volker@Throne_Room only
        target:showText(mob, zones[xi.zone.THRONE_ROOM].text.BLADE_ANSWER)
    end

    local numhits = 4
    local accmod = 1
    local dmgmod = 1.25
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1.1, 1.2, 1.3)
    local shadows = info.hitslanded

    if
        mob:getFamily() >= 122 and -- Ghrah
        mob:getFamily() <= 124
    then
        shadows = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    end

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, shadows)

    if not skill:hasMissMsg() then
        -- AA EV: Approx 900 damage to 75 DRG/35 THF.  400 to a NIN/WAR in Arhat, but took shadows.
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.vorpal_scythe.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 3, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.vorpal_thrust.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2.5, 2.75, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.vorpal_wheel.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    -- Increase damage as health drops
    local dmgmod = (1 - (mob:getHP() / mob:getMaxHP())) * 6
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.vortex.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded * math.random(2, 3))
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.TERROR, 1, 0, 9)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 1, 0, 30)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        mob:resetEnmity(target)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.vulcan_shot.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 8
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end)

m:addOverride("xi.globals.mobskills.vulture_1.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.vulture_2.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.vulture_3.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.vulture_4.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.wanion.onMobWeaponSkill", function(target, mob, skill)
    -- list of effects to give in AoE
    local effects = { xi.effect.POISON, xi.effect.PARALYSIS, xi.effect.BLINDNESS, xi.effect.SILENCE,
        xi.effect.WEIGHT, xi.effect.SLOW, xi.effect.ADDLE, xi.effect.DIA, xi.effect.BIO, xi.effect.BURN,
        xi.effect.FROST, xi.effect.CHOKE, xi.effect.RASP, xi.effect.SHOCK, xi.effect.DROWN, xi.effect.STR_DOWN,
        xi.effect.DEX_DOWN, xi.effect.VIT_DOWN, xi.effect.AGI_DOWN, xi.effect.INT_DOWN, xi.effect.MND_DOWN,
        xi.effect.CHR_DOWN, xi.effect.ACCURACY_DOWN, xi.effect.ATTACK_DOWN, xi.effect.EVASION_DOWN,
        xi.effect.DEFENSE_DOWN, xi.effect.MAGIC_DEF_DOWN, xi.effect.MAGIC_ACC_DOWN, xi.effect.MAGIC_ATK_DOWN }

    for i, effect in ipairs(effects) do
        if mob:hasStatusEffect(effect) then
            local currentEffect = mob:getStatusEffect(effect)
            xi.mobskills.mobStatusEffectMove(mob, target, effect, currentEffect:getPower(), currentEffect:getTick(), currentEffect:getTimeRemaining() / 1000)
            mob:delStatusEffect(effect)
        end
    end

    skill:setMsg(xi.msg.basic.NONE)
end)

m:addOverride("xi.globals.mobskills.warcry.onMobWeaponSkill", function(target, mob, skill)
    local power = math.floor((mob:getMainLvl() / 4) + 4.75) / 256
    local typeEffect = xi.effect.WARCRY
    local duration = 30

    skill:setMsg(xi.mobskills.mobBuffMove(target, typeEffect, power, 3, duration))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.warm-up.onMobWeaponSkill", function(target, mob, skill)
    -- This is nonsensically overpowering: mob:getMainLvl() + 0.05*mob:getMaxHP()*(skill:getTP() / 1000)
    local power = 10 -- Power needs redone with retail MOB VERSION formula not players blue magic
    local effectID
    local rand = math.random() -- 0 to 1..
    --[[
        After checking retail this mobskill appeared to grant only
        1 of the 2 effects unlike the blue magic version
    ]]
    if mob:hasStatusEffect(xi.effect.ACCURACY_BOOST) then
        skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.EVASION_BOOST, power, 0, 180))
        effectID = xi.effect.EVASION_BOOST
    elseif mob:hasStatusEffect(xi.effect.EVASION_BOOST) then
        skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.ACCURACY_BOOST, power, 0, 180))
        effectID = xi.effect.ACCURACY_BOOST
    else
        if rand < 0.5 then
            skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.EVASION_BOOST, power, 0, 180))
            effectID = xi.effect.EVASION_BOOST
        else
            skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.ACCURACY_BOOST, power, 0, 180))
            effectID = xi.effect.ACCURACY_BOOST
        end
    end

    return effectID
end)

m:addOverride("xi.globals.mobskills.wasp_sting.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:addStatusEffect(xi.effect.POISON, 3, 3, 60)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.water_blade.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.ENWATER
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 65, 0, 60))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.water_bomb.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.SILENCE

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 60)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.5, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.water_ii.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.water_iv.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 8, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end)

m:addOverride("xi.globals.mobskills.water_maneuver.onMobWeaponSkill", function(target, mob, skill)
    local power = 10
    local duration = 60
    local typeEffect = xi.effect.WATER_MANEUVER

    -- Fantoccini (ENM: Pulling the Strings)
    if mob:getPool() == 1296 then
        local pet = GetMobByID(mob:getID() + 1)
        pet:addStatusEffect(typeEffect, power, 0, duration)
    else
        mob:getPet():addStatusEffect(typeEffect, power, 0, duration)
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.water_meeble_warble.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 9, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 50, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DROWN, 50, 3, 60)
    return dmg
end)

m:addOverride("xi.globals.mobskills.water_shield.onMobWeaponSkill", function(target, mob, skill)
    local power = 25
    if skill:getID() == 1869 then -- Nightmare Makara - +50 EVASION_BOOST
        power = 50
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.EVASION_BOOST, power, 0, math.random(120, 600)))

    return xi.effect.EVASION_BOOST
end)

m:addOverride("xi.globals.mobskills.water_wall.onMobWeaponSkill", function(target, mob, skill)
    local power = 100
    if skill:getID() == 1868 then -- Nightmare Makara - Triples DEFENSE_BOOST
        power = 300
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, power, 0, math.random(60, 180)))

    return xi.effect.DEFENSE_BOOST
end)

m:addOverride("xi.globals.mobskills.weapon_bash.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 0.8
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 5)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.wheeling_thrust.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 2, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.wheel_of_impregnability.onMobWeaponSkill", function(target, mob, skill)
    local ID = require("scripts/zones/Empyreal_Paradox/IDs")
    mob:showText(mob, ID.text.PROMATHIA_TEXT + 5)
    -- local typeEffect = xi.effect.PHYSICAL_SHIELD

    mob:addStatusEffect(xi.effect.PHYSICAL_SHIELD, 1, 0, 0)
    mob:setAnimationSub(1)

    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return xi.effect.PHYSICAL_SHIELD
end)

m:addOverride("xi.globals.mobskills.whip_tongue.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local crit = 0.2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5, 2, 2.5, crit)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.whirlwind.onMobWeaponSkill", function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.VIT_DOWN, 10, 10, 180)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WIND, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.whirl_claws.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded * math.random(2, 3))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.whirl_of_rage.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.whispering_wind.onMobWeaponSkill", function(target, mob, skill)
    -- Formula needs redone with retail MOB VERSION not players avatar
    local base = mob:getMobWeaponDmg(xi.slot.MAIN) * mob:getMainLvl() * (skill:getTP() / 1000) --base is around 5~150 level depending
    -- local m = 5
    local multiplier = 1 + (1 - (mob:getHP() / mob:getMaxHP())) * 5    --higher multiplier the lower your HP. at 15% HP, multiplier is 1+0.85*M
    base = base * multiplier

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(target, base)
end)

m:addOverride("xi.globals.mobskills.whispers_of_ire.onMobWeaponSkill", function(target, mob, skill)
    local attributesDown =
    {
        xi.effect.STR_DOWN,
        xi.effect.DEX_DOWN,
        xi.effect.VIT_DOWN,
        xi.effect.AGI_DOWN,
        xi.effect.MND_DOWN,
        xi.effect.INT_DOWN,
        xi.effect.CHR_DOWN,
    }

    local amount = math.random(1, 6)
    local count = 0
    local statsDrained = {}
    local size = amount

    while size > 0 do
        local effectType = math.random(1, 7)
        local check = true

        for i = 1, amount do
            if effectType == statsDrained[i] then
                check = false
            end
        end

        if check then
            xi.mobskills.mobDrainAttribute(mob, target, attributesDown[effectType], 14, 3, 60)
            count = count + 1
            statsDrained[count] = effectType
            size = size - 1
        end
    end

    if count > 0 then
        skill:setMsg(xi.msg.basic.EFFECT_DRAINED)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return count
end)

m:addOverride("xi.globals.mobskills.whispers_of_ire_self.onMobWeaponSkill", function(target, mob, skill)
    local effectcount = mob:eraseAllStatusEffect()

    skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)

    return effectcount
end)

m:addOverride("xi.globals.mobskills.whistle.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(target, xi.effect.AGI_BOOST, 10, 10, 210))

    return xi.effect.AGI_BOOST
end)

m:addOverride("xi.globals.mobskills.white_wind.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.msg.basic.SKILL_RECOVERS_HP)
    -- Todo: verify/correct maths
    return xi.mobskills.mobHealMove(mob, math.floor(mob:getHP() / 7) * 2)
end)

m:addOverride("xi.globals.mobskills.wild_carrot.onMobWeaponSkill", function(target, mob, skill)
    local potency = 104 / 1024

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * potency)
end)

m:addOverride("xi.globals.mobskills.wild_ginseng.onMobWeaponSkill", function(target, mob, skill)
    local duration = math.random(210, 270)
    local regenPower = 30

    -- Bearclaw Rabbit ENM: Follow the White Rabbit
    if mob:getPool() == 384 then
        regenPower = 50
    end

    mob:addStatusEffect(xi.effect.BLINK, 3, 0, duration)
    mob:addStatusEffect(xi.effect.PROTECT, 60, 0, duration)
    mob:addStatusEffect(xi.effect.SHELL, 60, 0, duration)
    mob:addStatusEffect(xi.effect.HASTE, 2000, 0, duration) -- 20% haste
    mob:addStatusEffect(xi.effect.REGEN, regenPower, 3, duration)

    mob:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.BLINK)
end)

m:addOverride("xi.globals.mobskills.wild_horn.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod =  1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.5, 1.75, 2.0)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING,  xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.wild_oats.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.VIT_DOWN, 10, 10, 180)

    return dmg
end)

m:addOverride("xi.globals.mobskills.wild_rage.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2.5, 3)

    -- Platoon Scorpion
    if mob:getPool() == 3157 then
        local ragePower = mob:getLocalVar("wildRagePower")
        info.dmg = info.dmg * (1 + 0.3 * ragePower)
    end

    -- King Vinegrroon
    if mob:getPool() == 2262 then
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, 25, 3, 60)
    end

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded * 2)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end)

m:addOverride("xi.globals.mobskills.winds_of_oblivion.onMobWeaponSkill", function(target, mob, skill)
    local ID = require("scripts/zones/Empyreal_Paradox/IDs")
    mob:showText(mob, ID.text.PROMATHIA_TEXT + 6)
    local typeEffect = xi.effect.AMNESIA
    local power = 30
    local duration = 75

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.winds_of_promyvion.onMobWeaponSkill", function(target, mob, skill)
    local dispel = target:eraseStatusEffect()

    if dispel == xi.effect.NONE then
        -- no effect
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
    end

    return dispel
end)

m:addOverride("xi.globals.mobskills.wind_blade.onMobWeaponSkill", function(target, mob, skill)
    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.wind_blade2.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.ENAERO
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 65, 0, 60))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.wind_breath.onMobWeaponSkill", function(target, mob, skill)
    mob:lookAt(target:getPos())
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.3, 0.75, xi.magic.ele.WIND, 460)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.wind_maneuver.onMobWeaponSkill", function(target, mob, skill)
    local power = 10
    local duration = 60
    local typeEffect = xi.effect.WIND_MANEUVER

    -- Fantoccini (ENM: Pulling the Strings)
    if mob:getPool() == 1296 then
        local pet = GetMobByID(mob:getID() + 1)
        pet:addStatusEffect(typeEffect, power, 0, duration)
    else
        mob:getPet():addStatusEffect(typeEffect, power, 0, duration)
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.wind_shear.onMobWeaponSkill", function(target, mob, skill)
    local numhits = math.random(2, 3)
    local accmod = 1
    local dmgmod = .8
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.wind_shear_znm.onMobWeaponSkill", function(target, mob, skill)
    local numhits = math.random(2, 3)
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.WEIGHT, 50, 0, 120)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.wind_wall.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.EVASION_BOOST
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 50, 0, 60))
    return typeEffect
end)

m:addOverride("xi.globals.mobskills.wings_of_gehenna.onMobWeaponSkill", function(target, mob, skill)
    -- KNOCKBACK

    local typeEffect = xi.effect.STUN

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 4)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.wing_cutter.onMobWeaponSkill", function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WIND, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end)

m:addOverride("xi.globals.mobskills.wing_slap.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 4
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.CRIT_VARIES, 0.25, 0.5, 0.75)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    local typeEffect = xi.effect.STUN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.wing_thrust.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 4
    local accmod = 1

    -- https://docs.google.com/spreadsheets/d/1YBoveP-weMdidrirY-vPDzHyxbEI2ryECINlfCnFkLI/edit#gid=57955395&range=A967
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_BONUS, 0.5, 0.5, 0.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.NONE, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SLOW, 1250, 0, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.wing_whirl.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 4
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.winter_breeze.onMobWeaponSkill", function(target, mob, skill)
    local DISPEL = target:dispelStatusEffect()

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 2)

    if DISPEL == xi.effect.NONE then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
    end

    return DISPEL
end)

m:addOverride("xi.globals.mobskills.wire_cutter.onMobWeaponSkill", function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local crit = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 4, 4, 4, crit)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end)

m:addOverride("xi.globals.mobskills.wisecrack.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.CHARM_I

    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return typeEffect
    end

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 0, 3, 60)
    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        mob:charm(target)
    end

    skill:setMsg(msg)

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.words_of_bane.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_I, 25, 0, 45))

    return xi.effect.CURSE_I
end)

m:addOverride("xi.globals.mobskills.wz_recover_all.onMobWeaponSkill", function(target, mob, skill)
    local recoverHP = target:getMaxHP() - target:getHP()
    local recoverMP = target:getMaxMP() - target:getMP()
    target:addHP(recoverHP)
    target:addMP(recoverMP)
    target:resetRecasts()
    skill:setMsg(xi.msg.basic.RECOVERS_HP_AND_MP)
    return 0
end)

m:addOverride("xi.globals.mobskills.yawn.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.LULLABY

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, math.random(60, 120)))

    return typeEffect
end)

m:addOverride("xi.globals.mobskills.zephyr_arrow.onMobWeaponSkill", function(target, mob, skill)
    local typeEffect = xi.effect.BIND

    local numhits = 1
    local accmod = 4
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 120)

    return dmg
end)

m:addOverride("xi.globals.mobskills.zephyr_mantle.onMobWeaponSkill", function(target, mob, skill)
    local base = math.random(4, 10)
    local typeEffect = xi.effect.BLINK
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, base, 0, 180))
    return typeEffect
end)

return m
