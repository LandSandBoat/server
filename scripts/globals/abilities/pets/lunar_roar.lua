---------------------------------------------
-- Aerial Armor
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    target:dispelStatusEffect()
    target:dispelStatusEffect()
    skill:setMsg(tpz.msg.basic.NONE)
    return 0
end
