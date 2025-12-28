-----------------------------------
-- Chocobo Digging Logic
-- http://ffxiclopedia.wikia.com/wiki/Chocobo_Digging
-- https://www.bg-wiki.com/bg/Category:Chocobo_Digging
-----------------------------------
require('scripts/globals/hobbies/chocobo_digging/data')
require('scripts/globals/roe')
require('scripts/missions/amk/helpers')
-----------------------------------
xi = xi or {}
xi.chocoboDig = xi.chocoboDig or {}

-- This contais all digging zones with the ones without loot tables defined commented out.
local diggingZoneList =
set{
    xi.zone.CARPENTERS_LANDING,
    xi.zone.BIBIKI_BAY,
    -- xi.zone.ULEGUERAND_RANGE,
    -- xi.zone.ATTOHWA_CHASM,
    -- xi.zone.LUFAISE_MEADOWS,
    -- xi.zone.MISAREAUX_COAST,
    xi.zone.WAJAOM_WOODLANDS,
    xi.zone.BHAFLAU_THICKETS,
    -- xi.zone.CAEDARVA_MIRE,
    -- xi.zone.EAST_RONFAURE_S,
    -- xi.zone.JUGNER_FOREST_S,
    -- xi.zone.VUNKERL_INLET_S,
    -- xi.zone.BATALLIA_DOWNS_S,
    -- xi.zone.NORTH_GUSTABERG_S,
    -- xi.zone.GRAUBERG_S,
    -- xi.zone.PASHHOW_MARSHLANDS_S,
    -- xi.zone.ROLANBERRY_FIELDS_S,
    -- xi.zone.WEST_SARUTABARUTA_S,
    -- xi.zone.FORT_KARUGO_NARUGO_S,
    -- xi.zone.MERIPHATAUD_MOUNTAINS_S,
    -- xi.zone.SAUROMUGUE_CHAMPAIGN_S,
    xi.zone.WEST_RONFAURE,
    xi.zone.EAST_RONFAURE,
    xi.zone.LA_THEINE_PLATEAU,
    xi.zone.VALKURM_DUNES,
    xi.zone.JUGNER_FOREST,
    xi.zone.BATALLIA_DOWNS,
    xi.zone.NORTH_GUSTABERG,
    xi.zone.SOUTH_GUSTABERG,
    xi.zone.KONSCHTAT_HIGHLANDS,
    xi.zone.PASHHOW_MARSHLANDS,
    xi.zone.ROLANBERRY_FIELDS,
    -- xi.zone.BEAUCEDINE_GLACIER,
    -- xi.zone.XARCABARD,
    -- xi.zone.CAPE_TERIGGAN,
    xi.zone.EASTERN_ALTEPA_DESERT,
    xi.zone.WEST_SARUTABARUTA,
    xi.zone.EAST_SARUTABARUTA,
    xi.zone.TAHRONGI_CANYON,
    xi.zone.BUBURIMU_PENINSULA,
    xi.zone.MERIPHATAUD_MOUNTAINS,
    xi.zone.SAUROMUGUE_CHAMPAIGN,
    xi.zone.THE_SANCTUARY_OF_ZITAH,
    xi.zone.YUHTUNGA_JUNGLE,
    xi.zone.YHOATOR_JUNGLE,
    xi.zone.WESTERN_ALTEPA_DESERT,
    -- xi.zone.QUFIM_ISLAND,
    -- xi.zone.BEHEMOTHS_DOMINION,
    -- xi.zone.VALLEY_OF_SORROWS,
    -- xi.zone.BEAUCEDINE_GLACIER_S,
    -- xi.zone.XARCABARD_S,
    -- xi.zone.YAHSE_HUNTING_GROUNDS,
    -- xi.zone.CEIZAK_BATTLEGROUNDS,
    -- xi.zone.FORET_DE_HENNETIEL,
    -- xi.zone.YORCIA_WEALD,
    -- xi.zone.MORIMAR_BASALT_FIELDS,
    -- xi.zone.MARJAMI_RAVINE,
    -- xi.zone.KAMIHR_DRIFTS,
}

local elementalOreZoneTable =
set{
    xi.zone.LA_THEINE_PLATEAU,
    xi.zone.JUGNER_FOREST,
    xi.zone.BATALLIA_DOWNS,
    xi.zone.KONSCHTAT_HIGHLANDS,
    xi.zone.PASHHOW_MARSHLANDS,
    xi.zone.ROLANBERRY_FIELDS,
    xi.zone.TAHRONGI_CANYON,
    xi.zone.MERIPHATAUD_MOUNTAINS,
    xi.zone.SAUROMUGUE_CHAMPAIGN,
}

