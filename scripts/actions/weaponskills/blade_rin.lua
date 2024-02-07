-----------------------------------
-- Blade Rin
-- Katana weapon skill
-- Skill Level: 5
-- Delivers a single-hit attack. Chance of params.critical varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Light Gorget.
-- Aligned with the Light Belt.
-- Element: None
-- Modifiers: STR:20%  DEX:20%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.2 params.dex_wsc = 0.2
    -- TODO: critical hit rate of this ws is base on amount of tp alone, does not consider Critical Hit Rate from dDEX, equipment, or likely merits/base
    -- https://www.bg-wiki.com/ffxi/Blade:_Rin
    params.critVaries = { 0.3, 0.6, 0.9 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.6 params.dex_wsc = 0.6
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
