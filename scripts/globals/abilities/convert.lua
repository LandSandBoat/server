-----------------------------------
-- Ability: Convert
-- Swaps current HP with MP.
-- Obtained: Red Mage Level 40
-- Recast Time: 10:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local MP = player:getMP()
    local HP = player:getHP()
    if MP > 0 then
        -- Murgleis sword augments Convert.
        if player:getMod(xi.mod.AUGMENTS_CONVERT) > 0 and HP > player:getMaxHP()/2 then
            HP = HP * player:getMod(xi.mod.AUGMENTS_CONVERT)
        end
        player:setHP(MP)
        player:setMP(HP)
    end
end

return ability_object
