-----------------------------------
-- Ability: Deep Breathing
-- Enhances the effect of next breath used by wyvern.
-- Obtained: Dragoon Level 75
-- Recast Time: 5 minutes
-- Duration: 0:03:00 or until the next breath is executed
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if (player:getPet() == nil) then
        return tpz.msg.basic.REQUIRES_A_PET, 0
   elseif (player:getPetID() ~= tpz.pet.id.WYVERN) then
      return tpz.msg.basic.NO_EFFECT_ON_PET, 0
    else
      return 0, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)
   local wyvern = player:getPet()
   wyvern:addStatusEffect(tpz.effect.MAGIC_ATK_BOOST, 0, 0, 180) -- Message when effect is lost is "Magic Attack boost wears off."
end

return ability_object
