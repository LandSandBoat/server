-----------------------------------
-- Blade Yu
-- Katana weapon skill
-- Skill Level: 290
-- Delivers a water elemental attack. Additional effect Poison. Durration varies with TP.
-- Aligned with the Aqua Gorget & Soil Gorget.
-- Aligned with the Aqua Belt & Soil Belt.
-- Element: Water
-- Modifiers: DEX:50%  INT:50%
-- 100%TP    200%TP    300%TP
-- 2.25      2.25      2.25
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod = { 2.25, 2.25, 2.25 }
    params.dex_wsc = 0.28 params.int_wsc = 0.28
    -- http://wiki.ffo.jp/html/20351.html
    params.ele = xi.element.WATER
    params.skill = xi.skill.KATANA
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 3.0, 3.0, 3.0 }
        params.dex_wsc = 0.4 params.int_wsc = 0.4
    end

    local damage, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    if damage > 0 and not target:hasStatusEffect(xi.effect.POISON) then
        local duration = (75 + (tp / 1000 * 15)) * applyResistanceAddEffect(player, target, xi.element.WATER, 0)
        target:addStatusEffect(xi.effect.POISON, 10, 0, duration)
    end

    return tpHits, extraHits, false, damage
end

return weaponskillObject
