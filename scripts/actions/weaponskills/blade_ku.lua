-----------------------------------
-- Blade Ku
-- Katana weapon skill
-- Skill level: N/A
-- Description: Delivers a five-hit attack. params.accuracy varies with TP.
-- In order to obtain Blade: Ku, the quest Bugi Soden must be completed.
-- Will stack with Sneak Attack.
-- Aligned with the Shadow Gorget, Soil Gorget & Light Gorget.
-- Aligned with the Shadow Belt, Soil Belt & Light Belt.
-- Skillchain Properties: Gravitation/Transfixion
-- Modifiers: STR:10%  DEX:10%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
--         params.acc
-- 100%TP    200%TP    300%TP
-- ??        ??        ??
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 5
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.1 params.dex_wsc = 0.1
    -- Sufficient data for ACC bonus/penalty does not exist; assuming no penalty and 10% increase per 1000 TP
    -- http://wiki.ffo.jp/html/732.html does not list ACC Bonus
    -- https://www.bg-wiki.com/ffxi/Blade:_Ku does not list ACC Bonus
    params.accVaries = { 1.0, 1.1, 1.2 } -- TODO: verify -- "Accuracy varies with TP" in retail. All current evidence points to that this modifier is static values, not percentages.

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 1.25, 1.25, 1.25 }
        params.str_wsc = 0.3 params.dex_wsc = 0.3
        params.multiHitfTP = true
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
