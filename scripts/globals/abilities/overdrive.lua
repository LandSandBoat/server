-----------------------------------
-- Ability: Overdrive
-- Augments the fighting ability of your automaton to its maximum level.
-- Obtained: Puppetmaster Level 1
-- Recast Time: 1:00:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if not player:getPet() then
        return xi.msg.basic.REQUIRES_A_PET, 0
    elseif not player:getPetID() or not (player:getPetID() >= 69 and player:getPetID() <= 72) then
        return xi.msg.basic.NO_EFFECT_ON_PET, 0
    else
        ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))
        return 0, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.OVERDRIVE, 0, 0, 60)
    return xi.effect.OVERDRIVE
end

return ability_object
