-----------------------------------
-- Howling Fist
-- Hand-to-Hand weapon skill
-- Skill Level: 200
-- Damage varies with TP.
-- Will stack with Sneak Attack.
-- Ignores some defense.
-- Aligned with the Light Gorget & Thunder Gorget.
-- Aligned with the Light Belt & Thunder Belt.
-- Element: None
-- Modifiers: STR:20%  VIT:50%
-- 100%TP    200%TP    300%TP
-- 2.50      2.75      3.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 2.5, 2.75, 3.0 }
    params.str_wsc = 0.2 params.vit_wsc = 0.5

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.multiHitfTP = true -- http://wiki.ffo.jp/html/2422.html
        params.ftpMod = { 2.05, 3.55, 5.75 }
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
