-----------------------------------
-- Ability: Monk's Roll
-- Enhances "Subtle Blow" effect for party members within area of effect
-- Optimal Job: Monk
-- Lucky Number: 3
-- Unlucky Number: 7
-- Level: 31
-- Phantom Roll +1 Value: 4
--
-- Die Roll    |No MNK  |With MNK
-- --------    -------- -----------
-- 1           |+8      |+18
-- 2           |+10     |+20
-- 3           |+32     |+42
-- 4           |+12     |+22
-- 5           |+14     |+24
-- 6           |+16     |+26
-- 7           |+4      |+14
-- 8           |+20     |+30
-- 9           |+22     |+32
-- 10          |+24     |+34
-- 11          |+40     |+50
-- Bust        |-11     |-11
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
