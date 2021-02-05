-----------------------------------
-- Ability: Magus's Roll
-- Enhances magic defense for party members within area of effect
-- Optimal Job: Blue Mage
-- Lucky Number: 2
-- Unlucky Number: 6
-- Level: 17
-- Phantom Roll +1 Value: 2
--
-- Die Roll    |No BLU  |With BLU
-----------    -------  -----------
-- 1           |+5      |+13
-- 2           |+20     |+28
-- 3           |+6      |+14
-- 4           |+8      |+16
-- 5           |+9      |+17
-- 6           |+3      |+11
-- 7           |+10     |+18
-- 8           |+13     |+21
-- 9           |+14     |+22
-- 10          |+15     |+23
-- 11          |+25     |+33
-- Bust        |-5      |-5
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
local corsair = require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local effectID = tpz.effect.MAGUSS_ROLL
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
        corsair.corsairSetup(caster, ability, action, tpz.effect.MAGUSS_ROLL, tpz.job.BLU)
    end

    local total = caster:getLocalVar("corsairRollTotal")
    return corsair.applyRoll(caster, target, ability, action, total)
end

return ability_object
