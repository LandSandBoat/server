---------------------------------------------
-- Everyone's Rancor
--
-- Notes: Invokes rancor to spite a single target.
--
-- Damage is 50x the amount of Tonberries slain.
-- Only used by certain NMs, generally only once
-- and when they have reached a certain percentage
-- of HP (usually 25%).
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:isNM() and mob:getHP() / mob:getMaxHP() <= 0.25 and mob:getLocalVar("everyonesRancorUsed") == 0 then
        mob:setLocalVar("everyonesRancorUsed", 1)
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local realDmg = 0

    if target:getID() > 100000 then
        realDmg = 50 * math.random(50, 100)
    else
        realDmg = 50 * target:getCharVar("EVERYONES_GRUDGE_KILLS")
    end

    target:takeDamage(realDmg, mob, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL)

    return realDmg
end
