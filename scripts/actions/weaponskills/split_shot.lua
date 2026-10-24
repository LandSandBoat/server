-----------------------------------
-- Split Shot
-- Marksmanship weapon skill
-- Skill Level: 40
-- Ignores enemy's defense. Amount ignored varies with TP.
-- The amount of defense ignored is 0% @ 100TP, 35% @ 200TP and 50% @ 300TP.
-- Aligned with the Aqua Gorget & Light Gorget.
-- Aligned with the Aqua Belt & Light Belt.
-- Element: None
-- Modifiers: AGI:70%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params               = {}
    params.numHits             = 1
    params.ftpMod              = { 1.0, 1.0, 1.0 }
    params.agi_wsc             = 0.3
    params.ignoredDefense      = { 0.0, 0.35, 0.5 } -- BG
    params.rangedAccuracyBonus = 30 -- https://www.ffxiah.com/forum/topic/52018/luck-of-the-draw-a-corsairs-guide-new/127/#3726841

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.agi_wsc = 0.7
        params.ignoredDefense = { 0.0, 0.375, 0.75 } -- DAT, BG says 0, 35, 50
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
