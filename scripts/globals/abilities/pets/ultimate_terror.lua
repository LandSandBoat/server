---------------------------------------------
-- Ultimate Terror
--
-- Description: AoE Absorb All with randomness
-- Type: Magical
---------------------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/magic")
---------------------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local drained = 0
    local randomDrainAmount = math.random(0, 7) -- Drain 0-7 stats at random PER target
    local skillOverCap = utils.clamp(xi.summon.getSummoningSkillOverCap(pet), 0, 150) -- 1 second / skill | Duration cap is 180 total
    local duration = 30 + skillOverCap

    local effects =
    {
        { xi.effect.STR_DOWN, math.random(0, 7), 3, duration },
        { xi.effect.DEX_DOWN, math.random(0, 7), 3, duration },
        { xi.effect.VIT_DOWN, math.random(0, 7), 3, duration },
        { xi.effect.AGI_DOWN, math.random(0, 7), 3, duration },
        { xi.effect.INT_DOWN, math.random(0, 7), 3, duration },
        { xi.effect.MND_DOWN, math.random(0, 7), 3, duration },
        { xi.effect.CHR_DOWN, math.random(0, 7), 3, duration }
    }

    for _, eff in pairs(effects) do
        if math.random(0, 7) <= randomDrainAmount then
            skill:setMsg(xi.mobskills.mobDrainAttribute(pet, target, eff[1], eff[2], eff[3], eff[4]))
            drained = drained + 1
        end
    end

    return drained
end

return abilityObject
