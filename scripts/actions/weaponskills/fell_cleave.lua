-----------------------------------
-- Fell Cleave
-- Great Axe weapon skill
-- Skill Level: 300
-- Delivers an area attack. Radius varies with TP.
-- Aligned with the Breeze Gorget, Thunder Gorget & Soil Gorget.
-- Aligned with the Breeze Belt, Thunder Belt & Soil Belt.
-- Element: None
-- Modifiers: STR: 60%
-- 100%TP    200%TP    300%TP
-- 2.00        2.00      2.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 2.0, 2.0, 2.0 }
    params.str_wsc = 0.6

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 2.75, 2.75, 2.75 }
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
