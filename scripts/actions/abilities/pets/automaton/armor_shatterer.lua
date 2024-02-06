-----------------------------------
-- Armor Shatterer
-----------------------------------
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    local master = automaton:getMaster()
    return master:countEffect(xi.effect.WIND_MANEUVER)
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    local params =
    {
        numHits = 2,
        atkmulti = 2.25,
        accBonus = 50,
        ftpMod = { 6.0, 6.0, 6.0 },
        dex_wsc = 0.5,
    }

    local damage = xi.autows.doAutoRangedWeaponskill(automaton, target, 0, params, skill:getTP(), true, skill, action)

    if damage > 0 then
        local bonusduration = 1 + 0.00033 * (skill:getTP() - 1000)
        if not target:hasStatusEffect(xi.effect.DEFENSE_DOWN) then
            target:addStatusEffect(xi.effect.DEFENSE_DOWN, 15, 0, 90 * bonusduration)
        end
    end

    return damage
end

return abilityObject
