-----------------------------------
-- Sanguine Blade
-- Sword weapon skill
-- Skill Level: 300
-- Drains a percentage of damage dealt to HP varies with TP.
-- Will not stack with Sneak Attack.
-- Not aligned with any "elemental gorgets" or "elemental belts" due to it's absence of Skillchain properties.
-- Element: Dark
-- Modifiers: STR:30%  MND:50%
-- 100%TP    200%TP    300%TP
-- 2.75      2.75      2.75
-- HP Drained by TP:
-- 100%TP    200%TP    300%TP
-- 50%       75%    100%
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local drain = 25 + math.floor(tp / 1000) * 25
    local params = {}
    params.ftpMod = { 2.75, 2.75, 2.75 }
    params.str_wsc = 0.3 params.mnd_wsc = 0.5
    params.ele = xi.element.DARK
    params.skill = xi.skill.SWORD
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        if tp >= 2000 and tp <= 2999 then
            drain = 100
        elseif tp == 3000 then
            drain = 160
        end
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    if not target:isUndead() then
        player:addHP((damage / 100) * drain)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
