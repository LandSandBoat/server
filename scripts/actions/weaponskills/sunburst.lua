-----------------------------------
-- Sunburst
-- Staff weapon skill
-- Skill Level: 150
-- Deals light or darkness elemental damage. Damage varies with TP.
-- Aligned with the Shadow Gorget & Aqua Gorget.
-- Aligned with the Shadow Belt & Aqua Belt.
-- Element: Light/Dark
-- Modifiers: :    STR:40% MND:40%
-- 100%TP    200%TP    300%TP
-- 1.00      2.50      4.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod = { 1.0, 2.5, 4.0 }
    params.str_wsc = 0.4
    params.mnd_wsc = 0.4
    params.skill = xi.skill.STAFF
    params.includemab = true
    -- 50/50 shot of being light or dark
    params.ele = xi.element.LIGHT
    if math.random() < 0.5 then
        params.ele = xi.element.DARK
    end

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.4 params.mnd_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