local diggingWeatherTable =
{
    -- Single weather by elemental order.
    [xi.weather.HOT_SPELL    ] = { xi.item.FIRE_CRYSTAL      },
    [xi.weather.SNOW         ] = { xi.item.ICE_CRYSTAL       },
    [xi.weather.WIND         ] = { xi.item.WIND_CRYSTAL      },
    [xi.weather.DUST_STORM   ] = { xi.item.EARTH_CRYSTAL     },
    [xi.weather.THUNDER      ] = { xi.item.LIGHTNING_CRYSTAL },
    [xi.weather.RAIN         ] = { xi.item.WATER_CRYSTAL     },
    [xi.weather.AURORAS      ] = { xi.item.LIGHT_CRYSTAL     },
    [xi.weather.GLOOM        ] = { xi.item.DARK_CRYSTAL      },

    -- Double weather by elemental order.
    [xi.weather.HEAT_WAVE    ] = { xi.item.FIRE_CLUSTER      },
    [xi.weather.BLIZZARDS    ] = { xi.item.ICE_CLUSTER       },
    [xi.weather.GALES        ] = { xi.item.WIND_CLUSTER      },
    [xi.weather.SAND_STORM   ] = { xi.item.EARTH_CLUSTER     },
    [xi.weather.THUNDERSTORMS] = { xi.item.LIGHTNING_CLUSTER },
    [xi.weather.SQUALL       ] = { xi.item.WATER_CLUSTER     },
    [xi.weather.STELLAR_GLARE] = { xi.item.LIGHT_CLUSTER     },
    [xi.weather.DARKNESS     ] = { xi.item.DARK_CLUSTER      },
}

local diggingDayTable =
{
    [xi.day.FIRESDAY    ] = { xi.item.RED_ROCK,         xi.item.CHUNK_OF_FIRE_ORE      },
    [xi.day.ICEDAY      ] = { xi.item.TRANSLUCENT_ROCK, xi.item.CHUNK_OF_ICE_ORE       },
    [xi.day.WINDSDAY    ] = { xi.item.GREEN_ROCK,       xi.item.CHUNK_OF_WIND_ORE      },
    [xi.day.EARTHSDAY   ] = { xi.item.YELLOW_ROCK,      xi.item.CHUNK_OF_EARTH_ORE     },
    [xi.day.LIGHTNINGDAY] = { xi.item.PURPLE_ROCK,      xi.item.CHUNK_OF_LIGHTNING_ORE },
    [xi.day.WATERSDAY   ] = { xi.item.BLUE_ROCK,        xi.item.CHUNK_OF_WATER_ORE     },
    [xi.day.LIGHTSDAY   ] = { xi.item.WHITE_ROCK,       xi.item.CHUNK_OF_LIGHT_ORE     },
    [xi.day.DARKSDAY    ] = { xi.item.BLACK_ROCK,       xi.item.CHUNK_OF_DARK_ORE      },
}

-- This function handles zone and cooldown checks before digging can be attempted, before any animation is sent.
local function checkDiggingCooldowns(player)
    -- Check if current zone has digging enabled.
    local isAllowedZone = diggingZoneList[player:getZoneID()] or false

    if not isAllowedZone then
        player:messageBasic(xi.msg.basic.WAIT_LONGER, 0, 0)

        return false
    end

    -- Check digging cooldowns.
    local currentTime  = GetSystemTime()
    local skillRank    = player:getSkillRank(xi.skill.DIG)
    local zoneCooldown = player:getLocalVar('ZoneInTime') + utils.clamp(60 - skillRank * 5, 10, 60)
    local digCooldown  = player:getLocalVar('[DIG]LastDigTime') + utils.clamp(15 - skillRank * 5, 3, 16)

    if
        currentTime < zoneCooldown or
        currentTime < digCooldown
    then
        player:messageBasic(xi.msg.basic.WAIT_LONGER, 0, 0)

        return false
    end

    return true
end

local function calculateSkillUp(player)
    local skillRank = player:getSkillRank(xi.skill.DIG)
    local maxSkill  = utils.clamp((skillRank + 1) * 100, 0, 1000)
    local realSkill = player:getCharSkillLevel(xi.skill.DIG)
    local increment = 1

    -- this probably needs correcting
    local roll = math.random(1, 100)

    -- make sure our skill isn't capped
    if realSkill < maxSkill then
        -- can we skill up?
        if roll <= 15 then
            if (increment + realSkill) > maxSkill then
                increment = maxSkill - realSkill
            end

            -- skill up!
            player:setSkillLevel(xi.skill.DIG, realSkill + increment)

            -- update the skill rank
            -- Digging does not have test items, so increment rank once player hits 10.0, 20.0, .. 100.0
            if (realSkill + increment) >= (skillRank * 100) + 100 then
                player:setSkillRank(xi.skill.DIG, skillRank + 1)
            end
        end
    end
