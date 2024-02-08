-----------------------------------
-- Armor Piercer
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
        atkmulti = 1.5,
        accBonus = 100,
        ftpMod = { 3.0, 3.0, 3.0 },
        ignoredDefense = { 0.4, 0.5, 0.7 },
        dex_wsc = 0.6,
    }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod         = { 4.0, 5.5, 7.0 }
        params.ignoredDefense = { 0.5, 0.5, 0.5 }
    end

    local damage = xi.autows.doAutoRangedWeaponskill(automaton, target, 0, params, skill:getTP(), true, skill, action)

    return damage
end

return abilityObject
