-----------------------------------
-- Ruthless Stroke
-- Dagger weapon skill
-- Skill Level: N/A
-- Delivers a fourfold attack. Damage varies with TP.
-- Available while Mpu Gandring (stage 3 or higher) is equipped.
-- Element: None
-- Modifiers: DEX:20%  AGI:20%
-- 100%TP    200%TP    300%TP
-- 5.758     14.516    23.277
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 4
    params.ftpMod  = { 1474 / 256, 3716 / 256, 5959 / 256 }
    params.dex_wsc = 0.2
    params.agi_wsc = 0.2

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
