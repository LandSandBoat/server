-----------------------------------
-- Dancing Edge
-- Dagger weapon skill
-- Skill level: 200
-- Delivers a fivefold attack. params.accuracy varies with TP.
-- Will stack with Sneak Attack.
-- Will stack with Trick Attack.
-- Aligned with the Breeze Gorget & Soil Gorget.
-- Aligned with the Breeze Belt & Soil Belt.
-- Element: None
-- Modifiers: DEX:30%  CHR:40%
-- 100%TP    200%TP    300%TP
-- 1.19      1.19      1.19
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 5
    params.ftpMod = { 1.1875, 1.1875, 1.1875 }
    params.dex_wsc = 0.3 params.chr_wsc = 0.4
    params.accVaries = { 0, 30, 60 } -- TODO: verify exact number

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.dex_wsc = 0.4
        params.multiHitfTP = true -- http://wiki.ffo.jp/html/688.html
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
