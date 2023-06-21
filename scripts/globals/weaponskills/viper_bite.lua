-----------------------------------
-- Viper Bite
-- Dagger weapon skill
-- Skill level: 100
-- Deals double damage and Poisons target. Duration of poison varies with TP.
-- Doubles attack and not damage.
-- Despite the animation showing two swings, this is a single-hit weapon skill.
-- Will stack with Sneak Attack.
-- Aligned with the Soil Gorget.
-- Aligned with the Soil Belt.
-- Element: None
-- Modifiers: :
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftp100 = 1 params.ftp200 = 1 params.ftp300 = 1
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 2 params.atk200 = 2 params.atk300 = 2

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.dex_wsc = 1.0
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 and not target:hasStatusEffect(xi.effect.POISON) then
        local duration = (30 + (tp / 1000 * 60)) * applyResistanceAddEffect(player, target, xi.magic.ele.WATER, 0)
        target:addStatusEffect(xi.effect.POISON, 3, 0, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
