-----------------------------------
-- Tachi: Shoha
-- Great Katana weapon skill
-- Skill Level: 357
-- Delivers a two-hit attack. Damage varies with TP.
-- To obtain Tachi: Shoha, the quest Martial Mastery must be completed and it must be purchased from the Merit Points menu.
-- Suspected to have an Attack Bonus similar to Tachi: Yukikaze, Tachi: Gekko, and Tachi: Kasha, but only on the first hit.
-- Aligned with the Breeze Gorget, Thunder Gorget & Shadow Gorget.
-- Aligned with the Breeze Belt, Thunder Belt & Shadow Belt.
-- Element: None
-- Modifiers: STR:73~85%, depending on merit points upgrades.
-- 100%TP    200%TP    300%TP
-- 1.375     2.1875      2.6875
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod = { 1.375, 2.1875, 2.6875 }
    params.str_wsc = player:getMerit(xi.merit.TACHI_SHOHA) * 0.17
    params.atkVaries = { 1.375, 1.375, 1.375 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.7 + (player:getMerit(xi.merit.TACHI_SHOHA) * 0.03)
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
