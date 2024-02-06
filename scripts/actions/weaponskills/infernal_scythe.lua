-----------------------------------
-- Infernal Scythe
-- Scythe weapon skill
-- Skill Level: 300
-- Deals darkness elemental damage and lowers target's attack. Duration of effect varies with TP.
-- Attack Down effect is -25% attack.
-- Aligned with the Shadow Gorget & Aqua Gorget.
-- Aligned with the Shadow Belt & Aqua Belt.
-- Element: None
-- Modifiers: STR: 30% INT: 30%
-- 100%TP    200%TP    300%TP
-- 3.50        3.50      3.50
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod = { 3.5, 3.5, 3.5 }
    params.str_wsc = 0.3 params.int_wsc = 0.3
    params.ele = xi.element.DARK
    params.skill = xi.skill.SCYTHE
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.int_wsc = 0.7
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    if damage > 0 and not target:hasStatusEffect(xi.effect.ATTACK_DOWN) then
        local duration = (tp / 1000 * 180) * applyResistanceAddEffect(player, target, xi.element.WATER, 0)
        target:addStatusEffect(xi.effect.ATTACK_DOWN, 25, 0, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
