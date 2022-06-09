-----------------------------------
-- Ability: Convert
-- Swaps current HP with MP.
-- Obtained: Red Mage Level 40
-- Recast Time: 10:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local playerMP = player:getMP()
    local playerHP = player:getHP()
    local jpValue = player:getJobPointLevel(xi.jp.CONVERT_EFFECT)

    if playerMP > 0 then
        -- Murgleis sword augments Convert.
        if player:getMod(xi.mod.AUGMENTS_CONVERT) > 0 and playerHP > player:getMaxHP()/2 then
            playerHP = playerHP * player:getMod(xi.mod.AUGMENTS_CONVERT)
        end

        player:setHP(playerMP + (playerHP * (jpValue * 0.01)))
        player:setMP(playerHP)
    end
end

return ability_object
