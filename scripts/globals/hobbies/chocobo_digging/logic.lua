-----------------------------------
-- Chocobo Digging Logic
-- http://ffxiclopedia.wikia.com/wiki/Chocobo_Digging
-- https://www.bg-wiki.com/bg/Category:Chocobo_Digging
-----------------------------------
require('scripts/globals/hobbies/chocobo_digging/data')
require('scripts/globals/hobbies/chocobo_raising/whistle')
require('scripts/globals/roe')
require('scripts/missions/amk/helpers')
-----------------------------------
xi = xi or {}
xi.chocoboDig = xi.chocoboDig or {}

-----------------------------------
-- Tables
-----------------------------------
-- Registered chocobo effects.
xi.chocoboDig.personal =
{
    endurancePerExtraDig = 2,
    maxExtraDigs         = 100,
    rareRateBelow        = 100,
    receptivityPerRank   = 0.05,
    keepGreensPerRank    = 5,
}

-- TODO: Whether the weather preference changes finds, and by how much.
-- TODO: STR adds conquest points to beastman supplies once that layer exists.
-- TODO: [S], Adoulin, Uleguerand, Attohwa, Lufaise and Misareaux need a personal chocobo; enable them once their regular tables exist.

-- This contains all digging zones with the ones without loot tables defined commented out.
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

-----------------------------------
-- Specs
-----------------------------------
---@class ChocoboDigChocobo : ChocoboRegisteredStats
---@field abilities xi.chocoboRaising.ability[]

-----------------------------------
-- Helpers
-----------------------------------
local function hasAbility(chocobo, ability)
    return chocobo ~= nil and (chocobo.abilities[1] == ability or chocobo.abilities[2] == ability)
end

local function statRank(chocobo, stat)
    if not chocobo then
        return 0
    end

    return xi.chocoboRaising.numberToRank(chocobo[stat])
end

-----------------------------------
-- Private Functions
-----------------------------------
-- A rental has no registered stats or abilities.
---@param player CBaseEntity
---@return ChocoboDigChocobo?
local function chocoboFor(player)
    local mount = player:getStatusEffect(xi.effect.MOUNTED)
    if
        not mount or
        mount:getPower() ~= xi.mount.CHOCOBO or
        bit.band(mount:getSubPower(), xi.chocoboRaising.personalChocoboFlag) == 0 or
        not player:getFieldChocobo()
    then
        return nil
    end

    local stats = xi.chocoboRaising.whistle.registeredStats(player)
    stats.abilities = xi.chocoboRaising.whistle.registeredAbilities(player)

    return stats
end

-- This function handles zone and cooldown checks before digging can be attempted, before any animation is sent.
local function checkDiggingCooldowns(player)
    -- Check if current zone has digging enabled.
    local isAllowedZone = diggingZoneList[player:getZoneID()] or false

    if not isAllowedZone then
        player:messageSystem(xi.msg.basic.WAIT_LONGER_RED)

        return false
    end

    -- Check digging cooldowns.
    local currentTime  = GetSystemTime()
    local skillRank    = player:getSkillRank(xi.skill.DIG)
    local zoneCooldown = player:getLocalVar('ZoneInTime') + utils.clamp(60 - skillRank * 5, 10, 60)
    local digCooldown  = player:getLocalVar('[DIG]LastDigTime') + utils.clamp(15 - skillRank * 5, 3, 16)
    local cooldown     = math.max(zoneCooldown, digCooldown)

    if currentTime < cooldown then
        player:messageSystem(xi.msg.basic.WAIT_LONGER_RED, math.max(cooldown - currentTime, 0), 0) -- Yes, SE sends the cooldown in this packet as of 2026.

        return false
    end

    return true
end

