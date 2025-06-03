-----------------------------------
-- Flat Blade
--
-- Description: Stuns enemy. Chance of stunning varies with TP.
-- Type: Physical
-- Utsusemi/Blink absorb: Shadow per hit
-- Range: Melee
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getPool() ~= 4006 then
        mob:messageBasic(xi.msg.basic.READIES_WS, 0, 35)
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if mob:getPool() == 4006 then -- Trion@Qubia_Arena only
        target:showText(mob, zones[xi.zone.QUBIA_ARENA].text.FLAT_LAND)
    end

    local numhits = 1
    local accmod = 1
    local ftp    = 1.25
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1.1, 1.2, 1.3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if math.random(1, 100) < skill:getTP() / 3 then
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)
    end

    -- AA EV: Approx 900 damage to 75 DRG/35 THF.  400 to a NIN/WAR in Arhat, but took shadows.
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
