-----------------------------------
-- One Inch Punch
-- Hand-to-Hand weapon skill
-- Skill level: 75
-- Delivers an attack that ignores target's defense. Amount ignored varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Shadow Gorget.
-- Aligned with the Shadow Belt.
-- Element: None
-- Modifiers: VIT:40%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    -- This is a 2 hit ws but H2H ws are done in a different way, the off hand hit is been taking into account in another place
    params.ftp100 = 1 params.ftp200 = 1 params.ftp300 = 1
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.4 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1
    -- Defense ignored is 0%, 30%, 50% as per http://www.bg-wiki.com/bg/One_Inch_Punch
    params.ignoresDef = true
    params.ignored100 = 0
    params.ignored200 = 0.3
    params.ignored300 = 0.5

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.multiHitfTP = true -- http://wiki.ffo.jp/html/2418.html
        params.vit_wsc = 1.0
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
