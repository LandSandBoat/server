-----------------------------------
-- Ability: Elemental Siphon
-- Drains MP from your summoned spirit.
-- Obtained: Summoner level 50
-- Recast Time: 5:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/pets")
require("scripts/globals/utils")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    local pet = player:getPet()
    local petID = 0

    if pet then
        petID = pet:getPetID()
    end

    if petID >= xi.pet.id.FIRE_SPIRIT and petID <= xi.pet.id.DARK_SPIRIT then -- spirits
        return 0, 0
    end

    return xi.msg.basic.UNABLE_TO_USE_JA, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    local spirit    = player:getPet()
    local spiritEle = 0

    -- get the spirit's ID, it is already aligned in proper element order
    -- element order: fire, ice, wind, earth, thunder, water, light, dark
    if spirit then
        spiritEle = spirit:getPetID() + 1
    end

    local pEquipMods = player:getMod(xi.mod.ENHANCES_ELEMENTAL_SIPHON)
    local basePower  = player:getSkillLevel(xi.skill.SUMMONING_MAGIC) + pEquipMods - 50

    if basePower < 0 then
        basePower = 0
    end

    local weatherDayBonus = 1
    local dayElement      = VanadielDayElement()
    local weather         = player:getWeather()

    -- Day bonus/penalty
    if dayElement == xi.magic.dayStrong[spiritEle] then
        weatherDayBonus = weatherDayBonus + 0.1
    elseif dayElement == xi.magic.dayWeak[spiritEle] then
        weatherDayBonus = weatherDayBonus - 0.1
    end

    -- Weather bonus/penalty
    if weather == xi.magic.singleWeatherStrong[spiritEle] then
        weatherDayBonus = weatherDayBonus + 0.1
    elseif weather == xi.magic.singleWeatherWeak[spiritEle] then
        weatherDayBonus = weatherDayBonus - 0.1
    elseif weather == xi.magic.doubleWeatherStrong[spiritEle] then
        weatherDayBonus = weatherDayBonus + 0.25
    elseif weather == xi.magic.doubleWeatherWeak[spiritEle] then
        weatherDayBonus = weatherDayBonus - 0.25
    end

    local power  = math.floor(basePower * weatherDayBonus)
    power        = utils.clamp(power, 0, spirit:getMP()) -- cap MP drained at spirit's MP
    power        = utils.clamp(power, 0, player:getMaxMP() - player:getMP()) -- cap MP drained at the max MP - current MP

    spirit:delMP(power)

    return player:addMP(power)
end

return abilityObject
