---------------------------------------------
--  Everyones Grudge
--
--  Notes: Invokes collective hatred to spite a single target.
--   Damage done is 5x the amount of tonberries you have killed! For NM's using this it is 50 x damage.
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:isNM() then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local realDmg = 0
    local power = 5

    if target:getID() > 100000 then
        realDmg = power * math.random(30, 100)
    else
        realDmg = power * target:getCharVar("EVERYONES_GRUDGE_KILLS") -- Damage is 5 times the amount you have killed
        if mob:isNM() then
            realDmg = realDmg * 10 -- sets the multiplier to 50 for NM's
        end
    end

    target:takeDamage(realDmg, mob, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL)

    return realDmg
end
