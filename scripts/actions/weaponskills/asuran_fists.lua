-----------------------------------
-- Asuran Fists
-- Hand-to-Hand weapon skill
-- Skill Level: 250
-- Delivers an eightfold attack. params.accuracy varies with TP.
-- In order to obtain Asuran Fists, the quest The Walls of Your Mind must be completed.
-- Due to the 95% params.accuracy cap there is only a 66% chance of all 8 hits landing, so approximately a one third chance of missing some of the hits at the cap.
-- Will stack with Sneak Attack.
-- Aligned with the Shadow Gorget, Soil Gorget & Flame Gorget.
-- Aligned with the Shadow Belt, Soil Belt & Flame Belt.
-- Element: None
-- Modifiers: STR:10%  VIT:10%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 8
    params.ftpMod = { 1, 1, 1 }
    params.str_wsc = 0.1 params.vit_wsc = 0.1
    params.accVaries = { 0.8, 0.9, 1.0 } -- TODO: verify -- "Accuracy varies with TP" in retail. All current evidence points to that this modifier is static values, not percentages.

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.multiHitfTP = true -- http://wiki.ffo.jp/html/2424.html
        params.str_wsc = 0.15 params.vit_wsc = 0.15
        params.ftpMod = { 1.25, 1.25, 1.25 }
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
