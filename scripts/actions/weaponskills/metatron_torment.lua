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
    params.ftpMod = { 2.75, 2.75, 2.75 }
    params.str_wsc = 0.6

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
