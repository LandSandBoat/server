-----------------------------------
-- Metatron Torment
-- Hand-to-Hand Skill level: 5 Description: Delivers a threefold attack. Damage varies wit weapon skill
-- Great Axe Weapon Skill
-- Skill Level: N/A
-- Lowers target's defense. Additional effect: temporarily lowers damage taken from enemies.
-- Defense Down effect is 18.5%, 1 minute duration.
-- Damage reduced is 20.4% or 52/256.
-- Lasts 20 seconds at 100TP, 40 seconds at 200TP and 60 seconds at 300TP.
-- Available only when equipped with the Relic Weapons Abaddon Killer (Dynamis use only) or Bravura.
-- Also available as a Latent effect on Barbarus Bhuj
-- Since these Relic Weapons are only available to Warriors, only Warriors may use this Weapon Skill.
-- Aligned with the Flame Gorget & Light Gorget.
-- Aligned with the Flame Belt & Light Belt.
-- Element: None
-- Modifiers: STR:60%
-- 100%TP    200%TP    300%TP
-- 2.75      2.75      2.75
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftp100 = 2.75 params.ftp200 = 2.75 params.ftp300 = 2.75
    params.str_wsc = 0.6 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.8
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    if damage > 0 then
        local duration = tp / 1000 * 20 * applyResistanceAddEffect(player, target, xi.element.WIND, 0)
        target:addStatusEffect(xi.effect.DEFENSE_DOWN, 19, 0, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
