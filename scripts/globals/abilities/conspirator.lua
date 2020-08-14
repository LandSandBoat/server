-----------------------------------
-- Ability: Conspirator
-- Enhances accuracy and "Subtle Blow" effect for party members within area of effect.
-- Does not affect the party member being targeted by the enemy.
-- Obtained: Thief Level 87
-- Recast Time: 5:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local subtleBlow = 0
    local accuracy = 0
    local scale = 1
    local mob = player:getTarget()
    if mob then
        local enmityList = mob:getEnmityList()
        if enmityList and #enmityList > 0 then
            if #enmityList < 6 then
                subtleBlow = 20
                accuracy = 15
            elseif #enmityList < 18 then
                subtleBlow = 50
                accuracy = 25
            else
                subtleBlow = 50
                accuracy = 49
            end
        end

        -- See if we should apply the effects to the player at the top of the hate list
        if mob:getTarget() == target then
            scale = player:getMod(tpz.mod.AUGMENTS_CONSPIRATOR)
        end
    end

    target:addStatusEffect(tpz.effect.CONSPIRATOR, subtleBlow * scale, 0, 60, 0, accuracy * scale)
end
