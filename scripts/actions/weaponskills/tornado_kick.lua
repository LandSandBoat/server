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
    params.str_wsc = 0.32
    params.vit_wsc = 0.32

    params.ftpMod = { 2.25, 2.75, 3.5 }
    params.kick = true -- https://www.bluegartr.com/threads/112776-Dev-Tracker-Findings-Posts-%28NO-DISCUSSION%29?p=6712150&viewfull=1#post6712150

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 1.7, 2.8, 4.5 }
        params.str_wsc = 0.4 params.vit_wsc = 0.4
        params.multiHitfTP = true -- http://wiki.ffo.jp/html/20199.html
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
