-----------------------------------
-- Ability: Elemental Siphon
-- Drains MP from your summoned spirit.
-- Obtained: Summoner level 50
-- Recast Time: 5:00
-- Duration: Instant
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    local pet = player:getPet()
    local petID = 0

    if pet then
        petID = pet:getPetID()

        if petID >= xi.petId.FIRE_SPIRIT and petID <= xi.petId.DARK_SPIRIT then -- spirits
            return 0, 0
        end
    end

    return xi.msg.basic.UNABLE_TO_USE_JA, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    local spirit = player:getPet()
    if not spirit then
        return 0
    end

    local spiritElement = spirit:getPetID() + 1
    if not spiritElement then
        return 0
    end

    -- Calculate potency.
    local power = utils.clamp(player:getSkillLevel(xi.skill.SUMMONING_MAGIC), 0, 700)                      -- Skill
    power       = math.floor(power * 1.05 + player:getMod(xi.mod.ENHANCES_ELEMENTAL_SIPHON) - 55)          -- Gear
    power       = math.floor(power * xi.spells.damage.calculateDayAndWeather(player, spiritElement, true)) -- Day and Weather bonuses (Forced)
    power       = math.floor(power + player:getJobPointLevel(xi.jp.ELEMENTAL_SIPHON_EFFECT) * 3)           -- Job Points

    -- Enforce special limits (player and spirit mp)
    power = utils.clamp(power, 0, spirit:getMP())                     -- Cap MP drained at spirit's MP
    power = utils.clamp(power, 0, player:getMaxMP() - player:getMP()) -- Cap MP drained at the max MP - current MP

    spirit:delMP(power)

    return player:addMP(power)
end

return abilityObject
