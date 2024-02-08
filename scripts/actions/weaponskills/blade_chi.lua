-----------------------------------
-- Blade Chi
-- Katana weapon skill
-- Skill Level: 150
-- Delivers a two-hit earth elemental attack. Damage varies with TP.
-- Aligned with the Thunder Gorget & Light Gorget.
-- Aligned with the Thunder Belt & Light Belt.
-- Element: Earth
-- Modifiers: STR:30%  INT:30%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod = { 0.5, 0.75, 1.0 }
    params.str_wsc = 0.2 params.int_wsc = 0.2
    params.hybridWS = true
    params.ele = xi.element.EARTH
    params.skill = xi.skill.KATANA
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        -- http://wiki.ffo.jp/html/720.html
        params.ftpMod = { 0.5, 1.375, 2.25 }
        params.str_wsc = 0.3 params.int_wsc = 0.3
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
