-----------------------------------
-- Ascetics Fury
-- Hand-to-Hand weapon skill
-- Skill Level: N/A
-- Chance of params.critical hit varies with TP. Glanzfaust: Aftermath effect varies with TP.
-- Available only after completing the Unlocking a Myth (Monk) quest.
-- Aligned with the Flame Gorget & Light Gorget.
-- Aligned with the Flame Belt & Light Belt.
-- Element: None
-- Modifiers: STR:50%  VIT:50%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1, 1, 1 }
    params.str_wsc = 0.5 params.vit_wsc = 0.5
    params.critVaries = { 0.1, 0.2, 0.4 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.multiHitfTP = true -- http://wiki.ffo.jp/html/15880.html
        params.critVaries = { 0.2, 0.3, 0.5 }
        params.atkVaries  = { 2.5, 2.5, 2.5 }
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
