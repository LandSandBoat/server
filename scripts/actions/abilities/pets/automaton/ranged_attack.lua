-----------------------------------
-- Ranged Attack
-----------------------------------
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    local params =
    {
        numHits = 1,
        atkmulti = 1.5,
        ftpMod = { 1.0, 1.0, 1.0 },
        str_wsc = 0.5,
        dex_wsc = 0.25,
    }

    local damage = xi.autows.doAutoRangedWeaponskill(automaton, target, 0, params, 1000, true, skill, action)

    return damage
end

return abilityObject
