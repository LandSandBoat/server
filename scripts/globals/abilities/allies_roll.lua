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
corsair = require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local effectID = tpz.effect.ALLIES_ROLL
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
        corsairSetup(caster, ability, action, tpz.effect.ALLIES_ROLL, tpz.job.COR)
    end
    local total = caster:getLocalVar("corsairRollTotal")
    return corsair.applyRoll(caster, target, ability, action, total)
end

return ability_object
