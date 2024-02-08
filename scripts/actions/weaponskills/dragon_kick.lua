-----------------------------------
-- Dragon Kick
-- Hand-to-Hand weapon skill
-- Skill Level: 225
-- Damage varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Breeze Gorget & Thunder Gorget.
-- Aligned with the Breeze Belt & Thunder Belt.
-- Element: None
-- Modifiers: STR:50%  VIT:50%
-- 100%TP    200%TP    300%TP
-- 2.00      2.50      3.50
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod = { 2.0, 2.5, 3.5 }
    params.str_wsc = 0.5 params.vit_wsc = 0.5
    params.kick = true -- https://www.bluegartr.com/threads/112776-Dev-Tracker-Findings-Posts-%28NO-DISCUSSION%29?p=6712150&viewfull=1#post6712150

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.multiHitfTP = true -- https://www.bg-wiki.com/ffxi/Dragon_Kick
        params.ftpMod = { 1.7, 3.0, 5.0 }
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
