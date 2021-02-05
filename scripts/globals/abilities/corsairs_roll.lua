-----------------------------------
-- Ability: Corsair's Roll
-- Increases the amount of experience points earned by party members within area of effect
-- Optimal Job: Corsair
-- Lucky Number: 5
-- Unlucky Number: 9
-- Level: 5
-- Phantom Roll +1 Value: 2
--
-- Die Roll    |Exp Bonus%
-- --------    -----------
-- 1           |10%
-- 2           |11%
-- 3           |11%
-- 4           |12%
-- 5           |20%
-- 6           |13%
-- 7           |15%
-- 8           |16%
-- 9           |8%
-- 10          |17%
-- 11          |24%
-- 12+         |-6%
--
-- Bust for Corsair set as subjob is also -6%.
-- Corsair set as subjob is 7% on Lucky roll (5) and 1% on Unlucky roll (9).
-- The EXP bonus afforded by Corsair's Roll does not apply within Abyssea.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
local corsair = require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local effectID = tpz.effect.CORSAIRS_ROLL
    return corsair.onRollAbilityCheck(player, target, ability, effectID)
end

ability_object.onUseAbility = function(caster, target, ability, action)
    local effectID = tpz.effect.CORSAIRS_ROLL
    local bonusJob = tpz.job.COR
    return corsair.onRollUseAbility(caster, target, ability, action, effectID, bonusJob)
end

return ability_object
