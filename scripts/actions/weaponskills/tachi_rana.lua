-----------------------------------
-- Tachi Rana
-- Great Katana weapon skill
-- Skill Level: N/A
-- Delivers a three-fold attack. params.accuracy varies with TP. Aftermath effect varies with TP. See Kogarasumaru.
-- In order to obtain Tachi: Rana, the Unlocking a Myth (Samurai) quest must be completed.
-- Will stack with Sneak Attack (first hit only).
-- Aligned with the Shadow Gorget, Soil Gorget & Snow Gorget.
-- Aligned with the Shadow Belt, Soil Belt & Snow Belt.
-- Element: None
-- Modifiers: STR:35%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 3
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.35
    params.accVaries = { 0.8, 0.9, 1.0 } -- TODO: verify -- "Accuracy varies with TP" in retail. All current evidence points to that this modifier is static values, not percentages.

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.5
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
