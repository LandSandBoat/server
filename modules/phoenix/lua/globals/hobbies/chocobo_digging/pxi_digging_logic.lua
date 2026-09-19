-----------------------------------
-- Phoenix Chocobo Digging Logic
-- TODO: send upstream
-----------------------------------
require('modules/module_utils')
require('modules/phoenix/lua/globals/hobbies/chocobo_digging/pxi_digging_data')
-----------------------------------
local m = Module:new('pxi_digging')

local function awardExperience(player, text, itemRank)
    local currentLevel = math.floor(player:getCharSkillLevel(xi.skill.DIG) / 10)

    -- If player is already level 100, nothing else to do here.
    if currentLevel >= 100 then
        return
    end

    -- Award Experience Points
    local newLevel                = currentLevel + 1
    local currentExperiencePoints = player:getCharVar('[DIG]ExperiencePoints') + xi.chocoboDig.experiencePerItem[itemRank]
    local requiredExperience      = xi.chocoboDig.xpToLevel[newLevel]

    -- Check if its enough to level up, if not, save current experience points and return.
    if currentExperiencePoints < requiredExperience then
        player:setCharVar('[DIG]ExperiencePoints', currentExperiencePoints)

        return
    end

    -- Level up! Carry over the excess experience points, and play the wing message skill.
    player:setCharVar('[DIG]ExperiencePoints', currentExperiencePoints - requiredExperience)
    player:setSkillLevel(xi.skill.DIG, newLevel * 10)

    if newLevel % 10 == 0 then
        player:setSkillRank(xi.skill.DIG, newLevel / 10)
    end

    player:messageSpecial(text.BEASTMEN_CACHE_OFFSET + 5, newLevel, 1)
end

-- Handle item roll
local function handleItemRoll(player, zoneId, rank, currentHour, currentWeather, elementalOreActive)
    local entries = {}
    local isNight = currentHour >= 20 or currentHour < 4
    local crystal = xi.chocoboDig.crystalByWeather[currentWeather]
    local cluster = xi.chocoboDig.clusterByWeather[currentWeather]
    local ore     = xi.chocoboDig.elementalOreByDay[VanadielDayOfTheWeek()]

    for _, row in ipairs(xi.chocoboDig.zoneTable[zoneId]) do
        local weight = row[rank + 3]

        if
            weight > 0 and
            (isNight or not xi.chocoboDig.nightOnlyItems[row[1]])
        then
            table.insert(entries, { itemId = row[1], rank = row[2], weight = weight })
        end
    end

    if
        crystal and
        xi.chocoboDig.crystalWeight[rank] > 0
    then
        table.insert(entries, { itemId = crystal, rank = xi.craftRank.AMATEUR, weight = xi.chocoboDig.crystalWeight[rank] })
    end

    if
        cluster and
        xi.chocoboDig.clusterWeight[rank] > 0
    then
        table.insert(entries, { itemId = cluster, rank = xi.craftRank.AMATEUR, weight = xi.chocoboDig.clusterWeight[rank] })
    end

    if
        elementalOreActive and
        xi.chocoboDig.elementalOreWeight[rank] > 0
    then
        table.insert(entries, { itemId = ore, rank = xi.craftRank.EXPERT, weight = xi.chocoboDig.elementalOreWeight[rank] })
    end

    local loot = utils.selectFromLootGroups(player, { entries })

    return loot[1]
end

-- Make sure we have enough room for the item.
local function handleItemObtained(player, text, itemId, itemRank)
    if player:addItem(itemId) then
        player:messageSpecial(text.ITEM_OBTAINED, itemId)
    else
        player:messageSpecial(text.DIG_THROW_AWAY, itemId)
    end

    awardExperience(player, text, itemRank)
end

