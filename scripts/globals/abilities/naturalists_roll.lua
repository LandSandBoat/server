-----------------------------------
-- Ability: Naturalists's Roll
-- Increases the duration of enhancing magic effects received for party members within area of effect.
-- Optimal Job: Geomancer
-- Lucky Number: 3
-- Unlucky Number: 7
-- Level: 67
-- Phantom Roll +1 Value: 1
--
-- Die Roll    | Duration %
-- --------    -------
-- 1           |+6
-- 2           |+7
-- 3           |+15
-- 4           |+8
-- 5           |+9
-- 6           |+10
-- 7           |+5
-- 8           |+11
-- 9           |+12
-- 10          |+13
-- 11          |+20
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
    local effectID = tpz.effect.NATURALISTS_ROLL
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
        corsair.corsairSetup(caster, ability, action, tpz.effect.NATURALISTS_ROLL, tpz.job.GEO)
    end
    local total = caster:getLocalVar("corsairRollTotal")
    return corsair.applyRoll(caster, target, ability, action, total)
end

return ability_object
