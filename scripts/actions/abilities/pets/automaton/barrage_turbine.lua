-----------------------------------
-- Barrage Turbine
-- https://www.bg-wiki.com/ffxi/Barrage_Turbine
-- https://wiki.ffo.jp/html/23698.html
-- TODO : Find out if shots from this do not return full TP.
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

-- Barrage projectiles per Wind Maneuver
local shotCount =
{
    [1] = 4,
    [2] = 6,
    [3] = 9,
}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 180)

    local windManeuvers = master:countEffect(xi.effect.WIND_MANEUVER)

    local params = {}

    params.baseDamage      = xi.automaton.getRangedBaseDamage(automaton)
    params.numHits         = shotCount[windManeuvers] or 1
    params.fTP             = { 1.0, 1.0, 1.0 }
    params.str_wSC         = 0.50
    params.dex_wSC         = 0.25
    params.attackType      = xi.attackType.RANGED
    params.damageType      = xi.damageType.PIERCING
    params.shadowBehavior  = params.numHits
    params.skipParry       = true
    params.skipGuard       = true
    params.skipBlock       = true
    params.terminateOnMiss = true

    local info = xi.mobskills.mobRangedMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)
    end

    return info.damage
end

return abilityObject
