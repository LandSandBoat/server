-----------------------------------
-- Blade Shun
-- Katana weapon skill
-- Skill level: N/A
-- Description: Delivers a fivefold attack. Attack power varies with TP.
-- In order to obtain Blade: Shun the quest Martial Mastery must be completed.
-- This Weapon Skill's first hit params.ftp is duplicated for all additional hits.
-- Alignet with the Flame Gorget, Light Gorget & Thunder Gorget.
-- Alignet with the Flame Belt, Light Belt & Thunder Belt.
-- Element: None
-- Skillchain Properties: Fusion/Impaction
-- Modifiers: DEX:73~85%, depending on merit points upgrades.
-- Damage Multipliers by TP:
-- 100%        200%      300%
-- 0.6875    0.6875      0.6875
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 5
    params.ftpMod = { 0.6875, 0.6875, 0.6875 }
    params.dex_wsc = player:getMerit(xi.merit.BLADE_SHUN) * 0.17

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 1.0, 1.0, 1.0 }
        params.dex_wsc = 0.7 + (player:getMerit(xi.merit.BLADE_SHUN) * 0.03)
        params.atkVaries = { 1.0, 2.0, 3.0 } -- http://wiki.ffo.jp/html/25610.html
        params.multiHitfTP = true -- https://www.bg-wiki.com/ffxi/Blade:_Shun
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
