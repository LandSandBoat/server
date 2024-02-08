-----------------------------------
-- Tachi Hobaku
-- Great Katana weapon skill
-- Skill Level: 30
-- Stuns enemy. Chance of stun varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Snow Gorget.
-- Aligned with the Snow Belt.
-- Element: None
-- Modifiers: STR:60%
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
        params.str_wsc = 0.6
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    local chance = (tp - 1000) * applyResistanceAddEffect(player, target, xi.element.THUNDER, 0) > math.random() * 150
    if damage > 0 and chance then
        if not target:hasStatusEffect(xi.effect.STUN) then
            target:addStatusEffect(xi.effect.STUN, 1, 0, 4)
        end
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
