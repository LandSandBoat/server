-----------------------------------
-- Blade Ten
-- Katana weapon skill
-- Skill Level: 225
-- Delivers a single-hit attack. Damage varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Shadow Gorget & Soil Gorget.
-- Aligned with the Shadow Belt & Soil Belt.
-- Element: None
-- Modifiers: STR:30%  DEX:30%
-- 100%TP    200%TP    300%TP
-- 2.50      2.75      3.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 2.5, 2.75, 3.0 }
    params.str_wsc = 0.3 params.dex_wsc = 0.3

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 4.5, 11.5, 15.5 }
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
