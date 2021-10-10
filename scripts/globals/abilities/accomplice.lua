-----------------------------------
-- Ability: Accomplice
-- Steals half of the target party member's enmity and redirects it to the thief.
-- Obtained: Thief Level 65
-- Recast Time: 5:00
-- Duration: Instant
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if (target == nil or target:getID() == player:getID() or not target:isPC()) then
        return xi.msg.basic.CANNOT_ON_THAT_TARG, 0
    else
        return 0, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)
    target:transferEnmity(player, 50 + player:getMod(xi.mod.ACC_COLLAB_EFFECT), 20.6)
end

return ability_object
