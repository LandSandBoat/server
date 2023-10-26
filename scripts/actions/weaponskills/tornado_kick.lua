-----------------------------------
-- Skill: Tornado Kick
-- Class: H2H Weapon Skill
-- Level: 225
-- Mods : STR:32% VIT:32%
-- 100%TP     200%TP     300%TP
-- 2.25x        2.75x    3.5x
-- Delivers a twofold attack. Damage varies with TP.
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    -- number of normal hits for ws
    params.numHits = 3
    -- stat-modifiers (0.0 = 0%, 0.2 = 20%, 0.5 = 50%..etc)
    params.str_wsc = 0.32        params.dex_wsc = 0.0
    params.vit_wsc = 0.32        params.agi_wsc = 0.0
    params.int_wsc = 0.0         params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    -- ftp damage mods (for Damage Varies with TP lines are calculated in the function ftp)
    params.ftp100 = 2.25 params.ftp200 = 2.75 params.ftp300 = 3.5

    -- critical modifiers (0.0 = 0%, 0.2 = 20%, 0.5 = 50%..etc)
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false

    -- params.accuracy modifiers (0.0 = 0%, 0.2 = 20%, 0.5 = 50%..etc) Keep 0 if ws doesn't have accuracy modification.
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0

    -- attack multiplier (only some WSes use this, this varies the actual ratio value, see Tachi: Kasha) 1 is default.
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1
    params.kick = true -- https://www.bluegartr.com/threads/112776-Dev-Tracker-Findings-Posts-%28NO-DISCUSSION%29?p=6712150&viewfull=1#post6712150

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 1.7 params.ftp200 = 2.8 params.ftp300 = 4.5
        params.str_wsc = 0.4 params.vit_wsc = 0.4
        params.multiHitfTP = true -- http://wiki.ffo.jp/html/20199.html
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
