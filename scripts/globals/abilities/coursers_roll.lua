-----------------------------------
-- Ability: Courser's Roll
-- Enhances "Snapshot" effect for party members within area of effect.
-- Optimal Job: None
-- Lucky Number: 3
-- Unlucky Number: 9
-- Level: 81
-- Phantom Roll +1 Value: 1
--
-- No Reliable Community Data available. Numbers Based on Blitzer's Roll Values.
--
-- Die Roll    | Snapshot+
-- --------    -------
-- 1           |+2
-- 2           |+3
-- 3           |+11
-- 4           |+4
-- 5           |+5
-- 6           |+6
-- 7           |+7
-- 8           |+8
-- 9           |+1
-- 10          |+10
-- 11          |+12
-- Bust        |-5
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
local corsair = require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local effectID = tpz.effect.COURSERS_ROLL
    return corsair.onRollAbilityCheck(player, target, ability, effectID)
end

ability_object.onUseAbility = function(caster, target, ability, action)
    local effectID = tpz.effect.COURSERS_ROLL
    local bonusJob = tpz.job.COR
    return corsair.onRollUseAbility(caster, target, ability, action, effectID, bonusJob)
end

return ability_object
