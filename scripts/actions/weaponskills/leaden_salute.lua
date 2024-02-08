-----------------------------------
-- Leaden Salute
-- Sword weapon skill
-- Skill Level: N/A
-- Delivers a Twofold attack. Damage varies with TP. Death Penalty: Aftermath effect varies with TP.
-- Available only after completing the Unlocking a Myth (Corsair) quest.
-- Aligned with the Shadow Gorget, Soil Gorget & Light Gorget.
-- Aligned with the Shadow Belt, Soil Belt & Light Belt.
-- Element: Darkness
-- Modifiers: AGI:30%
-- 100%TP    200%TP    300%TP
-- 4.00      4.25      4.75
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod = { 4.0, 4.25, 4.75 }
    params.agi_wsc = 0.3
    params.ele = xi.element.DARK
    params.skill = xi.skill.MARKSMANSHIP
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 4.0, 6.7, 10.0 }
        params.agi_wsc = 1.0
    end

    -- Apply Aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.RANGED, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
