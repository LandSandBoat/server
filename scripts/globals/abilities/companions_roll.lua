-----------------------------------
-- Ability: Companion's Roll
-- Grants "Regain" and "Regen" effects to pets of party members within area of effect.
-- Optimal Job: None
-- Lucky Number: 2
-- Unlucky Number: 10
-- Level: 95
-- Phantom Roll +1 Value: 5/2
--
-- Die Roll Logic in globals/effects/companions_roll.lua
--
-- Die Roll    | Regain | Regen
-- --------    -------   -------
-- 1           |+20     |+4
-- 2           |+50     |+20
-- 3           |+20     |+6
-- 4           |+20     |+8
-- 5           |+30     |+10
-- 6           |+30     |+12
-- 7           |+30     |+14
-- 8           |+40     |+16
-- 9           |+40     |+18
-- 10          |+10     |+3
-- 11          |+60     |+25
-- Bust        |-0      | 0
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
corsair = require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local effectID = tpz.effect.COMPANIONS_ROLL
    ability:setRange(ability:getRange() + player:getMod(tpz.mod.ROLL_RANGE))
    if (player:hasStatusEffect(effectID)) then
        return tpz.msg.basic.ROLL_ALREADY_ACTIVE, 0
    elseif atMaxCorsairBusts(player) then
        return tpz.msg.basic.CANNOT_PERFORM, 0
    else
        return 0, 0
    end
end

ability_object.onUseAbility = function(caster, target, ability, action)
    if (caster:getID() == target:getID()) then
        corsairSetup(caster, ability, action, tpz.effect.COMPANIONS_ROLL, tpz.job.COR)
    end
    local total = caster:getLocalVar("corsairRollTotal")
    return corsair.applyRoll(caster, target, ability, action, total)
end

return ability_object
