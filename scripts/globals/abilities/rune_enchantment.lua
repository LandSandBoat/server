-----------------------------------
-- Ability: Rune Enchantment
-- Allows you to harbor runes
-- Obtained: Rune Fencer Level 5
-- Recast Time: 0:10
-- Duration: 5:00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(user, target, ability)
    -- Leave blank.
end

-- helpers for runes
function getRUNLevel(player)
    return player:getMainJob() == xi.job.RUN and player:getMainLvl() or player:getSubLvl()
end

function applyRuneEnhancement(effectType, player)
    local RUNLevel = getRUNLevel(player)
    local meritBonus = (player:getMerit(xi.merit.MERIT_RUNE_ENHANCE) * 2) -- 2 more elemental resistance per merit for a maximum total of (2*5) = 10
    local jobPointBonus = player:getJobPointLevel(xi.jp.RUNE_ENCHANTMENT_EFFECT) -- 1 more elemental resistance per level for a maximum total of 20
	
    -- see https://www.bg-wiki.com/ffxi/Category:Rune
    local power = math.floor((49 * RUNLevel / 99) + 5.5) + meritBonus  + jobPointBonus
    player:addStatusEffect(effectType, power, 0, 300)
end

function enforceRuneCounts(target)
    local RUNLevel = getRUNLevel(target)
    local maxRunes = RUNLevel >= 65 and 3 or RUNLevel >= 35 and 2 or 1
    local effects = target:getStatusEffects()
    local runes = { }
    local i = 0

    for _, effect in ipairs(effects) do
        type = effect:getType()
        if type >= xi.effect.IGNIS and type <= xi.effect.TENEBRAE then
            runes[i+1] = effect
            i = i + 1
        end
    end

    if i >= maxRunes then -- delete the first rune in the list with the least duration
        target:delStatusEffect(runes[1]:getType())
    end
end

return ability_object
