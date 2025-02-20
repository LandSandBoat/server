-----------------------------------
-- Omniscience
-- Staff weapon skill
-- Skill Level: N/A
-- Lowers target's magic attack. Duration of effect varies with TP. Tupsimati: Aftermath effect varies with TP.
-- Reduces enemy's magic attack by -10.
-- Available only after completing the Unlocking a Myth (Scholar) quest.
-- Aligned with the Shadow Gorget, Soil Gorget & Light Gorget.
-- Aligned with the Shadow Belt, Soil Belt & Light Belt.
-- Element: Dark
-- Modifiers: MND:80%
-- 100%TP    200%TP    300%TP
-- 2.00      2.00      2.00
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.ftpMod     = { 2, 2, 2 }
    params.mnd_wsc    = 0.3
    params.ele        = xi.element.DARK
    params.skill      = xi.skill.STAFF
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.mnd_wsc = 0.8
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    -- Apply Aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    -- Handle status effect
    local effectId      = xi.effect.MAGIC_ATK_DOWN
    local power         = 10
    local duration      = math.floor(6 * tp / 100)
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, 0, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
