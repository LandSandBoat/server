-----------------------------------
-- Tables defining diferent elemental caracteristics.
-- Ordered by element ID.
-----------------------------------
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.element = xi.combat.element or {}
-----------------------------------

local column =
{
    ELEMENT_OPPOSED       =  1,
    DAY_ASSOCIATED        =  2,
    WEATHER_SINGLE        =  3,
    WEATHER_DOUBLE        =  4,
    MOD_ELEMENT_SDT       =  5,
    MOD_ELEMENT_RES_RANK  =  6,
    MOD_ELEMENT_NULL      =  7,
    MOD_ELEMENT_ABSORB    =  8,
    MOD_ELEMENT_MAB       =  9,
    MOD_ELEMENT_MACC      = 10,
    MOD_ELEMENT_MEVA      = 11,
    MOD_ELEMENT_FTP_BONUS = 12,
    MOD_STAFF_BONUS       = 13,
    MOD_FORCE_DW_BONUS    = 14,
    EFFECT_BARSPELL       = 15,
    MERIT_ELEMENT_POTENCY = 16,
    MERIT_ELEMENT_MACC    = 17,
}

xi.combat.element.dataTable =
{
    [xi.element.FIRE   ] = { xi.element.WATER,   xi.day.FIRESDAY,     xi.weather.HOT_SPELL,  xi.weather.HEAT_WAVE,     xi.mod.FIRE_SDT,    xi.mod.FIRE_RES_RANK,    xi.mod.FIRE_NULL,  xi.mod.FIRE_ABSORB,  xi.mod.FIRE_MAB,    xi.mod.FIRE_MACC,    xi.mod.FIRE_MEVA,    xi.mod.FIRE_FTP_BONUS,    xi.mod.FIRE_STAFF_BONUS,    xi.mod.FORCE_FIRE_DWBONUS,      xi.effect.BARFIRE,     xi.merit.FIRE_MAGIC_POTENCY,      xi.merit.FIRE_MAGIC_ACCURACY      },
    [xi.element.ICE    ] = { xi.element.FIRE,    xi.day.ICEDAY,       xi.weather.SNOW,       xi.weather.BLIZZARDS,     xi.mod.ICE_SDT,     xi.mod.ICE_RES_RANK,     xi.mod.ICE_NULL,   xi.mod.ICE_ABSORB,   xi.mod.ICE_MAB,     xi.mod.ICE_MACC,     xi.mod.ICE_MEVA,     xi.mod.ICE_FTP_BONUS,     xi.mod.ICE_STAFF_BONUS,     xi.mod.FORCE_ICE_DWBONUS,       xi.effect.BARBLIZZARD, xi.merit.ICE_MAGIC_POTENCY,       xi.merit.ICE_MAGIC_ACCURACY       },
    [xi.element.WIND   ] = { xi.element.ICE,     xi.day.WINDSDAY,     xi.weather.WIND,       xi.weather.GALES,         xi.mod.WIND_SDT,    xi.mod.WIND_RES_RANK,    xi.mod.WIND_NULL,  xi.mod.WIND_ABSORB,  xi.mod.WIND_MAB,    xi.mod.WIND_MACC,    xi.mod.WIND_MEVA,    xi.mod.WIND_FTP_BONUS,    xi.mod.WIND_STAFF_BONUS,    xi.mod.FORCE_WIND_DWBONUS,      xi.effect.BARAERO,     xi.merit.WIND_MAGIC_POTENCY,      xi.merit.WIND_MAGIC_ACCURACY      },
    [xi.element.EARTH  ] = { xi.element.WIND,    xi.day.EARTHSDAY,    xi.weather.DUST_STORM, xi.weather.SAND_STORM,    xi.mod.EARTH_SDT,   xi.mod.EARTH_RES_RANK,   xi.mod.EARTH_NULL, xi.mod.EARTH_ABSORB, xi.mod.EARTH_MAB,   xi.mod.EARTH_MACC,   xi.mod.EARTH_MEVA,   xi.mod.EARTH_FTP_BONUS,   xi.mod.EARTH_STAFF_BONUS,   xi.mod.FORCE_EARTH_DWBONUS,     xi.effect.BARSTONE,    xi.merit.EARTH_MAGIC_POTENCY,     xi.merit.EARTH_MAGIC_ACCURACY     },
    [xi.element.THUNDER] = { xi.element.EARTH,   xi.day.LIGHTNINGDAY, xi.weather.THUNDER,    xi.weather.THUNDERSTORMS, xi.mod.THUNDER_SDT, xi.mod.THUNDER_RES_RANK, xi.mod.LTNG_NULL,  xi.mod.LTNG_ABSORB,  xi.mod.THUNDER_MAB, xi.mod.THUNDER_MACC, xi.mod.THUNDER_MEVA, xi.mod.THUNDER_FTP_BONUS, xi.mod.THUNDER_STAFF_BONUS, xi.mod.FORCE_LIGHTNING_DWBONUS, xi.effect.BARTHUNDER,  xi.merit.LIGHTNING_MAGIC_POTENCY, xi.merit.LIGHTNING_MAGIC_ACCURACY },
    [xi.element.WATER  ] = { xi.element.THUNDER, xi.day.WATERSDAY,    xi.weather.RAIN,       xi.weather.SQUALL,        xi.mod.WATER_SDT,   xi.mod.WATER_RES_RANK,   xi.mod.WATER_NULL, xi.mod.WATER_ABSORB, xi.mod.WATER_MAB,   xi.mod.WATER_MACC,   xi.mod.WATER_MEVA,   xi.mod.WATER_FTP_BONUS,   xi.mod.WATER_STAFF_BONUS,   xi.mod.FORCE_WATER_DWBONUS,     xi.effect.BARWATER,    xi.merit.WATER_MAGIC_POTENCY,     xi.merit.WATER_MAGIC_ACCURACY     },
    [xi.element.LIGHT  ] = { xi.element.DARK,    xi.day.LIGHTSDAY,    xi.weather.AURORAS,    xi.weather.STELLAR_GLARE, xi.mod.LIGHT_SDT,   xi.mod.LIGHT_RES_RANK,   xi.mod.LIGHT_NULL, xi.mod.LIGHT_ABSORB, xi.mod.LIGHT_MAB,   xi.mod.LIGHT_MACC,   xi.mod.LIGHT_MEVA,   xi.mod.LIGHT_FTP_BONUS,   xi.mod.LIGHT_STAFF_BONUS,   xi.mod.FORCE_LIGHT_DWBONUS,     0,                     0,                                0                                 },
    [xi.element.DARK   ] = { xi.element.LIGHT,   xi.day.DARKSDAY,     xi.weather.GLOOM,      xi.weather.DARKNESS,      xi.mod.DARK_SDT,    xi.mod.DARK_RES_RANK,    xi.mod.DARK_NULL,  xi.mod.DARK_ABSORB,  xi.mod.DARK_MAB,    xi.mod.DARK_MACC,    xi.mod.DARK_MEVA,    xi.mod.DARK_FTP_BONUS,    xi.mod.DARK_STAFF_BONUS,    xi.mod.FORCE_DARK_DWBONUS,      0,                     0,                                0                                 },
}

