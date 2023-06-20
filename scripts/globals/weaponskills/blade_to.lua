-----------------------------------
-- Blade To
-- Katana weapon skill
-- Skill Level: 100
-- Deals ice elemental damage. Damage varies with TP.
-- Aligned with the Snow Gorget & Breeze Gorget.
-- Aligned with the Snow Belt & Breeze Belt.
-- Element: Ice
-- Modifiers: STR:30%  INT:30%
-- 100%TP    200%TP    300%TP
-- 0.50      0.75      1.00
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftp100 = 0.5 params.ftp200 = 0.75 params.ftp300 = 1
    params.str_wsc = 0.3 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.3 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1
    params.hybridWS = true
    params.ele = xi.magic.ele.ICE
    params.skill = xi.skill.KATANA
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.4 params.int_wsc = 0.4
        params.ftp200 = 1.5 params.ftp300 = 2.5 -- http://wiki.ffo.jp/html/719.html
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
