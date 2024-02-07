-----------------------------------
-- Leg Sweep
-- Polearm weapon skill
-- Skill Level: 100
-- Stuns enemy. Chance of stunning varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Thunder Gorget.
-- Aligned with the Thunder Belt.
-- Element: None
-- Modifiers: STR:30%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.3

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 1.0
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    local chance = (tp-1000) * applyResistanceAddEffect(player, target, xi.element.THUNDER, 0) > math.random() * 150
    if damage > 0 and chance then
        if not target:hasStatusEffect(xi.effect.STUN) then
            local duration = 4 * applyResistanceAddEffect(player, target, xi.element.THUNDER, 0)
            target:addStatusEffect(xi.effect.STUN, 1, 0, duration)
        end
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
