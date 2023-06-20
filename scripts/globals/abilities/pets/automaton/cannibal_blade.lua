-----------------------------------
-- Cannibal Blade
-----------------------------------
require("scripts/globals/automatonweaponskills")
require("scripts/globals/msg")
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
        ftp100 = 0.25,
        ftp200 = 0.4,
        ftp300 = 0.6,
        acc100 = 0.0,
        acc200 = 0.0,
        acc300 = 0.0,
        ignoresDef = true,
        ignored100 = 0.5,
        ignored200 = 0.5,
        ignored300 = 0.5,
        str_wsc = 0.0,
        dex_wsc = 0.0,
        vit_wsc = 0.0,
        agi_wsc = 0.0,
        int_wsc = 0.0,
        mnd_wsc = 0.0,
        chr_wsc = 0.0
    }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.weaponDamage = nil
        params.mnd_wsc = 1.0
        params.ftp100 = 16.0
        params.ftp200 = 23.5
        params.ftp300 = 31.5
    end

    if automaton:checkDistance(target) > 7 then
        if params.weaponDamage then
            params.weaponDamage = params.weaponDamage / 4
        else
            params.ftp100 = params.ftp100 / 4
            params.ftp200 = params.ftp200 / 4
            params.ftp300 = params.ftp300 / 4
        end
    end

    local damage = doAutoPhysicalWeaponskill(automaton, target, 0, skill:getTP(), true, action, false, params, skill)

    if damage > 0 then
        if not target:isUndead() then
            automaton:addHP(damage)
            skill:setMsg(xi.msg.basic.SKILL_DRAIN_HP)
        end
    end

    return damage
end

return abilityObject