local function calculateSkillUp(player, text)
    local skillRank = player:getSkillRank(xi.skill.DIG)
    local maxSkill  = utils.clamp((skillRank + 1) * 100, 0, 1000)
    local realSkill = player:getCharSkillLevel(xi.skill.DIG)
    local increment = 1

    -- this probably needs correcting
    -- it seems skilling up gets harder as your rank goes up
    local roll = math.randomInt(1, 100)

    -- make sure our skill isn't capped
    if realSkill < maxSkill then
        -- can we skill up?
        if roll <= 15 then
            if (increment + realSkill) > maxSkill then
                increment = maxSkill - realSkill
            end

            -- skill up!
            player:setSkillLevel(xi.skill.DIG, realSkill + increment)

            local newSkill = realSkill + increment
            -- update the skill rank
            -- Digging does not have test items, so increment rank once player hits 10.0, 20.0, .. 100.0
            if newSkill >= (skillRank * 100) + 100 then
                player:setSkillRank(xi.skill.DIG, skillRank + 1)
            end

            if newSkill % 10 == 0 then
                if text and text.BEASTMEN_CACHE_OFFSET then
                    -- Conquest Cache + 5 = "Your wing skill improved to X"
                    player:messageSpecial(text.BEASTMEN_CACHE_OFFSET + 5, math.floor(newSkill / 10), 1) -- TODO: what is the "1" in the params?
                else
                    print(string.format('warning: Zone %s (%d) is missing ID.text.BEASTMEN_CACHE_OFFSET', player:getZoneName(), player:getZoneID()))
                end
            end
        end
    end
end

