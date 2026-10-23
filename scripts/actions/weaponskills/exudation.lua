-----------------------------------
-- Exudation
-- Club weapon skill
-- Skill Level: N/A
-- Attack varies with TP.
-- Available to Geomancer at level 99 after the quest Geomancerrific, or while Idris is equipped.
-- Element: None
-- Modifiers: INT:50%  MND:50%
-- 100%TP    200%TP    300%TP
-- 2.8       2.8       2.8
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params     = {}
    params.numHits   = 1
    params.ftpMod    = { 2.8, 2.8, 2.8 }
    params.int_wsc   = 0.5
    params.mnd_wsc   = 0.5
    params.atkVaries = { 1.5, 3.6, 4.7 } -- DAT, but BG says 3.625, 4.75

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
