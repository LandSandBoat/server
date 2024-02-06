-----------------------------------
-- Uriel Blade
-- Sword weapon skill
-- Skill Level: N/A
-- Description: Delivers an area attack that deals light elemental damage. Damage varies with TP. Additional effect Flash.
-- AoE range ??.
-- Only available during Campaign Battle while wielding a Griffinclaw.
-- Aligned with the Thunder Gorget & Breeze Gorget.
-- Aligned with Thunder Belt & Breeze Belt.
-- Modifiers: STR: 32% MND:32%
-- 100%TP    200%TP    300%TP
-- 4.50      6.00      7.50
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod = { 4.5, 6.0, 7.5 }
    params.str_wsc = 0.32 params.mnd_wsc = 0.32
    params.ele = xi.element.LIGHT
    params.skill = xi.skill.SWORD
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    if damage > 0 and not target:hasStatusEffect(xi.effect.FLASH) then
    target:addStatusEffect(xi.effect.FLASH, 200, 0, 15)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
