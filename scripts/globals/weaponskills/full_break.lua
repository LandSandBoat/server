-----------------------------------
-- Full Break
-- Great Axe weapon skill
-- Skill level: 225 (Warriors only.)
-- Lowers enemy's attack, defense, params.accuracy, and evasion. Duration of effect varies with TP.
-- Lowers attack and defense by 12.5%, evasion by 20 points, and estimated to also lower params.accuracy by 20 points.
-- These enfeebles are given as four seperate status effects, resists calculated seperately for each. They almost always wear off simultaneously, but have been observed to wear off at different times.
-- Strong against: Coeurls.
-- Immune: Antica, Cockatrice, Crawlers, Worms.
-- Will stack with Sneak Attack.
-- Aligned with the Aqua Gorget & Snow Gorget.
-- Aligned with the Aqua Belt & Snow Belt.
-- Element: Earth
-- Modifiers: STR:50%  VIT:50%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-- Duration is 180/240/300 - resulting in (tp / 1000 * 60) + 120
-----------------------------------
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftp100 = 1 params.ftp200 = 1 params.ftp300 = 1
    params.str_wsc = 0.5 params.dex_wsc = 0.0 params.vit_wsc = 0.5 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 1 params.acc200 = 1 params.acc300 = 1
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1

    local effectParams = {}
    effectParams.element = xi.magic.ele.WIND
    effectParams.effect = xi.effect.DEFENSE_DOWN
    effectParams.skillType = xi.skill.GREAT_AXE
    effectParams.duration = (tp / 1000 * 60) + 120
    effectParams.power = 12.5
    effectParams.tick = 0
    effectParams.maccBonus = 0

    local effectParams2 = {}
    effectParams2.element = xi.magic.ele.WATER
    effectParams2.effect = xi.effect.ATTACK_DOWN
    effectParams2.skillType = xi.skill.GREAT_AXE
    effectParams2.duration = (tp / 1000 * 60) + 120
    effectParams2.power = 12.5
    effectParams2.tick = 0
    effectParams2.maccBonus = 0

    local effectParams3 = {}
    effectParams3.element = xi.magic.ele.ICE
    effectParams3.effect = xi.effect.EVASION_DOWN
    effectParams3.skillType = xi.skill.GREAT_AXE
    effectParams3.duration = (tp / 1000 * 60) + 120
    effectParams3.power = 20
    effectParams3.tick = 0
    effectParams3.maccBonus = 0

    local effectParams4 = {}
    effectParams4.element = xi.magic.ele.EARTH
    effectParams4.effect = xi.effect.ACCURACY_DOWN
    effectParams4.skillType = xi.skill.GREAT_AXE
    effectParams4.duration = (tp / 1000 * 60) + 120
    effectParams4.power = 20
    effectParams4.tick = 0
    effectParams4.maccBonus = 0

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 then
        xi.magic.applyAbilityResistance(player, target, effectParams)
        xi.magic.applyAbilityResistance(player, target, effectParams2)
        xi.magic.applyAbilityResistance(player, target, effectParams3)
        xi.magic.applyAbilityResistance(player, target, effectParams4)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
