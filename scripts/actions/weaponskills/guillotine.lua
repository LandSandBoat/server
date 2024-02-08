-----------------------------------
-- Guillotine
-- Scythe weapon skill
-- Skill level: 200
-- Delivers a four-hit attack. Duration varies with TP.
-- Modifiers: STR:25%  MND:25%
-- 100%TP     200%TP     300%TP
-- 0.875    0.875    0.875
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 4
    params.ftpMod = { 0.875, 0.875, 0.875 }
    -- wscs are in % so 0.2=20%
    params.str_wsc = 0.25 params.mnd_wsc = 0.25

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.3 params.mnd_wsc = 0.5
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 and not target:hasStatusEffect(xi.effect.SILENCE) then
        local duration = (30 + (tp / 1000 * 30)) * applyResistanceAddEffect(player, target, xi.element.WIND, 0)
        target:addStatusEffect(xi.effect.SILENCE, 1, 0, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
