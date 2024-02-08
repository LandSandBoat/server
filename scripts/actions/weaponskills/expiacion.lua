-----------------------------------
-- Expiacion
-- Sword weapon skill
-- Skill Level: N/A
-- Delivers a Twofold attack. Damage varies with TP. Tizona: Aftermath effect varies with TP.
-- Available only after completing the Unlocking a Myth (Blue Mage) quest.
-- Aligned with the Aqua Gorget, Snow Gorget & Soil Gorget.
-- Aligned with the Aqua Belt, Snow Belt & Soil Belt.
-- Element: None
-- Modifiers: STR:30% INT:30%
-- 100%TP    200%TP    300%TP
-- 1.50      2.00      2.50
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod = { 1.5, 2.0, 2.5 }
    params.str_wsc = 0.3 params.int_wsc = 0.3

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 3.75, 10.25, 12.5 }
        params.dex_wsc = 0.2
    end

    -- Apply Aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
