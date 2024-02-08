-----------------------------------
-- Cannibal Blade
-----------------------------------
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    local master = automaton:getMaster()
    return master:countEffect(xi.effect.DARK_MANEUVER)
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    local params =
    {
        numHits = 1,
        atkmulti = 20.0,
        accBonus = 1000,
        weaponDamage = automaton:getSkillLevel(xi.skill.AUTOMATON_MELEE),
        weaponType = xi.skill.SWORD,
        ftpMod = { 0.25, 0.4, 0.6 },
        ignoredDefense = { 0.5, 0.5, 0.5 },
    }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.weaponDamage = nil
        params.ftpMod = { 16.0, 23.5, 31.5 }
        params.mnd_wsc = 1.0
    end

    if automaton:checkDistance(target) > 7 then
        if params.weaponDamage then
            params.weaponDamage = params.weaponDamage / 4
        else
            params.ftpMod[1] = params.ftpMod[1] / 4
            params.ftpMod[2] = params.ftpMod[2] / 4
            params.ftpMod[3] = params.ftpMod[3] / 4
        end
    end

    local damage = xi.autows.doAutoPhysicalWeaponskill(automaton, target, 0, skill:getTP(), true, action, false, params, skill)

    if damage > 0 then
        if not target:isUndead() then
            automaton:addHP(damage)
            skill:setMsg(xi.msg.basic.SKILL_DRAIN_HP)
        end
    end

    return damage
end

return abilityObject
