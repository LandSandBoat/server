-----------------------------------
-- Citadel Buster
-- Deals extreme Light damage to players in an area of effect.
-- Additional effect: Enmity reset
-- Damage can be approximated based on Calculating Weapon Skill Damage as a magical WS with a level of 85, fTP of 6 and MAB of 4.0. Or, more simply:
-- 2088/(1+MDB%) * (256-MDT)/256 (no day/weather bonus)
-- 2608/MDB * (256-MDT)/256 (weather bonus)
-- 2816/MDB * (256-MDT)/256 (day+weather bonus)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local basedmg = 2088

    if
        mob:getWeather() == xi.weather.AURORAS or
        mob:getWeather() == xi.weather.STELLAR_GLARE
    then
        basedmg = basedmg + 520
    end

    if VanadielDayElement() == xi.element.LIGHT then
        basedmg = basedmg + 208
    end

    local damage = basedmg / (1 + (target:getMod(xi.mod.MDEF) / 100))
    local dmg = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    mob:resetEnmity(target)

    return dmg
end

return mobskillObject
