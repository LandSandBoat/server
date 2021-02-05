-----------------------------------
-- Ability: Ninja Roll
-- Enhances evasion for party members within area of effect
-- Optimal Job: Ninja
-- Lucky Number: 4
-- Unlucky Number: 8
-- Jobs:
-- Corsair Level 8
-- Phantom Roll +1 Value: 2
--
-- Die Roll    |With NIN
-- --------    ----------
-- 1           |+4
-- 2           |+6
-- 3           |+8
-- 4           |+25
-- 5           |+10
-- 6           |+12
-- 7           |+14
-- 8           |+2
-- 9           |+17
-- 10          |+20
-- 11          |+30
-- Bust        |-10
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
local corsair = require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local effectID = tpz.effect.NINJA_ROLL
    return corsair.onRollAbilityCheck(player, target, ability, effectID)
end

ability_object.onUseAbility = function(caster, target, ability, action)
    local effectID = tpz.effect.NINJA_ROLL
    local bonusJob = tpz.job.NIN
    return corsair.onRollUseAbility(caster, target, ability, action, effectID, bonusJob)
end

return ability_object
