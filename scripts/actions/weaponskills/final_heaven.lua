-----------------------------------
-- Skill: Final Heaven
-- H2H weapon skill
-- Skill Level N/A
-- Additional effect: temporarily enhances Subtle Blow xi.effect.
-- Mods : VIT:60%
-- 100%TP     200%TP     300%TP
-- 3.0x        3.0x    3.0x
-- +10 Subtle Blow for a short duration after using the weapon skill. (Not implemented)
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    -- number of normal hits for ws
    params.numHits = 2
    -- stat-modifiers (0.0 = 0%, 0.2 = 20%, 0.5 = 50%..etc)
    params.vit_wsc = 0.6
    params.ftpMod = { 3.0, 3.0, 3.0 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.vit_wsc = 0.8
        -- as of 02.03.2022 the ws doesnt yet apply ftp to all stage, was delaied to be done in line with other relic ws
        -- http://wiki.ffo.jp/html/2426.html and https://forum.square-enix.com/ffxi/threads/55998-October-2019-FINAL-FANTASY-XI-Digest?highlight=2019+update
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
