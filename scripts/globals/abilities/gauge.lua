-----------------------------------
-- Ability: Gauge
-- Checks to see if an enemy can be charmed.
-- Obtained: Beastmaster Level 10
-- Recast Time: 0:30
-- Duration: Instant
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if player:getPet() ~= nil then
        return xi.msg.basic.ALREADY_HAS_A_PET, 0
    end

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    local charmChance = player:getCharmChance(target, false)

    if charmChance >= 75 then
        ability:setMsg(xi.msg.basic.SHOULD_BE_ABLE_CHARM)  -- The <player> should be able to charm <target>.
    elseif charmChance >= 50 then
        ability:setMsg(xi.msg.basic.MIGHT_BE_ABLE_CHARM)   -- The <player> might be able to charm <target>.
    elseif charmChance >= 25 then
        ability:setMsg(xi.msg.basic.DIFFICULT_TO_CHARM)    -- It would be difficult for the <player> to charm <target>.
    elseif charmChance >= 1 then
        ability:setMsg(xi.msg.basic.VERY_DIFFICULT_CHARM)  -- It would be very difficult for the <player> to charm <target>.
    else
        ability:setMsg(xi.msg.basic.CANNOT_CHARM)          -- The <player> cannot charm <target>!
    end
end

return abilityObject
