-----------------------------------
-- Resolution
-- Great Sword weapon skill
-- Skill Level: 357
-- Delivers a fivefold attack. Damage varies with TP.
-- In order to obtain Resolution, the quest Martial Mastery must be completed.
-- This Weapon Skill's first hit params.ftp is duplicated for all additional hits.
-- Resolution has an attack penalty of -8%.
-- Aligned with the Breeze Gorget, Thunder Gorget & Soil Gorget.
-- Aligned with the Breeze Belt, Thunder Belt & Soil Belt.
-- Element: None
-- Modifiers: STR:73~85%, depending on merit points upgrades.
-- 100%TP    200%TP    300%TP
-- 0.71875    1.5       2.25
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 5
    params.ftpMod = { 0.71875, 0.84375, 0.96875 }
    params.str_wsc = player:getMerit(xi.merit.RESOLUTION) * 0.17
    params.atkVaries = { 0.85, 0.85, 0.85 }
    params.multiHitfTP = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 0.71875, 1.5, 2.25 }
        params.str_wsc = 0.7 + (player:getMerit(xi.merit.RESOLUTION) * 0.03)
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
