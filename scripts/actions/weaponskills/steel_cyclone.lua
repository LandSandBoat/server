-----------------------------------
-- Steel Cyclone
-- Great Axe weapon skill
-- Skill level: 240
-- Delivers a single-hit attack. Damage varies with TP.
-- In order to obtain Steel Cyclone, the quest The Weight of Your Limits must be completed.
-- Will stack with Sneak Attack.
-- Aligned with the Breeze Gorget, Aqua Gorget & Snow Gorget.
-- Aligned with the Breeze Belt, Aqua Belt & Snow Belt.
-- Element: None
-- Modifiers: STR:60%  VIT:60%
-- 100%TP    200%TP    300%TP
-- 1.50       2.5       4.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.5, 1.75, 3.0 }
    params.str_wsc = 0.5 params.vit_wsc = 0.5
    params.atkVaries = { 1.66, 1.66, 1.66 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 1.5, 2.5, 4.0 }
        params.str_wsc = 0.6 params.vit_wsc = 0.6
        params.atkVaries = { 1.5, 1.5, 1.5 }
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
