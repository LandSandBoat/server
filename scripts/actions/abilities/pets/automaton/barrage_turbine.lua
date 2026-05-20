-----------------------------------
-- Barrage Turbine
-- https://www.bg-wiki.com/ffxi/Barrage_Turbine
-- https://wiki.ffo.jp/html/23698.html
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 60 * 3)

    -- Apply overload.
    -- TODO: This is a placeholder that adds zero overload for now.
    --       For reference, the full maneuver handling is xi.automaton.onUseManeuver.
    -- local overload = automaton:addBurden(xi.element.WIND - 1, 0)

    local windManeuvers = master:countEffect(xi.effect.WIND_MANEUVER)
    windManeuvers = utils.clamp(windManeuvers, 0, 3)

    -- Shots per wind maneuver.
    local shotCount =
    {
        [1] = 4,
        [2] = 6,
        [3] = 9,
    }

    -- Barrage set up and execution.
    local params =
    {
        numHits   = shotCount[windManeuvers],
        isBarrage = true,
        atkmulti  = 1.5,
        ftpMod    = { 1.0, 1.0, 1.0 },
        str_wsc   = 0.5,
        dex_wsc   = 0.25,
    }

    -- TODO: Remove/adjust the 8 hit weaponskill cap; tweak damage and TP return.
    local damage = xi.autows.doAutoRangedWeaponskill(automaton, target, 0, params, 1000, true, skill, action)

    return damage
end

return abilityObject
