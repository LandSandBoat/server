-----------------------------------
-- Blade Ei
-- Katana weapon skill
-- Skill Level: 175
-- Delivers a dark elemental attack. Damage varies with TP.
-- Aligned with the Shadow Gorget.
-- Aligned with the Shadow Belt.
-- Element: Dark
-- Modifiers: STR:30%  INT:30%
-- 100%TP    200%TP    300%TP
-- 1.00      1.50      2.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod = { 1.0, 1.5, 2.0 }
    params.str_wsc = 0.3 params.int_wsc = 0.3
    params.ele = xi.element.DARK
    params.skill = xi.skill.KATANA
    params.includemab = true

    -- to do ignore shadow and blink https://www.bg-wiki.com/ffxi/Blade:_Ei
    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.4 params.int_wsc = 0.4
        params.ftpMod = { 1.0, 3.0, 5.0 }
    end

    local damage, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, false, damage
end

return weaponskillObject
