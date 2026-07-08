-----------------------------------
-- Slapstick
-- Delivers a threefold attack. Accuracy varies with TP.
-- Weaponskill is forced by a Thunder Maneuver.
-- https://www.bg-wiki.com/ffxi/Slapstick (Adoulin)
-- https://web.archive.org/web/20100401153524/https://www.geocities.jp/pupff/other/slapstick.html (Original)
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    local master = automaton:getMaster()

    if not master then
        return
    end

    return master:countEffect(xi.effect.THUNDER_MANEUVER)
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    local params = {}

    params.numHits          = utils.clamp(3 + xi.automaton.getExtraHits(automaton, 3), 1, 8)
    params.fTP              = { 1.0, 1.0, 1.0 }
    params.str_wSC          = 0.20
    params.dex_wSC          = 0.20
    params.accuracyModifier = { 0, 30, 50 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.BLUNT
    params.shadowBehavior   = params.numHits

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.fTP              = { 2.66, 2.66, 2.66 }
        params.str_wSC          = 0.30
        params.dex_wSC          = 0.30
        params.accuracyModifier = { 0, 40, 80 }
    end

    xi.automaton.applyFlameHolder(automaton, params.fTP)

    local info = xi.mobskills.mobPhysicalMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)
    end

    return info.damage
end

return abilityObject
