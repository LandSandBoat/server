-----------------------------------
-- Ability: Sic
-- Commands the charmed Pet to make a random special attack.
-- Obtained: Beastmaster Level 25
-- Recast Time: 2 minutes
-- Duration: N/A
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if player:getPet() == nil then
        return xi.msg.basic.REQUIRES_A_PET, 0
    else
        if player:getPet():getHP() == 0 then
            return xi.msg.basic.UNABLE_TO_USE_JA, 0
        elseif player:getPet():getTarget() == nil then
            return xi.msg.basic.PET_CANNOT_DO_ACTION, 0
        elseif not player:getPet():hasTPMoves() then
            return xi.msg.basic.UNABLE_TO_USE_JA, 0
        else
            return 0, 0
        end
    end
end

abilityObject.onUseAbility = function(player, target, ability)
    local function doSic(mob)
        if mob:getTP() >= 1000 then
            mob:useMobAbility()
        elseif mob:hasSpellList() then
            mob:castSpell()
        else
            mob:queue(0, doSic)
        end
    end

    player:getPet():queue(0, doSic)
end

return abilityObject
