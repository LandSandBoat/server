-----------------------------------
-- Trueflight
-- Skill Level: N/A
-- Description: Deals light elemental damage. Damage varies with TP. Gastraphetes: Aftermath effect varies with TP.
-- Available only after completing the Unlocking a Myth (Ranger) quest.
-- Does not work with Flashy Shot.
-- Does not work with Stealth Shot.
-- Aligned with the Breeze Gorget, Thunder Gorget & Soil Gorget.
-- Aligned with the Breeze Belt, Thunder Belt & Soil Belt.
-- Properties
-- Element: Light
-- Skillchain Properties: Fragmentation/Scission
-- Modifiers: AGI:30%
-- Damage Multipliers by TP:
--  100%TP    200%TP    300%TP
--   4.0    4.25    4.75
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod = { 4.0, 4.25, 4.75 }
    params.agi_wsc = 0.3
    params.ele = xi.element.LIGHT
    params.skill = xi.skill.MARKSMANSHIP
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 3.8906, 6.3906, 9.3906 }
        params.agi_wsc = 1.0
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.RANGED, xi.aftermath.type.MYTHIC)

    local damage, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    return tpHits, extraHits, false, damage
end

return weaponskillObject
