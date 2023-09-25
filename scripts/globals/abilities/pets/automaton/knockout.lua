-----------------------------------
-- Knockout
-----------------------------------
require("scripts/globals/automatonweaponskills")
-----------------------------------
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    local master = automaton:getMaster()
    return master:countEffect(xi.effect.WIND_MANEUVER)
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    local params =
    {
        numHits = 1,
        atkmulti = 1,
        accBonus = 50,
        weaponType = xi.skill.CLUB,
        ftp100 = 4.0,
        ftp200 = 5.0,
        ftp300 = 5.5,
        acc100 = 0.0,
        acc200 = 0.0,
        acc300 = 0.0,
        str_wsc = 0.0,
        dex_wsc = 0.0,
        vit_wsc = 0.0,
        agi_wsc = 0.0,
        int_wsc = 0.0,
        mnd_wsc = 0.0,
        chr_wsc = 0.0
    }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.agi_wsc = 1.0
        params.ftp100 = 6.0
        params.ftp200 = 8.5
        params.ftp300 = 11.0
    end

    local damage = doAutoPhysicalWeaponskill(automaton, target, 0, skill:getTP(), true, action, false, params, skill)

    if damage > 0 then
        if not target:hasStatusEffect(xi.effect.EVASION_DOWN) then
            target:addStatusEffect(xi.effect.EVASION_DOWN, 10, 0, 30)
        end
    end

    return damage
end

return abilityObject
