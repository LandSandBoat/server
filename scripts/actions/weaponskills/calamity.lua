-----------------------------------
-- Calamity
-- Axe weapon skill
-- Skill level: 200 (Beastmasters and Warriors only.)
-- Delivers a single-hit attack. Damage varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Soil Gorget & Thunder Gorget.
-- Aligned with the Soil Belt & Thunder Belt.
-- Element: None
-- Modifiers: STR:32%  VIT:32%
-- 100%TP    200%TP    300%TP
-- 1.00      1.50      4.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.5, 4.0 }
    params.str_wsc = 0.32 params.vit_wsc = 0.32

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 2.5, 6.5, 10.375 }
        params.str_wsc = 0.5 params.vit_wsc = 0.5
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
