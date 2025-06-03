-----------------------------------
-- Vorpal Blade
--
-- Description: Delivers a four-hit attack. Chance of critical varies with TP.
-- Type: Physical
-- Utsusemi/Blink absorb: Shadow per hit
-- Range: Melee
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- Check for Grah Family id 122, 123, 124
    -- if not in Paladin form, then ignore.
    if
        (mob:getFamily() == 122 or mob:getFamily() == 123 or mob:getFamily() == 124) and
        mob:getAnimationSub() ~= 1
    then
        return 1
    elseif mob:getFamily() == 176 then
        -- Handle Mamool Ja BLU
        if mob:getAnimationSub() == 0 and mob:getMainJob() == xi.job.BLU then
            return 0
        else
            return 1
        end
    elseif mob:getPool() ~= 4249 then
        mob:messageBasic(xi.msg.basic.READIES_WS, 0, 40)
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if mob:getPool() == 4249 then -- Volker@Throne_Room only
        target:showText(mob, zones[xi.zone.THRONE_ROOM].text.BLADE_ANSWER)
    end

    local numhits = 4
    local accmod = 1
    local ftp    = 1.25
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1.1, 1.2, 1.3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    -- AA EV: Approx 900 damage to 75 DRG/35 THF.  400 to a NIN/WAR in Arhat, but took shadows.
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
