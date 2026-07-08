-----------------------------------
-- Knockout
-- Delivers a single hit attack. Damage varies with TP. Additional Effect : Evasion Down.
-- Weaponskill is forced by a Wind Maneuver.
-- https://www.bg-wiki.com/ffxi/Knockout (Adoulin)
-- https://web.archive.org/web/20100401051051/https://www.geocities.jp/pupff/other/knockout.html (Original)
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    local master = automaton:getMaster()

    if not master then
        return
    end

    return master:countEffect(xi.effect.WIND_MANEUVER)
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    local params = {}

    params.numHits          = utils.clamp(1 + xi.automaton.getExtraHits(automaton, 1), 1, 8)
    params.fTP              = { 4.0, 4.5, 5.0 }
    params.agi_wSC          = 0.85
    params.accuracyModifier = { 50, 50, 50 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.BLUNT
    params.shadowBehavior   = params.numHits

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.agi_wSC = 1.0
        params.fTP     = { 6.0, 8.5, 11.0 }
    end

    xi.automaton.applyFlameHolder(automaton, params.fTP)

    local info = xi.mobskills.mobPhysicalMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(automaton, target, xi.effect.EVASION_DOWN, 20, 0, 30)
    end

    return info.damage
end

return abilityObject
