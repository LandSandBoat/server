-----------------------------------
-- Final Paradise
-- Hand-to-Hand weapon skill
-- Is the joke variant of Final Heaven, using the same animation.
-- Skill level: N/A Only usable when equipping Premium Mogti
-- Delivers a twofold attack. Paradise varies with TP.
-- Element: Light
-- Modifiers: ? (Using Final Heaven as it is based on that WS)
-- 100%TP    200%TP    300%TP
-- 1.00      1.50      2.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.5, 2.0 }
    params.vit_wsc = 0.6

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.vit_wsc = 0.8
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
