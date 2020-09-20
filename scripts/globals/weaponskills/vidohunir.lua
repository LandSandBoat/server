-----------------------------------
-- Vidohunir
-- Staff weapon skill
-- Skill Level: N/A
-- Lowers target's magic defense. Duration of effect varies with TP. Laevateinn: Aftermath effect varies with TP.
-- Reduces enemy's magic defense by 10%.
-- Available only after completing the Unlocking a Myth (Black Mage) quest.
-- Aligned with the Breeze Gorget, Thunder Gorget, Aqua Gorget & Snow Gorget.
-- Aligned with the Breeze Belt, Thunder Belt, Aqua Belt & Snow Belt.
-- Element: Darkness
-- Modifiers: INT:30%
-- 100%TP    200%TP    300%TP
-- 1.75      1.75      1.75
-----------------------------------
require("scripts/globals/aftermath")
require("scripts/globals/magic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftp100 = 1.75 params.ftp200 = 1.75 params.ftp300 = 1.75
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.3
    params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.ele = tpz.magic.ele.DARK
    params.skill = tpz.skill.STAFF
    params.includemab = true

    if USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.int_wsc = 0.8
    end

    -- Apply aftermath
    tpz.aftermath.addStatusEffect(player, tp, tpz.slot.MAIN, tpz.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    if damage > 0 then
        local duration = tp / 1000 * 60
        if not target:hasStatusEffect(tpz.effect.MAGIC_DEF_DOWN) then
            target:addStatusEffect(tpz.effect.MAGIC_DEF_DOWN, 10, 0, duration)
        end
    end

    return tpHits, extraHits, criticalHit, damage
end
