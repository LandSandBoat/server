-----------------------------------
-- Ability: Enmity Douse
-- Description: Reduces the target's enmity towards you.
-- Obtained: BLM Level 87
-- Recast Time: 0:10:00
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
--[[    if target:isMob() then
        local enmityShed = 100
        if player:getMainJob() ~= xi.job.BLM then
            enmityShed = 1000
        end
    end ]]--
end

return ability_object
