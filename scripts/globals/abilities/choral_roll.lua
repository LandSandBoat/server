-----------------------------------
-- Ability: Choral Roll
-- Decreases spell interruption rate for party members within area of effect
-- Optimal Job: Bard
-- Lucky Number: 2
-- Unlucky Number: 6
-- Level: 26
-- Phantom Roll +1 Value: 4
--
-- Die Roll     |No BRD     |With BRD
-- --------     --------    -------
-- 1            |-13        |-38
-- 2            |-55        |-80
-- 3            |-17        |-42
-- 4            |-20        |-45
-- 5            |-25        |-50
-- 6            |-8         |-33
-- 7            |-30        |-55
-- 8            |-35        |-60
-- 9            |-40        |-65
-- 10           |-45        |-70
-- 11           |-65        |-90
-- Bust         |+25        |+25
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
local corsair = require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local effectID = tpz.effect.CHORAL_ROLL
    return corsair.onRollAbilityCheck(player, target, ability, effectID)
end

ability_object.onUseAbility = function(caster, target, ability, action)
    local effectID = tpz.effect.CHORAL_ROLL
    local bonusJob = tpz.job.BRD
    return corsair.onRollUseAbility(caster, target, ability, action, effectID, bonusJob)
end

return ability_object
