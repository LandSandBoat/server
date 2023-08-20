-----------------------------------
-- Daze
-----------------------------------
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    local master = automaton:getMaster()
    return master:countEffect(xi.effect.THUNDER_MANEUVER)
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    local params =
    {
        numHits = 1,
        atkmulti = 1,
        accBonus = 150,
        ftp100 = 5.0,
        ftp200 = 5.5,
        ftp300 = 6.0,
        acc100 = 0.0,
        acc200 = 0.0,
        acc300 = 0.0,
        str_wsc = 0.0,
        dex_wsc = 0.0,
        vit_wsc = 0.0,
        agi_wsc = 0.0,
        int_wsc = 0.0,
        mnd_wsc = 0.0,
        chr_wsc = 0.0
    }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.dex_wsc = 1.0
        params.ftp100 = 6.0
        params.ftp200 = 8.5
        params.ftp300 = 11.0
    end

    local damage = xi.autows.doAutoRangedWeaponskill(automaton, target, 0, params, skill:getTP(), true, skill, action)

    if damage > 0 then
        local chance = 0.033 * skill:getTP()
        if
            not target:hasStatusEffect(xi.effect.STUN) and
            chance >= math.random() * 100
        then
            target:addStatusEffect(xi.effect.STUN, 1, 0, 4)
        end
    end

    return damage
end

return abilityObject
