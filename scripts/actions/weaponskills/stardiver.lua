-----------------------------------
-- Stardiver
-- Polearm weapon skill
-- Skill Level: MERIT
-- Delivers a fourfold attack. Damage varies with TP.
-- Will stack with Sneak Attack.     reduces params.crit hit evasion by 5%
-- Element: None
-- Modifiers: STR:73~85%
-- 100%TP    200%TP    300%TP
-- 0.75         1.25       1.75
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 4
    params.ftpMod = { 0.75, 1.25, 1.75 }
    params.str_wsc = player:getMerit(xi.merit.STARDIVER) * 0.17

    -- https://www.bluegartr.com/threads/106679-Test-Server-Findings?p=4920448&viewfull=1#post4920448
    params.multiHitfTP = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.7 + (player:getMerit(xi.merit.STARDIVER) * 0.03)
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if
        damage > 0 and
        not target:hasStatusEffect(xi.effect.CRIT_HIT_EVASION_DOWN)
    then
        target:addStatusEffect(xi.effect.CRIT_HIT_EVASION_DOWN, 5, 0, 60)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
