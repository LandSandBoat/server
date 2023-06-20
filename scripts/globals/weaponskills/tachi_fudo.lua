-----------------------------------
-- Tachi: Fudo
-- Great Katana weapon skill
-- Skill Level: N/A
-- Deals double damage. Damage varies with TP. Masamune: Aftermath.
-- Available only when equipped with Masamune (85), Masamune (90), Masamune (95), Hiradennotachi +1 or Hiradennotachi +2.
-- Aligned with Light Gorget, Snow Gorget & Aqua Gorget.
-- Aligned with Light Belt, Snow Belt & Aqua Belt.
-- Element: None
-- Modifiers: STR:80%
-- 100%TP    200%TP    300%TP
-- 3.75      5.75        8
-----------------------------------
require("scripts/globals/aftermath")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftp100 = 3.75 params.ftp200 = 4.75 params.ftp300 = 5.75
    params.str_wsc = 0.60 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 2 params.atk200 = 2 params.atk300 = 2

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 3.75 params.ftp200 = 5.75 params.ftp300 = 8
        params.str_wsc = 0.8
        params.atk100 = 1 params.atk200 = 1 params.atk300 = 1
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.EMPYREAN)

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
