-----------------------------------
-- Shattersoul
-- Skill Level: 357
-- Description: Delivers a threefold attack. Decreases target's magic defense. Duration of effect varies with TP.
-- To obtain Shattersoul, the quest Martial Mastery must be completed and it must be purchased from the Merit Points menu.
-- Target's magic defense is lowered by 10.
-- Aligned with the Shadow Gorget, Soil Gorget & Snow Gorget.
-- Aligned with the Shadow Belt, Soil Belt & Snow Belt.
-- Element: N/A
-- Skillchain Properties: Gravitation/Induration
-- Shattersoul is only available to Warriors, Monks, White Mages, Black Mages, Paladins, Bards, Dragoons, Summoners and Scholars.
-- While some jobs may obtain skill level 357 earlier than level 96, Shattersoul must be unlocked once skill reaches level 357 and job level 96 is reached.
-- Staff skill level 357 is obtainable by the following jobs at these corresponding levels:
-- Modifiers: INT:73~85%, depending on merit points upgrades.
-- Damage Multipliers by TP:
-- 100%TP    200%TP    300%TP
-- 1.375      1.375      1.375
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 3
    params.ftpMod = { 1.375, 1.375, 1.375 }
    params.int_wsc = player:getMerit(xi.merit.SHATTERSOUL) * 0.17

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.int_wsc = 0.7 + (player:getMerit(xi.merit.SHATTERSOUL) * 0.03)
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 and not target:hasStatusEffect(xi.effect.MAGIC_DEF_DOWN) then
        target:addStatusEffect(xi.effect.MAGIC_DEF_DOWN, 10, 0, 120)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
