-----------------------------------
-- String Shredder
-----------------------------------
require("scripts/globals/automatonweaponskills")
-----------------------------------
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    local master = automaton:getMaster()
    return master:countEffect(xi.effect.THUNDER_MANEUVER)
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    local params =
    {
        numHits = 2,
        atkmulti = 1.36,
        weaponType = xi.skill.SWORD,
        ftp100 = 1.5,
        ftp200 = 1.5,
        ftp300 = 1.5,
        acc100 = 0.0,
        acc200 = 0.0,
        acc300 = 0.0,
        canCrit = true,
        crit100 = 0.2,
        crit200 = 0.4,
        crit300 = 0.7,
        str_wsc = 0.0,
        dex_wsc = 0.0,
        vit_wsc = 0.5,
        agi_wsc = 0.0,
        int_wsc = 0.0,
        mnd_wsc = 0.0,
        chr_wsc = 0.0
    }

    local damage = doAutoPhysicalWeaponskill(automaton, target, 0, skill:getTP(), true, action, false, params, skill)

    return damage
end

return abilityObject
