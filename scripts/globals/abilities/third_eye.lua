-----------------------------------
-- Ability: Third Eye
-- Anticipates and dodges the next attack directed at you.
-- Obtained: Samurai Level 15
-- Recast Time: 1:00
-- Duration: 0:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if player:hasStatusEffect(tpz.effect.SEIGAN) then
        ability:setRecast(ability:getRecast() / 2)
    end
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    if player:hasStatusEffect(tpz.effect.COPY_IMAGE) or player:hasStatusEffect(tpz.effect.BLINK) then
        -- Returns "no effect" message when Copy Image is active when Third Eye is used.
        ability:setMsg(tpz.msg.basic.JA_NO_EFFECT)
    else
        player:addStatusEffect(tpz.effect.THIRD_EYE, 0, 0, 30) -- Power keeps track of procs
    end
end

return ability_object
