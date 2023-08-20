-----------------------------------
-- Dimidiation
-- Great Sword weapon skill
-- Skill Level: N/A
-- Delivers a twofold attack. Damage varies with TP. Epeolatry: Aftermath effect varies with TP.
-- Will stack with Sneak Attack.
-- Element: None
-- Skillchain Elements: Light/Fragmentation (Fire, Thunder, Wind, Light gorget/belt aligned)
-- Modifiers: VIT:80% DEX
-- 1000 TP   2000 TP   3000 TP
-- 2.25      4.5       6.75
-----------------------------------
local weaponskillObject = {}

-- source https://www.bg-wiki.com/ffxi/Dimidiation, http://wiki.ffo.jp/html/31450.html
weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftp100 = 2.25 params.ftp200 = 4.5 params.ftp300 = 6.75
    params.str_wsc = 0.0 params.dex_wsc = 0.8 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1.25 params.atk200 = 1.25 params.atk300 = 1.25
    params.ignoresDef = false
    params.ignored100 = 0
    params.ignored200 = 0
    params.ignored300 = 0

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
