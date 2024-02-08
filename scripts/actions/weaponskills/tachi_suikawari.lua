-----------------------------------
-- Tachi Suikawari
-- Great Katana weapon skill
-- Is the joke variant of Tachi: Kaiten, using the same animation.
-- Skill level: N/A Only usable when equipping Melon Slicer
-- Number of watermelons sliced varies with TP.
-- Element: Fusion
-- Modifiers: STR:80% (Using Tachi: Kaiten as it is based on that WS)
-- 100%TP    200%TP    300%TP
-- 1.00      1.50      2.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod = { 1.0, 1.5, 2.0 }
    params.str_wsc = 0.6

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.8
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
