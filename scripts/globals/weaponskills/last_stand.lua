-----------------------------------
-- Last Stand
-- Skill Level: 357
-- Description: Attacks once or twice, depending on remaining ammunition. Damage dealt varies with TP.
-- If the first shot of the weapon skill does enough damage to defeat the target, the second shot will not be used.
-- To obtain Last Stand, the quest Martial Mastery must be completed.
-- This Weapon Skill's first hit fTP is duplicated for all additional hits.
-- Aligned with the Flame Gorget, Light Gorget & Aqua Gorget.
-- Properties
-- Element: N/A
-- Skillchain Properties: Fusion/Reverberation
-- Modifiers: AGI:100%
-- Damage Multipliers by TP:
-- 100%TP    200%TP    300%TP
--   2.0    2.125    2.25

-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 2
    params.ftp100 = 2 params.ftp200 = 2.125 params.ftp300 = 2.25
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0
    params.agi_wsc = 0.85 + (player:getMerit(tpz.merit.LAST_STAND) / 100) params.int_wsc = 0.0 params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1
    params.multiHitfTP = true

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp200 = 3 params.ftp300 = 4
        params.agi_wsc = 0.7 + (player:getMerit(tpz.merit.LAST_STAND) / 100)
    end

    local damage, criticalHit, tpHits, extraHits = doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage

end
