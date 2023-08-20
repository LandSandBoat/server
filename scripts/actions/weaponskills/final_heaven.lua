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
    params.numHits = 1
    -- This is a 2 hit ws but H2H ws are done in a different way, the off hand hit is been taking into account in another place
    -- stat-modifiers (0.0 = 0%, 0.2 = 20%, 0.5 = 50%..etc)
    params.str_wsc = 0.0        params.dex_wsc = 0.0
    params.vit_wsc = 0.6        params.agi_wsc = 0.0
    params.int_wsc = 0.0        params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    -- ftp damage mods (for Damage Varies with TP lines are calculated in the function params.ftp)
    params.ftp100 = 3.0 params.ftp200 = 3.0 params.ftp300 = 3.0
    -- critical modifiers (0.0 = 0%, 0.2 = 20%, 0.5 = 50%..etc)
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    -- accuracy modifiers (0.0 = 0%, 0.2 = 20%, 0.5 = 50%..etc) Keep 0 if ws doesn't have accuracy modification.
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    -- attack multiplier (only some WSes use this, this varies the actual ratio value, see Tachi: Kasha) 1 is default.
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.vit_wsc = 0.8
        -- as of 02.03.2022 the ws doesnt yet apply ftp to all stage, was delaied to be done in line with other relic ws
        -- http://wiki.ffo.jp/html/2426.html and https://forum.square-enix.com/ffxi/threads/55998-October-2019-FINAL-FANTASY-XI-Digest?highlight=2019+update
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    -- damage = damage * ftp(tp, ftp100, ftp200, ftp300)
    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
