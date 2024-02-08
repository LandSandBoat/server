-----------------------------------
-- Shark Bite
-- Dagger weapon skill
-- Skill level: 225
-- Delivers a twofold attack. Damage varies with TP.
-- Will stack with Sneak Attack.
-- Will stack with Trick Attack.
-- Aligned with the Breeze Gorget & Thunder Gorget.
-- Aligned with the Breeze Belt & Thunder Belt.
-- Element: None
-- Modifiers: DEX:40% AGI:40%
-- 100%TP    200%TP    300%TP
--  2.00       4        5.75
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod = { 2.0, 2.5, 3.0 }
    params.dex_wsc = 0.5

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 4.5, 6.8, 8.5 }
        params.dex_wsc = 0.4 params.agi_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
