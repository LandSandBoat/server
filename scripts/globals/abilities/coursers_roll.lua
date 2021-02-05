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
    ability:setRange(ability:getRange() + player:getMod(tpz.mod.ROLL_RANGE))
    if player:hasStatusEffect(effectID) then
        return tpz.msg.basic.ROLL_ALREADY_ACTIVE, 0
    elseif corsair.atMaxCorsairBusts(player) then
        return tpz.msg.basic.CANNOT_PERFORM, 0
    else
        return 0, 0
    end
end

ability_object.onUseAbility = function(caster, target, ability, action)
    if caster:getID() == target:getID() then
        corsair.corsairSetup(caster, ability, action, tpz.effect.COURSERS_ROLL, tpz.job.COR)
    end
    local total = caster:getLocalVar("corsairRollTotal")
    return corsair.applyRoll(caster, target, ability, action, total)
end

return ability_object