end

local function handleDiggingLayer(player, zoneId, currentLayer)
    local digTable = xi.chocoboDig.digInfo[zoneId][currentLayer]

    -- Early return.
    if
        not digTable or
        #digTable <= 0
    then
        return 0
    end

    local dTableItemIds = {}
    local rewardItem    = 0

    -- Determine moon multiplier.
    local moon           = VanadielMoonPhase()
    local rollMultiplier = 1.5 - math.abs(moon - 50) / 50 -- The lower the multiplier, the better for the player.
    -- Moon phase 0 and 100 -> multiplier = 0.5
    -- Moon phase 50        -> multiplier = 1.5
    -- Moon phase 25 and 75 -> multiplier = 1

    -- Add valid items to dynamic table
    local playerRank = player:getSkillRank(xi.skill.DIG)
    local randomRoll = 1000
    local digRate    = 0

    for i = 1, #digTable do
        randomRoll = utils.clamp(math.floor(math.random(1, 1000) * rollMultiplier), 1, 1000)
        digRate    = digTable[i][2]

        -- Denim Pants +1 and Black Chocobo Suit
        if player:getMod(xi.mod.DIG_RARE_ABILITY) > 0 then
            if digRate >= 100 then
                digRate = math.floor(digRate / 2)
            else
                digRate = digRate * 2
            end
        end

        if
            randomRoll <= digRate and    -- Roll check
            playerRank >= digTable[i][3] -- Rank check
        then
            table.insert(dTableItemIds, #dTableItemIds + 1, digTable[i][1]) -- Insert item ID to table.
        end
    end

    -- Add weather crystals and ores to regular layer only.
    if currentLayer == xi.chocoboDig.layer.REGULAR then
        local weather            = player:getWeather()
        local currentDay         = VanadielDayOfTheWeek()
        local isElementalOreZone = elementalOreZoneTable[player:getZoneID()] or false

        -- Crystals and Clusters.
        randomRoll = utils.clamp(math.floor(math.random(1, 1000) * rollMultiplier), 1, 1000)
        if
            diggingWeatherTable[weather] and
            randomRoll <= 100
        then
            table.insert(dTableItemIds, #dTableItemIds + 1, diggingWeatherTable[weather][1]) -- Insert item ID to table.
        end

        -- Geodes / Colored Rocks.
        randomRoll = utils.clamp(math.floor(math.random(1, 1000) * rollMultiplier), 1, 1000)
        if
            playerRank >= xi.craftRank.NOVICE and
            randomRoll <= 50
        then
            table.insert(dTableItemIds, #dTableItemIds + 1, diggingDayTable[currentDay][1]) -- Insert item ID to table.
        end

        -- Elemenal Ores.
        randomRoll = utils.clamp(math.floor(math.random(1, 1000) * rollMultiplier), 1, 1000)
        if
            isElementalOreZone and                                              -- Zone can drop ore.
            playerRank >= xi.craftRank.CRAFTSMAN and                            -- Digging level must be 60+
            xi.data.element.getWeatherElement(weather) ~= xi.element.NONE and -- Weather must be elemental.
            moon >= 7 and moon <= 21 and                                        -- Moon must be between those values.
            randomRoll <= 100
        then
            table.insert(dTableItemIds, #dTableItemIds + 1, diggingDayTable[currentDay][2]) -- Insert item ID to table.
        end
    end

    -- Choose a random entry from the valid item table.
    if #dTableItemIds > 0 then
        local chosenItem = math.random(1, #dTableItemIds)

        rewardItem = dTableItemIds[chosenItem]
    end

    return rewardItem
end

local function handleItemObtained(player, text, itemId)
    if itemId > 0 then
        -- Make sure we have enough room for the item.
        if player:addItem(itemId) then
            player:messageSpecial(text.ITEM_OBTAINED, itemId)
        else
            player:messageSpecial(text.DIG_THROW_AWAY, itemId)
        end
    end
end

local function handleFatigue(player, text, todayDigCount)
    if math.random(1, 100) <= player:getMod(xi.mod.DIG_BYPASS_FATIGUE) then
        player:messageSpecial(text.FOUND_ITEM_WITH_EASE)
    else
        xi.chocoboDig.updateFatigue(player, todayDigCount + 1)
    end
end

xi.chocoboDig.fetchFatigue = function(player)
    return player:getCharVar('[DIG]DigCount')
end

xi.chocoboDig.updateFatigue = function(player, newValue)
    player:setVar('[DIG]DigCount', newValue, NextJstDay())
end

xi.chocoboDig.start = function(player)
    local zoneId        = player:getZoneID()
    local text          = zones[zoneId].text
    local todayDigCount = xi.chocoboDig.fetchFatigue(player)
    local currentX      = player:getXPos()
    local currentZ      = player:getZPos()
    local currentXSign  = 0
    local currentZSign  = 0

    if currentX < 0 then
        currentXSign = 2
    end

    if currentZ < 0 then
        currentZSign = 2
    end

    -----------------------------------
    -- Early returns and exceptions
    -----------------------------------

    -- Handle valid zones and digging cooldowns.
    if not checkDiggingCooldowns(player) then
        return false -- This means we do not send a digging animation.
    end

    -- Handle AMK mission 7 (index 6) exception.
    if
        xi.settings.main.ENABLE_AMK == 1 and
        player:getCurrentMission(xi.mission.log_id.AMK) == xi.mission.id.amk.SHOCK_ARRANT_ABUSE_OF_AUTHORITY and
        xi.amk.helpers.chocoboDig(player, zoneId, text)
    then
        -- Note: The helper function handles the messages.
        player:setLocalVar('[DIG]LastDigTime', GetSystemTime())

        return true
    end

    -- Handle auto-fail from fatigue.
    if
        xi.settings.main.DIG_FATIGUE > 0 and
        xi.settings.main.DIG_FATIGUE <= todayDigCount
    then
        player:messageText(player, text.FIND_NOTHING)
        player:setLocalVar('[DIG]LastDigTime', GetSystemTime())

        return true
    end

    -- Handle auto-fail from position.
    local lastX = player:getLocalVar('[DIG]LastXPos') * (1 - player:getLocalVar('[DIG]LastXPosSign'))
    local lastZ = player:getLocalVar('[DIG]LastZPos') * (1 - player:getLocalVar('[DIG]LastZPosSign'))

    if
        currentX >= lastX - 5 and currentX <= lastX + 5 and -- Check current X axis to see if you are too close to your last X.
        currentZ >= lastZ - 5 and currentZ <= lastZ + 5     -- Check current Z axis to see if you are too close to your last Z.
    then
        player:messageText(player, text.FIND_NOTHING)
        player:setLocalVar('[DIG]LastDigTime', GetSystemTime())

        return true
    end

    -----------------------------------
    -- Perform digging
    -----------------------------------

    -- Set player variables, no matter the result.
    player:setLocalVar('[DIG]LastXPos', math.abs(currentX))
    player:setLocalVar('[DIG]LastZPos', math.abs(currentZ))
    player:setLocalVar('[DIG]LastXPosSign', currentXSign)
    player:setLocalVar('[DIG]LastZPosSign', currentZSign)
    player:setLocalVar('[DIG]LastDigTime', GetSystemTime())

    -- Handle trasure layer. Incompatible with the other 3 layers. "Early" return.
    local trasureItemId = handleDiggingLayer(player, zoneId, xi.chocoboDig.layer.TREASURE)

    if trasureItemId > 0 then
        handleItemObtained(player, text, trasureItemId)
        handleFatigue(player, text, todayDigCount)
        calculateSkillUp(player)
        player:triggerRoeEvent(xi.roeTrigger.CHOCOBO_DIG_SUCCESS)

        return true
    end

    -- Handle regional currency here. Incompatible with the other 3 layers. "Early" return.
    -- TODO: Implement logic and message to zones.

    -- Handle regular layer. This also contains, elemental ores, weather crystals and day-element geodes.
    local regularItemId = handleDiggingLayer(player, zoneId, xi.chocoboDig.layer.REGULAR)

    handleItemObtained(player, text, regularItemId)

    -- Handle Burrow layer. Requires Burrow skill.
    local burrowItemId = 0

    if xi.settings.main.DIG_GRANT_BURROW > 0 then -- TODO: Implement Chocobo Raising and Burrow chocobo skill. Good luck
        burrowItemId = handleDiggingLayer(player, zoneId, xi.chocoboDig.layer.BURROW)

        handleItemObtained(player, text, burrowItemId)
    end

    -- Handle Bore layer. Requires Bore skill.
    local boreItemId = 0

    if xi.settings.main.DIG_GRANT_BORE > 0 then -- TODO: Implement Chocobo Raising and Bore chocobo skill. Good luck
        boreItemId = handleDiggingLayer(player, zoneId, xi.chocoboDig.layer.BORE)

        handleItemObtained(player, text, boreItemId)
    end

    -- Handle skill-up
    calculateSkillUp(player)

    -- Handle no item OR record of eminence.
    if
        regularItemId == 0 and
        burrowItemId == 0 and
        boreItemId == 0
    then
        player:messageText(player, text.FIND_NOTHING)
    else
        handleFatigue(player, text, todayDigCount)
        player:triggerRoeEvent(xi.roeTrigger.CHOCOBO_DIG_SUCCESS)
    end

    -- Dig ended. Send digging animation to players.
    return true
end