local function handleDiggingLayer(player, zoneId, currentLayer, chocobo)
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
    -- Moon phase 0 and 100: multiplier = 0.5
    -- Moon phase 50:        multiplier = 1.5
    -- Moon phase 25 and 75: multiplier = 1
    local moon           = VanadielMoonPhase()
    local rollMultiplier = 1.5 - math.abs(moon - 50) / 50 -- The lower the multiplier, the better for the player.

    -- Add valid items to dynamic table
    local playerRank     = player:getSkillRank(xi.skill.DIG)
    local randomRoll     = 1000
    local digRate        = 0
    local rareMultiplier = 1 + statRank(chocobo, 'receptivity') * xi.chocoboDig.personal.receptivityPerRank

    for i = 1, #digTable do
        randomRoll = utils.clamp(math.floor(math.randomInt(1, 1000) * rollMultiplier), 1, 1000)
        digRate    = digTable[i][2]

        -- Denim Pants +1 and Black Chocobo Suit
        if player:getMod(xi.mod.DIG_RARE_ABILITY) > 0 then
            if digRate >= 100 then
                digRate = math.floor(digRate / 2)
            else
                digRate = digRate * 2
            end
        end

        if digTable[i][2] < xi.chocoboDig.personal.rareRateBelow then
            digRate = math.floor(digRate * rareMultiplier)
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
        local weather            = player:getWeather(true)
        local currentDay         = VanadielDayOfTheWeek()
        local isElementalOreZone = elementalOreZoneTable[player:getZoneID()] or false

        -- Crystals and Clusters.
        randomRoll = utils.clamp(math.floor(math.randomInt(1, 1000) * rollMultiplier), 1, 1000)
        if
            diggingWeatherTable[weather] and
            randomRoll <= 100
        then
            table.insert(dTableItemIds, #dTableItemIds + 1, diggingWeatherTable[weather][1]) -- Insert item ID to table.
        end

        -- Geodes / Colored Rocks.
        randomRoll = utils.clamp(math.floor(math.randomInt(1, 1000) * rollMultiplier), 1, 1000)
        if
            playerRank >= xi.craftRank.NOVICE and
            randomRoll <= 50
        then
            table.insert(dTableItemIds, #dTableItemIds + 1, diggingDayTable[currentDay][1]) -- Insert item ID to table.
        end

        -- Elemental Ores.
        randomRoll = utils.clamp(math.floor(math.randomInt(1, 1000) * rollMultiplier), 1, 1000)
        if
            isElementalOreZone and                                              -- Zone can drop ore.
            playerRank >= xi.craftRank.CRAFTSMAN and                            -- Digging level must be 60+
            xi.data.element.getWeatherElement(weather) ~= xi.element.NONE and   -- Weather must be elemental.
            moon >= 7 and moon <= 21 and                                        -- Moon must be between those values.
            randomRoll <= 100
        then
            table.insert(dTableItemIds, #dTableItemIds + 1, diggingDayTable[currentDay][2]) -- Insert item ID to table.
        end
    end

    -- Choose a random entry from the valid item table.
    if #dTableItemIds > 0 then
        local chosenItem = math.randomInt(1, #dTableItemIds)

        rewardItem = dTableItemIds[chosenItem]
    end

    return rewardItem
end

local function handleItemObtained(player, text, itemId)
    if itemId > 0 then
        calculateSkillUp(player, text)

        -- Make sure we have enough room for the item.
        if player:addItem(itemId) then
            player:messageSpecial(text.ITEM_OBTAINED, itemId)
        else
            player:messageSpecial(text.DIG_THROW_AWAY, itemId)
        end
    end
end

-- Guess: the knowledge message is one more skill-up roll.
local function rollExtraSkillUp(player, text)
    if
        player:getCharSkillLevel(xi.skill.DIG) < 1000 and
        math.randomInt(1, 100) <= player:getMod(xi.mod.DIG_SKILL_UP)
    then
        -- Your chocobo appears to have gained valuable knowledge from this discovery.
        player:messageSpecial(text.FOUND_ITEM_WITH_EASE + 1)
        calculateSkillUp(player, text)
    end
end

local function handleFatigue(player, text, todayDigCount)
    if math.randomInt(1, 100) <= player:getMod(xi.mod.DIG_BYPASS_FATIGUE) then
        player:messageSpecial(text.FOUND_ITEM_WITH_EASE)
    else
        xi.chocoboDig.updateFatigue(player, todayDigCount + 1)
    end
end

-----------------------------------
-- Global Functions
-----------------------------------
---@param player CBaseEntity
---@return integer
xi.chocoboDig.fetchFatigue = function(player)
    return player:getCharVar('[DIG]DigCount')
end

---@param player CBaseEntity
---@param newValue integer
---@return nil
xi.chocoboDig.updateFatigue = function(player, newValue)
    player:setVar('[DIG]DigCount', newValue, NextJstDay())
end

-- Returns whether the dig went ahead, then whether the chocobo left the Gysahl Greens.
---@param player CBaseEntity
---@return boolean
---@return boolean?
xi.chocoboDig.start = function(player)
    local zoneId        = player:getZoneID()
    local text          = zones[zoneId].text
    local todayDigCount = xi.chocoboDig.fetchFatigue(player)
    local currentX      = player:getXPos()
    local currentY      = player:getYPos()
    local currentZ      = player:getZPos()
    local currentXSign  = currentX < 0 and 2 or 0
    local currentYSign  = currentY < 0 and 2 or 0
    local currentZSign  = currentZ < 0 and 2 or 0

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

    local chocobo  = chocoboFor(player)
    local digLimit = xi.settings.main.DIG_FATIGUE
    if chocobo then
        local personal = xi.chocoboDig.personal
        digLimit = digLimit + math.min(math.floor(chocobo.endurance / personal.endurancePerExtraDig), personal.maxExtraDigs)
    end

    -- Handle auto-fail from fatigue.
    if
        xi.settings.main.DIG_FATIGUE > 0 and
        digLimit <= todayDigCount
    then
        player:messageText(player, text.FIND_NOTHING)
        player:setLocalVar('[DIG]LastDigTime', GetSystemTime())

        return true
    end

    -- Handle auto-fail from position.
    local lastX = player:getLocalVar('[DIG]LastXPos') * (1 - player:getLocalVar('[DIG]LastXPosSign'))
    local lastY = player:getLocalVar('[DIG]LastYPos') * (1 - player:getLocalVar('[DIG]LastYPosSign'))
    local lastZ = player:getLocalVar('[DIG]LastZPos') * (1 - player:getLocalVar('[DIG]LastZPosSign'))

    if player:checkDistance(lastX, lastY, lastZ) < 5 then
        player:messageText(player, text.FIND_NOTHING)
        player:setLocalVar('[DIG]LastDigTime', GetSystemTime())

        return true
    end

    -----------------------------------
    -- Perform digging
    -----------------------------------

    -- Set player variables, no matter the result.
    player:setLocalVar('[DIG]LastXPos', math.abs(currentX))
    player:setLocalVar('[DIG]LastYPos', math.abs(currentY))
    player:setLocalVar('[DIG]LastZPos', math.abs(currentZ))
    player:setLocalVar('[DIG]LastXPosSign', currentXSign)
    player:setLocalVar('[DIG]LastYPosSign', currentYSign)
    player:setLocalVar('[DIG]LastZPosSign', currentZSign)
    player:setLocalVar('[DIG]LastDigTime', GetSystemTime())

    -- Rank E keeps none; each rank above it adds keepGreensPerRank percent.
    local keepGreens = math.randomInt(1, 100) <= (statRank(chocobo, 'discernment') - 1) * xi.chocoboDig.personal.keepGreensPerRank
    if keepGreens and text.BEASTMEN_CACHE_OFFSET then
        -- Your chocobo refuses to partake of the <item>.
        player:messageSpecial(text.BEASTMEN_CACHE_OFFSET + 4, xi.item.BUNCH_OF_GYSAHL_GREENS)
    end

    -- Handle treasure layer. Incompatible with the other 3 layers. "Early" return.
    local trasureItemId = handleDiggingLayer(player, zoneId, xi.chocoboDig.layer.TREASURE, chocobo)

    if trasureItemId > 0 then
        handleItemObtained(player, text, trasureItemId)
        rollExtraSkillUp(player, text)
        handleFatigue(player, text, todayDigCount)
        player:triggerRoeEvent(xi.roeTrigger.CHOCOBO_DIG_SUCCESS)

        return true, keepGreens
    end

    -- Handle regional currency here. Incompatible with the other 3 layers. "Early" return.
    -- TODO: Implement logic and message to zones.

    -- Handle regular layer. This also contains, elemental ores, weather crystals and day-element geodes.
    local regularItemId = handleDiggingLayer(player, zoneId, xi.chocoboDig.layer.REGULAR, chocobo)

    handleItemObtained(player, text, regularItemId)

    local burrowItemId = 0

    if hasAbility(chocobo, xi.chocoboRaising.ability.BURROW) then
        burrowItemId = handleDiggingLayer(player, zoneId, xi.chocoboDig.layer.BURROW, chocobo)

        handleItemObtained(player, text, burrowItemId)
    end

    local boreItemId = 0

    if hasAbility(chocobo, xi.chocoboRaising.ability.BORE) then
        boreItemId = handleDiggingLayer(player, zoneId, xi.chocoboDig.layer.BORE, chocobo)

        handleItemObtained(player, text, boreItemId)
    end

    if
        regularItemId == 0 and
        burrowItemId == 0 and
        boreItemId == 0 and
        hasAbility(chocobo, xi.chocoboRaising.ability.TREASURE_FINDER)
    then
        regularItemId = handleDiggingLayer(player, zoneId, xi.chocoboDig.layer.REGULAR, chocobo)

        handleItemObtained(player, text, regularItemId)
    end

    -- Handle no item OR record of eminence.
    if
        regularItemId == 0 and
        burrowItemId == 0 and
        boreItemId == 0
    then
        player:messageText(player, text.FIND_NOTHING)
    else
        rollExtraSkillUp(player, text)
        handleFatigue(player, text, todayDigCount)
        player:triggerRoeEvent(xi.roeTrigger.CHOCOBO_DIG_SUCCESS)
    end

    -- Dig ended. Send digging animation to players.
    return true, keepGreens
end
