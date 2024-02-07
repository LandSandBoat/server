-----------------------------------
-- Skullbreaker
-- Club weapon skill
-- Skill level: 150
-- Lowers enemy's INT. Chance of lowering INT varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Snow Gorget & Aqua Gorget.
-- Aligned with the Snow Belt & Aqua Belt.
-- Element: None
-- Modifiers: STR:100%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.3
    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 1.0
    end

    if damage > 0 and not target:hasStatusEffect(xi.effect.INT_DOWN) then
        target:addStatusEffect(xi.effect.INT_DOWN, 10, 0, 140)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