xi.combat.element.getOppositeElement = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.DARK then
        return 0
    end

    return xi.combat.element.dataTable[elementToCheck][column.ELEMENT_OPPOSED]
end

-----------------------------------
-- Day-related functions
-----------------------------------
xi.combat.element.getAssociatedDay = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.DARK then
        return -1
    end

    return xi.combat.element.dataTable[elementToCheck][column.DAY_ASSOCIATED]
end

xi.combat.element.getOppositeDay = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.DARK then
        return -1
    end

    -- Fetch opposite element.
    elementToCheck = xi.combat.element.dataTable[elementToCheck][column.ELEMENT_OPPOSED]

    return xi.combat.element.dataTable[elementToCheck][column.DAY_ASSOCIATED]
end

xi.combat.element.getDayElement = function(day)
    -- Validate fed value.
    local dayToCheck = utils.defaultIfNil(day, -1)

    for elementToCheck = xi.element.FIRE, xi.element.DARK do
        if dayToCheck == xi.combat.element.dataTable[elementToCheck][column.DAY_ASSOCIATED] then
            return elementToCheck
        end
    end

    return xi.element.NONE
end

-----------------------------------
-- Weather-related functions
-----------------------------------
xi.combat.element.getAssociatedSingleWeather = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.DARK then
        return -1
    end

    return xi.combat.element.dataTable[elementToCheck][column.WEATHER_SINGLE]
end

