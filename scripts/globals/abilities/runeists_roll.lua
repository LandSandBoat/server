-----------------------------------
-- Ability: Runeist's Roll
-- Enhances magic evasion for party members within area of effect.
-- Optimal Job: Rune Fencer
-- Lucky Number: 4
-- Unlucky Number: 8
-- Level: 70
-- Phantom Roll +1 Value: 2
--
-- Die Roll    | MEVA+
-- --------    -------
-- 1           |+4
-- 2           |+6
-- 3           |+8
-- 4           |+25
-- 5           |+10
-- 6           |+12
-- 7           |+14
-- 8           |+2
-- 9           |+17
-- 10          |+20
-- 11          |+30
-- Bust        |-10
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
local corsair = require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local effectID = tpz.effect.RUNEISTS_ROLL
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
        corsair.corsairSetup(caster, ability, action, tpz.effect.RUNEISTS_ROLL, tpz.job.RUN)
    end
    local total = caster:getLocalVar("corsairRollTotal")
    return corsair.applyRoll(caster, target, ability, action, total)
end

return ability_object
