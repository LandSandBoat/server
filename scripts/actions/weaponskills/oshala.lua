-----------------------------------
-- Oshala
-- Staff weapon skill
-- Skill Level: N/A
-- Damage varies with TP.
-- Available while Opashoro (stage 3 or higher) is equipped.
-- Element: None
-- Modifiers: INT:45%  MND:45%
-- 100%TP    200%TP    300%TP
-- 3.95      7.89      11.84
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 3.95, 7.89, 11.84 }
    params.int_wsc = 0.45
    params.mnd_wsc = 0.45

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
