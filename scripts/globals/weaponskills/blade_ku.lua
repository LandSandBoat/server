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
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 5
    params.ftp100 = 1.0 params.ftp200 = 1.0 params.ftp300 = 1.0
    params.str_wsc = 0.1 params.dex_wsc = 0.1 params.vit_wsc = 0.0
    params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    -- Sufficient data for ACC bonus/penalty does not exist; assuming no penalty and 10% increase per 1000 TP
    -- http://wiki.ffo.jp/html/732.html does not list ACC Bonus
    -- https://www.bg-wiki.com/ffxi/Blade:_Ku does not list ACC Bonus
    params.acc100 = 1.0 params.acc200 = 1.1 params.acc300 = 1.2 -- TODO: verify -- "Accuracy varies with TP" in retail. All current evidence points to that this modifier is static values, not percentages.
    params.atk100 = 1.0 params.atk200 = 1.0 params.atk300 = 1.0

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 1.25 params.ftp200 = 1.25 params.ftp300 = 1.25
        params.str_wsc = 0.3 params.dex_wsc = 0.3
        params.multiHitfTP = true
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
