-----------------------------------
-- Ability: Hunter's Roll
-- Enhances accuracy and ranged accuracy for party members within area of effect
-- Optimal Job: Ranger
-- Lucky Number: 4
-- Unlucky Number: 8
-- Level: 11
-- Phantom Roll +1 Value: 5
--
-- Die Roll    |Without RNG |With RNG
-- --------    ------------ -------
-- 1           |+10         |+25
-- 2           |+13         |+28
-- 3           |+15         |+30
-- 4           |+40         |+55
-- 5           |+18         |+33
-- 6           |+20         |+35
-- 7           |+25         |+40
-- 8           |+5          |+20
-- 9           |+27         |+42
-- 10          |+30         |+45
-- 11          |+50         |+65
-- Bust        |-5          |-5
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
local corsair = require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local effectID = tpz.effect.HUNTERS_ROLL
    return corsair.onRollAbilityCheck(player, target, ability, effectID)
end

ability_object.onUseAbility = function(caster, target, ability, action)
    local effectID = tpz.effect.HUNTERS_ROLL
    local bonusJob = tpz.job.RNG
    return corsair.onRollUseAbility(caster, target, ability, action, effectID, bonusJob)
end

return ability_object
