-----------------------------------
-- Dimidiation
-- Great Sword weapon skill
-- Skill Level: N/A
-- Delivers a twofold attack. Damage varies with TP. Epeolatry: Aftermath effect varies with TP.
-- Will stack with Sneak Attack.
-- Element: None
-- Skillchain Elements: Light/Fragmentation (Fire, Thunder, Wind, Light gorget/belt aligned)
-- Modifiers: DEX:80%
-- 1000 TP   2000 TP   3000 TP
-- 2.25      4.5       6.75
-----------------------------------
local weaponskillObject = {}

-- source https://www.bg-wiki.com/ffxi/Dimidiation, http://wiki.ffo.jp/html/31450.html
weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod = { 2.25, 4.5, 6.75 }
    params.dex_wsc = 0.8
    params.atkVaries = { 1.25, 1.25, 1.25 }

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
