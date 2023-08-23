-----------------------------------
--  Pinecone Bomb
--
--  Description: Single target damage with sleep.
--
--  Notes: When used by Cemetery Cherry, and leafless Jidra: Doesn't cause sleep but does ~600 damage
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
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
end

return mobskillObject
