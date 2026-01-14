-----------------------------------
-- Realmrazer
-- Club weapon skill
-- Skill Level: 357
-- Delivers a seven-hit attack. params.accuracy varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Shadow Gorget & Soil Gorget.
-- Aligned with the Shadow Belt & Soil Belt.
-- Element: None
-- Modifiers: MND:73~85%
-- 100%TP    200%TP    300%TP
-- .88        .88       .88
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 7
    params.ftpMod = { 0.88, 0.88, 0.88 }
    params.mnd_wsc = player:getMerit(xi.merit.REALMRAZER) * 0.17
    params.accVaries = { 0, 30, 60 } -- TODO: verify exact number

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.mnd_wsc = 0.7 + (player:getMerit(xi.merit.REALMRAZER) * 0.03)
        params.multiHitfTP = true
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
