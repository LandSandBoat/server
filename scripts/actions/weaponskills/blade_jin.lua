-----------------------------------
-- Blade Jin
-- Katana weapon skill
-- Skill Level: 200
-- Delivers a three-hit attack. Chance of params.critical varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Breeze Gorget & Thunder Gorget.
-- Aligned with the Breeze Belt & Thunder Belt.
-- Element: Wind
-- Modifiers: STR:30%  DEX:30%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 3
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.3 params.dex_wsc = 0.3
    params.critVaries = { 0.1, 0.3, 0.5 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 1.375, 1.375, 1.375 }
        params.multiHitfTP = true -- https://www.bg-wiki.com/ffxi/Blade:_Jin
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
