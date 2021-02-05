-----------------------------------
-- Ability: Wizard's Roll
-- Enhances magic attack for party members within area of effect
-- Optimal Job: Black Mage
-- Lucky Number: 5
-- Unlucky Number: 9
-- Level 58
-- Phantom Roll +1 Value: 2
--
-- Die Roll    |No BLM  |With BLM
-- --------    -------- -----------
-- 1           |+4      |+14
-- 2           |+6      |+16
-- 3           |+8      |+18
-- 4           |+10     |+20
-- 5           |+25     |+35
-- 6           |+12     |+22
-- 7           |+14     |+24
-- 8           |+17     |+27
-- 9           |+2      |+12
-- 10          |+20     |+10
-- 11          |+30     |+40
-- Bust        |-10     |-10
--
-- If the Corsair is a lower level than the player receiving Wizard's Roll, the +MAB will be reduced
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
local corsair = require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local effectID = tpz.effect.WIZARDS_ROLL
    return corsair.onRollAbilityCheck(player, target, ability, effectID)
end

ability_object.onUseAbility = function(caster, target, ability, action)
    local effectID = tpz.effect.WIZARDS_ROLL
    local bonusJob = tpz.job.BLM
    return corsair.onRollUseAbility(caster, target, ability, action, effectID, bonusJob)
end

return ability_object
