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
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 1, 1, 1 }
    params.str_wsc = 0.5
    params.vit_wsc = 0.5

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effects.
    local effects =
    {
        [1] = { xi.effect.ATTACK_DOWN,   xi.element.WATER, 12.5 },
        [2] = { xi.effect.DEFENSE_DOWN,  xi.element.WIND,  12.5 },
        [3] = { xi.effect.ACCURACY_DOWN, xi.element.EARTH, 20   },
        [4] = { xi.effect.EVASION_DOWN,  xi.element.ICE,   20   },
    }

    for index = 1, #effects do
        local effectId      = effects[index][1]
        local actionElement = effects[index][2]
        local power         = effects[index][3]
        local duration      = math.floor(60 + 3 * tp / 100 * applyResistanceAddEffect(player, target, actionElement, 0))
        xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