-- Return false exits the digging function without playing the dig animation, return true exits the digging function after playing the dig animation.
m:addOverride('xi.chocoboDig.start', function(player)
    local zoneId       = player:getZoneID()
    local text         = zones[zoneId].text
    local itemsDug     = xi.chocoboDig.fetchFatigue(player)
    local currentX     = player:getXPos()
    local currentY     = player:getYPos()
    local currentZ     = player:getZPos()
    local currentXSign = currentX < 0 and 2 or 0
    local currentYSign = currentY < 0 and 2 or 0
    local currentZSign = currentZ < 0 and 2 or 0

    -- Can't dig here.
    if not xi.chocoboDig.zoneTable[zoneId] then
        player:messageSystem(xi.msg.basic.CANT_BE_USED_IN_AREA)

        return false
    end

    local currentTime  = GetSystemTime()
    local skillRank    = player:getSkillRank(xi.skill.DIG)
    local zoneCooldown = player:getLocalVar('ZoneInTime') + utils.clamp(60 - skillRank * 5, 10, 60)
    local digCooldown  = player:getLocalVar('[DIG]LastDigTime') + utils.clamp(15 - skillRank * 5, 3, 16)
    local cooldown     = math.max(zoneCooldown, digCooldown)

    -- Not time to dig yet.
    if currentTime < cooldown then
        player:messageSystem(xi.msg.basic.WAIT_LONGER_RED, math.max(cooldown - currentTime, 0), 0)

        return false
    end

    -- If the player has already reached the daily item limit, play the digging animation and give them nothing.
    if
        xi.settings.main.DIG_FATIGUE > 0 and
        itemsDug >= xi.settings.main.DIG_FATIGUE
    then
        player:messageText(player, text.FIND_NOTHING)
        player:setLocalVar('[DIG]LastDigTime', GetSystemTime())

        return true
    end

    local lastX = player:getLocalVar('[DIG]LastXPos') * (1 - player:getLocalVar('[DIG]LastXPosSign')) / 100
    local lastY = player:getLocalVar('[DIG]LastYPos') * (1 - player:getLocalVar('[DIG]LastYPosSign')) / 100
    local lastZ = player:getLocalVar('[DIG]LastZPos') * (1 - player:getLocalVar('[DIG]LastZPosSign')) / 100

    if
        player:getLocalVar('[DIG]LastDigTime') > 0 and
        player:checkDistance(lastX, lastY, lastZ) < 4
    then
        player:messageText(player, text.FIND_NOTHING)
        player:setLocalVar('[DIG]LastDigTime', GetSystemTime())

        return true
    end

    player:setLocalVar('[DIG]LastXPos', math.floor(math.abs(currentX) * 100))
    player:setLocalVar('[DIG]LastYPos', math.floor(math.abs(currentY) * 100))
    player:setLocalVar('[DIG]LastZPos', math.floor(math.abs(currentZ) * 100))
    player:setLocalVar('[DIG]LastXPosSign', currentXSign)
    player:setLocalVar('[DIG]LastYPosSign', currentYSign)
    player:setLocalVar('[DIG]LastZPosSign', currentZSign)
    player:setLocalVar('[DIG]LastDigTime', GetSystemTime())

    -- Accuracy check
    if math.randomInt(1, 100) > xi.chocoboDig.accuracy[skillRank] then
        player:messageText(player, text.FIND_NOTHING)

        return true
    end

    local currentWeather     = player:getWeather(true)
    local currentMoonPhase   = getVanadielMoonCycle()
    local currentHour        = VanadielHour()
    local isActiveWeather    = currentWeather ~= xi.weather.NONE and currentWeather ~= xi.weather.SUNSHINE and currentWeather ~= xi.weather.CLOUDS
    local isWaxingCrescent   = currentMoonPhase == xi.moonCycle.LESSER_WAXING_CRESCENT or currentMoonPhase == xi.moonCycle.GREATER_WAXING_CRESCENT
    local elementalOreActive = xi.chocoboDig.elementalOreZones[zoneId] and isActiveWeather and isWaxingCrescent

    -- Check for regular items. Crystals, Clusters & Elemental Ores are all inserted into this layer.
    local result = handleItemRoll(player, zoneId, skillRank, currentHour, currentWeather, elementalOreActive)

    handleItemObtained(player, text, result.itemId, result.rank)

    xi.chocoboDig.updateFatigue(player, itemsDug + 1)

    -- Dig ended. Send digging animation to players.
    return true
end)
