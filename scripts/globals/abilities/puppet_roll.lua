-----------------------------------
-- Ability: Puppet Roll
-- Enhances pet magic attack and magic accuracy for party members within area of effect
-- Optimal Job: Puppetmaster
-- Lucky Number: 3
-- Unlucky Number: 7
-- Level: 52
-- Phantom Roll +1 Value: 3
--
-- Die Roll    |No PUP  |With PUP
-- --------    -------  ----------
-- 1           |+4      |+12
-- 2           |+5      |+13
-- 3           |+18     |+26
-- 4           |+7      |+15
-- 5           |+9      |+17
-- 6           |+10     |+18
-- 7           |+2      |+10
-- 8           |+11     |+19
-- 9           |+13     |+21
-- 10          |+15     |+23
-- 11          |+22     |+30
-- Bust        |-8      |-8
-----------------------------------
local corsair = require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return corsair.onRollAbilityCheck(player, target, ability)
end

ability_object.onUseAbility = function(caster, target, ability, action)
    return corsair.onRollUseAbility(caster, target, ability, action)
end

return ability_object
