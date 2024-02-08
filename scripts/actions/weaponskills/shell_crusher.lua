-----------------------------------
-- Shell Crusher
-- Staff weapon skill
-- Skill Level: 175
-- Lowers target's defense. Duration of effect varies with TP.
-- If unresisted, lowers target defense by 25%.
-- Will stack with Sneak Attack.
-- Aligned with the Breeze Gorget.
-- Aligned with the Breeze Belt.
-- Element: None
-- Modifiers: STR:100%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.35

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 1.0
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 and not target:hasStatusEffect(xi.effect.DEFENSE_DOWN) then
        local duration = (120 + (tp / 1000 * 60)) * applyResistanceAddEffect(player, target, xi.element.WIND, 0)
        target:addStatusEffect(xi.effect.DEFENSE_DOWN, 25, 0, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
