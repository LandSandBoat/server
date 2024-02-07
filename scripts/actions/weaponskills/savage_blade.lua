-----------------------------------
-- Savage Blade
-- Sword weapon skill
-- Skill Level: 240
-- Delivers an aerial attack comprised of two hits. Damage varies with TP.
-- In order to obtain Savage Blade, the quest Old Wounds must be completed.
-- Will stack with Sneak Attack.
-- Aligned with the Breeze Gorget, Thunder Gorget & Soil Gorget
-- Aligned with the Breeze Belt, Thunder Belt & Soil Belt.
-- Element: None
-- Modifiers: STR:50%  MND:50%
-- 100%TP    200%TP    300%TP
-- 4.00      10.25      13.75
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod = { 1.0, 1.75, 3.5 }
    params.str_wsc = 0.3 params.mnd_wsc = 0.5

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 4.0, 10.25, 13.75 }
        params.str_wsc = 0.5
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
