-----------------------------------
-- Aerial Armor
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill)
    target:dispelStatusEffect()
    target:dispelStatusEffect()
    skill:setMsg(tpz.msg.basic.NONE)
    return 0
end

return ability_object
