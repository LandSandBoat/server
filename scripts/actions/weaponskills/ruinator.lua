-----------------------------------
-- Ruinator
-- Axe weapon skill
-- Skill level: 357
-- Description: Delivers a four-hit attack. params.accuracy varies with TP
-- In order to obtain Ruinator, the quest Martial Mastery must be completed.
-- This Weapon Skill's first hit params.ftp is duplicated for all additional hits
-- Aligned with the Aqua Gorget, Snow Gorget & Breeze Gorget
-- Aligned with the Aqua Belt, Snow Belt & Breeze Belt.
-- Element: None
-- Modifiers: STR:73~85%, depending on merit points upgrades.
-- 100%TP    200%TP    300%TP
-- 1.08       1.08      1.08
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 4
    params.ftpMod = { 1.08, 1.08, 1.08 }
    params.str_wsc = player:getMerit(xi.merit.RUINATOR) * 0.17
    params.accVaries = { 0.8, 0.9, 1.0 } -- TODO: verify -- "Accuracy varies with TP" in retail. All current evidence points to that this modifier is static values, not percentages.
    params.atkVaries = { 1.1, 1.1, 1.1 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.7 + (player:getMerit(xi.merit.RUINATOR) * 0.03)
        params.multiHitfTP = true
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
