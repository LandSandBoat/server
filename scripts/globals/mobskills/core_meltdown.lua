---------------------------------------------------
-- Core Meltdown (Ghrah)
-- Reactor core fails and self-destructs, damaging any nearby targets.
-- Note: Very rare, estimated 5% chance
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:isMobType(MOBTYPE_NOTORIOUS)) then
        return 1
    elseif (mob:AnimationSub() ~=0) then -- form check
        return 1
    elseif (math.random(1, 100) >= 5) then -- here's the 95% chance to not blow up
        return 1
    else
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1

    -- TODO: The damage type should be based off of the Ghrah's element
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*math.random(7, 15), tpz.magic.ele.NONE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL, MOBPARAM_IGNORE_SHADOWS)
    mob:setHP(0)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL)
    return dmg
end
