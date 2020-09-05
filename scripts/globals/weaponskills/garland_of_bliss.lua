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
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftp100 = 2 params.ftp200 = 2 params.ftp300 = 2
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0
    params.mnd_wsc = 0.4 params.chr_wsc = 0.0
    params.ele = tpz.magic.ele.LIGHT
    params.skill = tpz.skill.STAFF
    params.includemab = true

    if USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 2.25 params.ftp200 = 2.25 params.ftp300 = 2.25
        params.str_wsc = 0.3 params.mnd_wsc = 0.7
    end

    -- Apply Aftermath
    tpz.aftermath.addStatusEffect(player, tp, tpz.slot.MAIN, tpz.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    if damage > 0 then
        if not target:hasStatusEffect(tpz.effect.DEFENSE_DOWN) then
            local duration = (30 + tp / 1000 * 30) * applyResistanceAddEffect(player, target, tpz.magic.ele.WIND, 0)
            target:addStatusEffect(tpz.effect.DEFENSE_DOWN, 12.5, 0, duration)
        end
    end

    return tpHits, extraHits, criticalHit, damage
end
