-----------------------------------
-- Ability: Cover
-- Allows you to protect party members by placing yourself between them and the enemy
-- Obtained: Paladin Level 35
-- Recast Time: 0:03:00
-- Duration: 0:00:15 - 0:00:30
-- Info from https://www.bg-wiki.com/bg/Cover
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if target == nil or target:getID() == player:getID() or not target:isPC() then
        return xi.msg.basic.CANNOT_PERFORM_TARG, 0
    else
        return 0, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)
    local baseDuration = 15
    local bonusTime    = utils.clamp(math.floor((player:getStat(xi.mod.VIT) + player:getStat(xi.mod.MND) - target:getStat(xi.mod.VIT) * 2) / 4), 0, 15)
    local duration     = baseDuration + bonusTime + player:getMerit(xi.merit.COVER_EFFECT_LENGTH) + player:getMod(xi.mod.COVER_DURATION)

    player:addStatusEffect(xi.effect.COVER, player:getMod(xi.mod.COVER_TO_MP), 0, duration)
    player:setLocalVar("COVER_ABILITY_TARGET", target:getID())
    ability:setMsg(xi.msg.basic.COVER_SUCCESS)
end


return ability_object
