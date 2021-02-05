-----------------------------------
-- Ability: Drachen Roll
-- Enhances pet accuracy for party members within area of effect
-- Optimal Job: Dragoon
-- Lucky Number: 4
-- Unlucky Number: 8
-- Level: 23
-- Phantom Roll +1 Value: 5
--
-- Die Roll    |No DRG  |With DRG
-- --------    -------  -----------
-- 1           |+10     |+25
-- 2           |+13     |+28
-- 3           |+15     |+30
-- 4           |+40     |+55
-- 5           |+18     |+33
-- 6           |+20     |+35
-- 7           |+25     |+40
-- 8           |+5      |+20
-- 9           |+28     |+43
-- 10          |+30     |+45
-- 11          |+50     |+65
-- Bust        |-15     |-15
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
local corsair = require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local effectID = tpz.effect.DRACHEN_ROLL
    return corsair.onRollAbilityCheck(player, target, ability, effectID)
end

ability_object.onUseAbility = function(caster, target, ability, action)
    local effectID = tpz.effect.DRACHEN_ROLL
    local bonusJob = tpz.job.DRG
    return corsair.onRollUseAbility(caster, target, ability, action, effectID, bonusJob)
end

return ability_object
