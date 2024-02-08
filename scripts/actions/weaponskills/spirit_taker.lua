-----------------------------------
-- Spirit Taker
-- Staff weapon skill
-- Skill Level: 215
-- Converts damage dealt to own MP. Damage varies with TP.
-- Will stack with Sneak Attack.
-- Not aligned with any "elemental gorgets" or "elemental belts" due to it's absence of Skillchain properties.
-- It is a physical weapon skill, and is affected by the user's params.accuracy and the enemy's evasion. It may miss completely.
-- Element: None
-- Modifiers: INT:50%  MND:50%
-- 100%TP    200%TP    300%TP
-- 1.00      1.50      2.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.5, 2.0 }
    params.int_wsc = 0.5 params.mnd_wsc = 0.5
    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    player:addMP(damage)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
