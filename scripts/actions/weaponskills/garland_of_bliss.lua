-----------------------------------
-- Garland Of Bliss
-- Staff weapon skill
-- Skill level: N/A
-- Lowers target's defense. Duration of effect varies with TP. Nirvana: Aftermath effect varies with TP.
-- Reduces enemy's defense by 12.5%.
-- Available only after completing the Unlocking a Myth (Summoner) quest.
-- Aligned with the Flame Gorget, Light Gorget & Aqua Gorget.
-- Aligned with the Flame Belt, Light Belt & Aqua Belt.
-- Element: Light
-- Modifiers: MND:40%
-- 100%TP    200%TP    300%TP
-- 2.00      2.00      2.00
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.ftpMod     = { 2, 2, 2 }
    params.mnd_wsc    = 0.4
    params.ele        = xi.element.LIGHT
    params.skill      = xi.skill.STAFF
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod  = { 2.25, 2.25, 2.25 }
        params.str_wsc = 0.3
        params.mnd_wsc = 0.7
    end

    -- Apply Aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    -- Handle status effect
    local effectId      = xi.effect.DEFENSE_DOWN
    local actionElement = xi.element.WIND
    local power         = 12.5
    local duration      = math.floor((30 + 3 * tp / 100) * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
