-----------------------------------
-- Shadowstitch
-- Dagger weapon skill
-- Skill level: 70
-- Binds target. Chance of binding varies with TP.
-- Does stack with Sneak Attack.
-- Aligned with the Aqua Gorget.
-- Aligned with the Aqua Belt.
-- Element: None
-- Modifiers: CHR:100%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.chr_wsc = 0.3

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.chr_wsc = 1.0
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 then
        local chance = (tp - 1000) * applyResistanceAddEffect(player, target, xi.element.ICE, 0) > math.random() * 150
        if not target:hasStatusEffect(xi.effect.BIND) and chance then
            local duration = (5 + (tp / 1000 * 5)) * applyResistanceAddEffect(player, target, xi.element.ICE, 0)
            target:addStatusEffect(xi.effect.BIND, 1, 0, duration)
        end
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
