-----------------------------------
-- Nightmare Scythe
-- Scythe weapon skill
-- Skill Level: 100
-- Blinds enemy. Duration of effect varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Shadow Gorget & Soil Gorget.
-- Aligned with the Shadow Belt & Soil Belt.
-- Element: None
-- Modifiers: STR:60%  MND:60%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.3 params.mnd_wsc = 0.3

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.6 params.mnd_wsc = 0.6
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 and not target:hasStatusEffect(xi.effect.BLINDNESS) then
        local duration = (tp / 1000 * 60) * applyResistanceAddEffect(player, target, xi.element.DARK, 0)
        target:addStatusEffect(xi.effect.BLINDNESS, 15, 0, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
