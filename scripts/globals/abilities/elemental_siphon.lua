-----------------------------------
-- Ability: Elemental Siphon
-- Drains MP from your summoned spirit.
-- Obtained: Summoner level 50
-- Recast Time: 5:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local pet = player:getPetID()
    if (pet >= 0 and pet <= 7) then -- spirits
        return 0, 0
    else
        return xi.msg.basic.UNABLE_TO_USE_JA, 0
    end
end

ability_object.onUseAbility = function(player,target,ability)
    local spiritEle = player:getPetElement() -- Just pulled the element ID for the pet to reduce confusion if future changes are made to sql database housing pets
    -- element order: fire, ice, wind, earth, thunder, water, light, dark

    local pEquipMods = player:getMod(xi.mod.ENHANCES_ELEMENTAL_SIPHON) --Will be in era if expansions between TOAU/WINGS are implemented
    local basePower = player:getSkillLevel(xi.skill.SUMMONING_MAGIC) + pEquipMods - 50
    if (basePower < 0) then
        basePower = 0
    end
    local weatherDayBase = 1
    local dayBonus = 0
    local weatherBonus = 0
    local dayElement = VanadielDayElement()
    local weather = player:getWeather()

    -- Day bonus/penalty
    if (dayElement == spiritEle) then
        dayBonus = dayBonus + 0.1
    elseif (dayElement == xi.magic.elementDescendant[spiritEle]) then
        dayBonus = dayBonus - 0.1
    end
    -- Weather bonus/penalty
    if (weather == xi.magic.singleWeatherStrong[spiritEle]) then
        weatherBonus = weatherBonus + 0.1
    elseif (weather == xi.magic.singleWeatherWeak[spiritEle]) then
        weatherBonus = weatherBonus - 0.1
    elseif (weather == xi.magic.doubleWeatherStrong[spiritEle]) then
        weatherBonus = weatherBonus + 0.25
    elseif (weather == xi.magic.doubleWeatherWeak[spiritEle]) then
        weatherBonus = weatherBonus - 0.25
    end

    local power = math.floor(basePower * (weatherDayBase + dayBonus + weatherBonus))
    local spirit = player:getPet()
    power = utils.clamp(power, 0, spirit:getMP()) -- cap MP drained at spirit's MP
    power = utils.clamp(power, 0, player:getMaxMP() - player:getMP()) -- cap MP drained at the max MP - current MP

    spirit:delMP(power)
    return player:addMP(power)
end

return ability_object
