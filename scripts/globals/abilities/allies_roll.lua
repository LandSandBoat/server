-----------------------------------
-- Ability: Allies's Roll
-- Enhances skillchain damage and skillchain accuracy for party members within area of effect.
-- Optimal Job: None
-- Lucky Number: 3
-- Unlucky Number: 10
-- Level: 89
-- Phantom Roll +1 Value: 1
--
-- Die Roll    | Skillchain Bonus
-- --------    -------
-- 1           |+2
-- 2           |+3
-- 3           |+20
-- 4           |+5
-- 5           |+7
-- 6           |+9
-- 7           |+11
-- 8           |+13
-- 9           |+15
-- 10          |+1
-- 11          |+25
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
    local effectID = tpz.effect.ALLIES_ROLL
    return corsair.onRollAbilityCheck(player, target, ability, effectID)
end

ability_object.onUseAbility = function(caster, target, ability, action)
    local effectID = tpz.effect.ALLIES_ROLL
    local bonusJob = tpz.job.COR
    return corsair.onRollUseAbility(caster, target, ability, action, effectID, bonusJob)
end

return ability_object
