-----------------------------------
-- Upheaval
-- Great Axe weapon skill
-- Skill Level: 357
-- Delivers a four-hit attack. Damage varies with TP.
-- In order to obtain Upheaval, the quest Martial Mastery must be completed.
-- Aligned with Flame Gorget, Light Gorget & Shadow Gorget.
-- Aligned with Flame Belt, Light Belt & Shadow Belt.
-- Element: None
-- Modifiers: VIT: 73~85%, depending on merit points upgrades.
-- 100%TP    200%TP    300%TP
-- 1.00        3.50       6.5
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 4
    params.ftpMod = { 1.0, 3.5, 6.5 }
    params.vit_wsc = player:getMerit(xi.merit.UPHEAVAL) * 0.17

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.vit_wsc = 0.7 + (player:getMerit(xi.merit.UPHEAVAL) * 0.03)
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
