-----------------------------------
-- Shockwave
-- Great Sword weapon skill
-- Skill level: 150
-- Delivers an area of effect attack. Sleeps enemies. Duration of effect varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Aqua Gorget.
-- Aligned with the Aqua Belt.
-- Element: None
-- Modifiers: STR:30%  MND:30%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.3 params.mnd_wsc = 0.3
    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 and not target:hasStatusEffect(xi.effect.SLEEP_I) then
        local duration = (tp / 1000 * 60) * applyResistanceAddEffect(player, target, xi.element.DARK, 0)
        target:addStatusEffect(xi.effect.SLEEP_I, 1, 0, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
