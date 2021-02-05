-----------------------------------
-- Ability: Evoker's Roll
-- Gradually restores MP for party members within area of effect
-- Optimal Job: Summoner
-- Lucky Number: 5
-- Unlucky Number: 9
-- Level: 40
-- Phantom Roll +1 Value: 1
--
-- Die Roll    |No SMN  |With SMN
-- --------    -------  -----------
-- 1           |+1      |+2
-- 2           |+1      |+2
-- 3           |+1      |+2
-- 4           |+1      |+2
-- 5           |+3      |+4
-- 6           |+2      |+3
-- 7           |+2      |+3
-- 8           |+2      |+3
-- 9           |+1      |+2
-- 10          |+3      |+4
-- 11          |+4      |+5
-- Bust        |-1      |-1
--
-- Busting on Evoker's Roll will give you -1MP/tick less on your own total MP refreshed i.e. you do not actually lose MP
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
local corsair = require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local effectID = tpz.effect.EVOKERS_ROLL
    return corsair.onAbilityCheck(player, target, ability, effectID)
end

ability_object.onUseAbility = function(caster, target, ability, action)
    if caster:getID() == target:getID() then
        corsair.corsairSetup(caster, ability, action, tpz.effect.EVOKERS_ROLL, tpz.job.SMN)
    end
    local total = caster:getLocalVar("corsairRollTotal")
    return corsair.applyRoll(caster, target, ability, action, total)
end

return ability_object
