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
    local params      = {}
    params.numHits    = 3
    params.weaponType = xi.skill.CLUB
    params.ftpMod     = { 1.0, 1.0, 1.0 }
    params.str_wsc    = 0.2
    params.dex_wsc    = 0.2
    params.accBonus   = math.floor(xi.weaponskills.fTP(skill:getTP(), { 0, 30, 50 }))

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod   = { 2.66, 2.66, 2.66 }
        params.str_wsc    = 0.3
        params.dex_wsc    = 0.3
        params.accBonus = math.floor(xi.weaponskills.fTP(skill:getTP(), { 0, 40, 80 }))
    end

    local damage = xi.autows.doAutoPhysicalWeaponskill(automaton, target, 0, skill:getTP(), true, action, false, params, skill)

    return damage
end

return abilityObject
