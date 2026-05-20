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
    local params      = {}
    params.numHits    = 1
    params.weaponType = xi.skill.CLUB
    params.ftpMod     = { 4.0, 4.5, 5.0 }
    params.agi_wsc    = 0.85
    params.accBonus   = 50

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.agi_wsc = 1.0
        params.ftpMod = { 6.0, 8.5, 11.0 }
    end

    local damage = xi.autows.doAutoPhysicalWeaponskill(automaton, target, 0, skill:getTP(), true, action, false, params, skill)

    -- Handle status effect
    local effectId      = xi.effect.EVASION_DOWN
    local actionElement = xi.element.WIND
    local skillType     = xi.skill.AUTOMATON_MELEE
    local power         = 20
    local resist        = xi.combat.magicHitRate.calculateResistRate(automaton, target, 0, skillType, 0, actionElement, 0, effectId, 0)
    local duration      = math.floor(30 * resist)
    xi.weaponskills.handleWeaponskillEffect(automaton, target, effectId, actionElement, damage, power, duration)

    return damage
end

return abilityObject
