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
require("scripts/globals/aftermath")
require("scripts/globals/magic")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftp100 = 2 params.ftp200 = 2 params.ftp300 = 2
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0
    params.mnd_wsc = 0.4 params.chr_wsc = 0.0
    params.element = xi.magic.ele.LIGHT
    params.skillType = xi.skill.STAFF
    params.includemab = true

    local effectParams = {}
    effectParams.element = xi.magic.ele.LIGHT
    effectParams.effect = xi.effect.DEFENSE_DOWN
    effectParams.skillType = xi.skill.STAFF
    effectParams.duration = 30 + tp / 1000 * 30
    effectParams.power = 12.5
    effectParams.tick = 0
    effectParams.maccBonus = 0

    -- Apply Aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    if damage > 0 then
        xi.magic.applyAbilityResistance(player, target, effectParams)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