xi.combat.element.getOppositeSingleWeather = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.DARK then
        return -1
    end

    -- Fetch opposite element.
    elementToCheck = xi.combat.element.dataTable[elementToCheck][column.ELEMENT_OPPOSED]

    return xi.combat.element.dataTable[elementToCheck][column.WEATHER_SINGLE]
end

xi.combat.element.getAssociatedDoubleWeather = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.DARK then
        return -1
    end

    return xi.combat.element.dataTable[elementToCheck][column.WEATHER_DOUBLE]
end

xi.combat.element.getOppositeDoubleWeather = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.DARK then
        return -1
    end

    -- Fetch opposite element.
    elementToCheck = xi.combat.element.dataTable[elementToCheck][column.ELEMENT_OPPOSED]

    return xi.combat.element.dataTable[elementToCheck][column.WEATHER_DOUBLE]
end

xi.combat.element.getWeatherElement = function(weather)
    -- Validate fed value.
    local weatherToCheck = utils.defaultIfNil(weather, 0)

    for elementChecked = xi.element.FIRE, xi.element.DARK do
        local elementalSingle = xi.combat.element.dataTable[elementChecked][column.WEATHER_SINGLE]
        local elementalDouble = xi.combat.element.dataTable[elementChecked][column.WEATHER_DOUBLE]

        if weatherToCheck == elementalSingle or weatherToCheck == elementalDouble then
            return elementChecked
        end
    end

    return xi.element.NONE
end

-----------------------------------
-- Modifier-related functions
-----------------------------------
xi.combat.element.getElementalSDTModifier = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.DARK then
        return 0
    end

    return xi.combat.element.dataTable[elementToCheck][column.MOD_ELEMENT_SDT]
end

xi.combat.element.getElementalResistanceRankModifier = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.DARK then
        return 0
    end

    return xi.combat.element.dataTable[elementToCheck][column.MOD_ELEMENT_RES_RANK]
end

xi.combat.element.getElementalNullificationModifier = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.DARK then
        return 0
    end

    return xi.combat.element.dataTable[elementToCheck][column.MOD_ELEMENT_NULL]
end

xi.combat.element.getElementalAbsorptionModifier = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.DARK then
        return 0
    end

    return xi.combat.element.dataTable[elementToCheck][column.MOD_ELEMENT_ABSORB]
end

xi.combat.element.getElementalMABModifier = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.DARK then
        return 0
    end

    return xi.combat.element.dataTable[elementToCheck][column.MOD_ELEMENT_MAB]
end

xi.combat.element.getElementalMACCModifier = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.DARK then
        return 0
    end

    return xi.combat.element.dataTable[elementToCheck][column.MOD_ELEMENT_MACC]
end

xi.combat.element.getElementalMEVAModifier = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.DARK then
        return 0
    end

    return xi.combat.element.dataTable[elementToCheck][column.MOD_ELEMENT_MEVA]
end

xi.combat.element.getElementalFTPModifier = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.DARK then
        return 0
    end

    return xi.combat.element.dataTable[elementToCheck][column.MOD_ELEMENT_FTP_BONUS]
end

xi.combat.element.getElementalStaffModifier = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.DARK then
        return 0
    end

    return xi.combat.element.dataTable[elementToCheck][column.MOD_STAFF_BONUS]
end

xi.combat.element.getForcedDayOrWeatherBonusModifier = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.DARK then
        return 0
    end

    return xi.combat.element.dataTable[elementToCheck][column.MOD_FORCE_DW_BONUS]
end

-----------------------------------
-- Effect-related functions
-----------------------------------
xi.combat.element.getAssociatedBarspellEffect = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.WATER then
        return 0
    end

    return xi.combat.element.dataTable[elementToCheck][column.EFFECT_BARSPELL]
end

-----------------------------------
-- Merit-related functions
-----------------------------------
xi.combat.element.getElementalPotencyMerit = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.WATER then
        return 0
    end

    return xi.combat.element.dataTable[elementToCheck][column.MERIT_ELEMENT_POTENCY]
end

xi.combat.element.getElementalAccuracyMerit = function(element)
    -- Validate fed value.
    local elementToCheck = utils.defaultIfNil(element, 0)

    if elementToCheck < xi.element.FIRE or elementToCheck > xi.element.WATER then
        return 0
    end

    return xi.combat.element.dataTable[elementToCheck][column.MERIT_ELEMENT_MACC]
end
