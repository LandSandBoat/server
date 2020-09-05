-----------------------------------
-- Tachi Kasha
-- Great Katana weapon skill
-- Skill Level: 250
-- Paralyzes target. Damage varies with TP.
-- Paralyze effect duration is 60 seconds when unresisted.
-- In order to obtain Tachi: Kasha, the quest The Potential Within must be completed.
-- Will stack with Sneak Attack.
-- Tachi: Kasha appears to have a moderate attack bonus of +50%. [1]
-- Aligned with the Flame Gorget, Light Gorget & Shadow Gorget.
-- Aligned with the Flame Belt, Light Belt & Shadow Belt.
-- Element: None
-- Modifiers: STR:75%
-- 100%TP    200%TP    300%TP
-- 1.5625    2.6875    4.125
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 1
    params.ftp100 = 1.56 params.ftp200 = 1.88 params.ftp300 = 2.5
    params.str_wsc = 0.75 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1.5; params.atk200 = 1.5; params.atk300 = 1.5

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp100 = 1.5625 params.ftp200 = 2.6875 params.ftp300 = 4.125
        params.str_wsc = 0.75
        params.atk100 = 1.65; params.atk200 = 1.65; params.atk300 = 1.65
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if (damage > 0 and target:hasStatusEffect(tpz.effect.PARALYSIS) == false) then
        local duration = 60 * applyResistanceAddEffect(player, target, tpz.magic.ele.ICE, 0)
        target:addStatusEffect(tpz.effect.PARALYSIS, 25, 0, duration)
    end
    return tpHits, extraHits, criticalHit, damage

end
