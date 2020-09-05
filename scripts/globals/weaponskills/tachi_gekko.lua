-----------------------------------
-- Tachi Gekko
-- Great Katana weapon skill
-- Skill Level: 225
-- Silences target. Damage varies with TP.
-- Silence effect duration is 60 seconds when unresisted.
-- Will stack with Sneak Attack.
-- Tachi: Gekko has a high attack bonus of +100%. [1]
-- Aligned with the Aqua Gorget & Snow Gorget.
-- Aligned with the Aqua Belt & Snow Belt.
-- Element: None
-- Modifiers: STR:75%
-- 100%TP    200%TP    300%TP
-- 1.5625      2.6875      4.125
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 1
    params.ftp100 = 1.5625 params.ftp200 = 1.88 params.ftp300 = 2.5
    params.str_wsc = 0.75 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 2; params.atk200 = 2; params.atk300 = 2

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp100 = 1.5625 params.ftp200 = 2.6875 params.ftp300 = 4.125
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    -- Silence duration changed from 60 to 45 as per bg-wiki: http://www.bg-wiki.com/bg/Tachi:_Gekko
    if (damage > 0 and target:hasStatusEffect(tpz.effect.SILENCE) == false) then
        local duration = 60 * applyResistanceAddEffect(player, target, tpz.magic.ele.WIND, 0)
        target:addStatusEffect(tpz.effect.SILENCE, 1, 0, duration)
    end
    return tpHits, extraHits, criticalHit, damage

end
