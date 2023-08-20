-----------------------------------
-- Requiescat
-- Sword weapon skill
-- Skill level: MERIT
-- Delivers a five-hit attack. Attack power varies with TP.
-- Element: None
-- Modifiers: MND:73~85%
-- 100%TP    200%TP    300%TP
--         ALL 1.0
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 5
    params.ftp100 = 1.0 params.ftp200 = 1.0 params.ftp300 = 1.0
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0
    params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = player:getMerit(xi.merit.REQUIESCAT) * 0.17
    params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 0.8 params.atk200 = 0.9 params.atk300 = 1.0
    -- TODO: Verify the params.formless check
    params.formless = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.mnd_wsc = 0.7 + (player:getMerit(xi.merit.REQUIESCAT) * 0.03)
        params.multiHitfTP = true
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
