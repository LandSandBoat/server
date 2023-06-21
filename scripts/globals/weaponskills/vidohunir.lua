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
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftp100 = 1.75 params.ftp200 = 1.75 params.ftp300 = 1.75
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.3
    params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.ele = xi.magic.ele.DARK
    params.skill = xi.skill.STAFF
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.int_wsc = 0.8
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    if damage > 0 then
        local duration = tp / 1000 * 60
        if not target:hasStatusEffect(xi.effect.MAGIC_DEF_DOWN) then
            target:addStatusEffect(xi.effect.MAGIC_DEF_DOWN, 10, 0, duration)
        end
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
