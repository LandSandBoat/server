-----------------------------------
-- Abyssea Sturdy Pyxis Spawn
-- Spawn conditions type and size.
-----------------------------------
require("scripts/globals/zone")
require("scripts/globals/abyssea")
require("scripts/globals/abyssea/sturdypyxis/chest")
-----------------------------------
xi = xi or {}
xi.pyxis = xi.pyxis or {}

xi.pyxis.spawn = {}

xi.pyxis.spawn.chestLightValues =
{
    [1] =
    {
        [xi.abyssea.lightType.PEARL] = 5,
        [xi.abyssea.lightType.RUBY ] = 8,
        [xi.abyssea.lightType.AZURE] = 8,
        [xi.abyssea.lightType.AMBER] = 8
    },

    [2] =
    {
        [xi.abyssea.lightType.PEARL] = 10,
        [xi.abyssea.lightType.RUBY ] = 16,
        [xi.abyssea.lightType.AZURE] = 16,
        [xi.abyssea.lightType.AMBER] = 16
    },

    [3] =
    {
        [xi.abyssea.lightType.PEARL]   = 15,
        [xi.abyssea.lightType.RUBY ]   = 32,
        [xi.abyssea.lightType.AZURE]   = 32,
        [xi.abyssea.lightType.AMBER]   = 32,
        [xi.abyssea.lightType.GOLDEN]  = 5,
        [xi.abyssea.lightType.SILVERY] = 5,
        [xi.abyssea.lightType.EBON]    = 1,
    },

    [4] =
    {
        [xi.abyssea.lightType.RUBY ]   = 64,
        [xi.abyssea.lightType.AZURE]   = 64,
        [xi.abyssea.lightType.GOLDEN]  = 10,
        [xi.abyssea.lightType.SILVERY] = 10,
        [xi.abyssea.lightType.EBON]    = 2,
    },

    [5] =
    {
        [xi.abyssea.lightType.GOLDEN]  = 15,
        [xi.abyssea.lightType.SILVERY] = 15,
        [xi.abyssea.lightType.EBON]    = 3,
    }
}

xi.pyxis.spawn.goldCofferSize =
{
    BIG_CHEST    = 1159,
    LITTLE_CHEST = 1155,
}

xi.pyxis.spawn.chestMessageByChestType =
{
    [xi.pyxis.chestType.BLUE] =
    {
        [xi.pyxis.chestDropType.TEMPORARY_ITEM] =
        {
            [1] = { messageId = 42, maxItem = 3 },
        },

        [xi.pyxis.chestDropType.RESTORE] =
        {
            [1] = { messageId =  1 },
            [2] = { messageId =  4 },
            [3] = { messageId =  7 },
            [4] = { messageId = 10 },
            [5] = { messageId = 13 },
        },

        [xi.pyxis.chestDropType.CRUOR] =
        {
            [1] = { messageId =  2 },
            [2] = { messageId =  5 },
            [3] = { messageId =  8 },
            [4] = { messageId = 11 },
            [5] = { messageId = 15 },
        },

        [xi.pyxis.chestDropType.TIME] =
        {
            [1] = { messageId = 17 },
        },

        [xi.pyxis.chestDropType.EXP] =
        {
            [1] = { messageId =  3 },
            [2] = { messageId =  6 },
            [3] = { messageId =  9 },
            [4] = { messageId = 12 },
            [5] = { messageId = 16 },
        },

        [xi.pyxis.chestDropType.NUMEROUS_TEMPITEMS] =
        {
            [1] = { messageId = 14 }
        },
    },

    [xi.pyxis.chestType.GOLD] =
    {
        [xi.pyxis.spawn.goldCofferSize.BIG_CHEST] =
        {
            [xi.pyxis.chestDropType.TEMPORARY_ITEM]  = { message = 42, maxItem = 3 },
            [xi.pyxis.chestDropType.ITEM          ]  = { message = 43, maxItem = 4 },
            [xi.pyxis.chestDropType.POPITEM       ]  = { message = 43, maxItem = 2 },
            [xi.pyxis.chestDropType.AUGMENTED_ITEM]  = { message = 44, maxItem = 2 },
            [xi.pyxis.chestDropType.KEY_ITEM      ]  = { message = 45, maxItem = 1 },
        },

        [xi.pyxis.spawn.goldCofferSize.LITTLE_CHEST] =
        {
            [xi.pyxis.chestDropType.TEMPORARY_ITEM]  = { message = 42, maxItem = 3 },
            [xi.pyxis.chestDropType.ITEM          ]  = { message = 43, maxItem = 4 },
            [xi.pyxis.chestDropType.POPITEM       ]  = { message = 43, maxItem = 2 },
            [xi.pyxis.chestDropType.AUGMENTED_ITEM]  = { message = 44, maxItem = 2 },
        }
    }
}

xi.pyxis.spawn.lightsMessage =
{
    [xi.abyssea.lightType.PEARL  ] = { 18, 18, 22, 22, 26 },
    [xi.abyssea.lightType.GOLDEN ] = { 30, 30, 36, 36, 39 },
    [xi.abyssea.lightType.SILVERY] = { 31, 31, 37, 37, 40 },
    [xi.abyssea.lightType.EBON   ] = { 32, 32, 38, 38, 41 },
    [xi.abyssea.lightType.AZURE  ] = { 19, 19, 23, 27, 33 },
    [xi.abyssea.lightType.RUBY   ] = { 20, 20, 24, 28, 34 },
    [xi.abyssea.lightType.AMBER  ] = { 21, 21, 25, 29, 35 },
}

---------------------------------------------------------------------------------------------
-- Desc: Check for time elapsed since last spawned
-- NOTE: will NOT allow a spawn if time since last spanwed is under 5 mins.
---------------------------------------------------------------------------------------------
local function timeElapsedCheck(npc, player)
    local spawnTime = os.time() + 180000 -- default time in case no var set.

    if npc:getLocalVar("[pyxis]SPAWNTIME") > 0 then
        spawnTime = npc:getLocalVar("[pyxis]SPAWNTIME")
    end

    return os.time() - spawnTime <= 0
end

---------------------------------------------------------------------------------------------
-- Desc: This method allow you to get next chest available
---------------------------------------------------------------------------------------------
local function GetPyxisID(player)
    local zone        = player:getZone()
    local pyxii       = zone:queryEntitiesByName('Sturdy_Pyxis') -- Get the ID of the first entry and use that as our base ID to offset against
    local baseChestId = pyxii[1]:getID()
    local chestId     = 0

    -- Get next chest ID available
    for npcId = baseChestId, baseChestId + 79 do
        local npc = GetNPCByID(npcId)
        if npc and timeElapsedCheck(npc, player) then
            if npc:getStatus() == xi.status.DISAPPEAR then
                chestId = npcId
                break
            end
        end
    end

    -- if chest not found set status disappear on chest with status CUTSCENE_ONLY
    if chestId == 0 then
        for i = baseChestId, baseChestId + 79 do
            local npc = GetNPCByID(i)
            if npc:getStatus() == xi.status.CUTSCENE_ONLY then
                npc:setStatus(xi.status.DISAPPEAR)
            elseif npc:getStatus() == xi.status.DISAPPEAR then
                npc:setLocalVar("[pyxis]SPAWNTIME", (os.time() + 180000))
            end
        end
    end

    if GetNPCByID(chestId) == nil then
        return 0
    end

    return chestId
end

---------------------------------------------------------------------------------------------
-- Desc: This method allow you to check if you can spawn pyxies with lights
---------------------------------------------------------------------------------------------
local function CanSpawnPyxis(player)
    local lightValues = xi.abyssea.getLightsTable(player)
    local dropchance = math.random(1 + lightValues[xi.abyssea.lightType.PEARL], 500)
    return dropchance >= 250
end

---------------------------------------------------------------------------------------------
-- Desc: This method allow you to determine chest type
---------------------------------------------------------------------------------------------
local function determineChestType(lightValues)
    local redLight = lightValues[xi.abyssea.lightType.RUBY]
    local blueLight = lightValues[xi.abyssea.lightType.AZURE]
    local goldLight = lightValues[xi.abyssea.lightType.AMBER]

    local blueChance = math.max(math.random(blueLight), 255 * 0.25) -- min 25% can adjust
    local redChance = math.random(redLight)
    local goldChance = math.random(goldLight)

    if redChance > blueChance and redChance > goldChance then
        return xi.pyxis.chestType.RED
    elseif goldChance > blueChance and goldChance > redChance then
        return xi.pyxis.chestType.GOLD
    else
        return xi.pyxis.chestType.BLUE
    end
end

local function GetBlueChestInfos(player, lightValues)
    -- Lowers the required amount of correct guesses for blue pyxides by 1
    local abyssitesAmountCorrect =
    {
        xi.ki.EMERALD_ABYSSITE_OF_ACUMEN,
        xi.ki.CRIMSON_ABYSSITE_OF_ACUMEN,
        xi.ki.IVORY_ABYSSITE_OF_ACUMEN
    }

    -- The bearer will experience greater fortune with blue pyxides in Abyssea.
    local abyssitesExperiences =
    {
        xi.ki.IVORY_ABYSSITE_OF_KISMET,
        xi.ki.SCARLET_ABYSSITE_OF_KISMET,
        xi.ki.VERMILLION_ABYSSITE_OF_KISMET
    }

    local dataAzureTiers =
    {
        [1] = { min =   0, max = 63  },
        [2] = { min =  64, max = 127 },
        [3] = { min = 128, max = 191 },
        [4] = { min = 192, max = 223 },
        [5] = { min = 224, max = 255 }
    }

    local blueabyssitebonus = 0
    local playerAzureLight = lightValues[xi.abyssea.lightType.AZURE]
    local chestModel = 965
    local chestSize = 3
    local chestType = xi.pyxis.chestType.BLUE
    local amountCorrectAnswerNeeded = math.random(2, 6)
    local chestTier = 1

    for i, abyssite in pairs(abyssitesAmountCorrect) do
        if player:hasKeyItem(abyssite) and amountCorrectAnswerNeeded > 1 then
            amountCorrectAnswerNeeded = amountCorrectAnswerNeeded - 1
        end
    end

    for i, abyssite in pairs(abyssitesExperiences) do
        if player:hasKeyItem(abyssite) then
            blueabyssitebonus = blueabyssitebonus + 1
        end
    end

    for tier, azureTier in pairs(dataAzureTiers) do
        if playerAzureLight >= azureTier.min and playerAzureLight <= azureTier.max then
            if math.random(1, 100) < 5 then
                chestTier = math.max(tier, math.random(tier, 5))
            else
                chestTier = tier
            end
        end
    end

    chestTier = math.min(chestTier + blueabyssitebonus, 5)

    local tmpTable = {}

    for key, value in pairs(xi.pyxis.spawn.chestMessageByChestType[chestType]) do
        if key == xi.pyxis.chestDropType.TIME and chestTier < 4 then
            goto skip_to_next
        end

        table.insert(tmpTable, key)

        ::skip_to_next::
    end

    local dropType = tmpTable[math.random(1, #tmpTable)]

    local drop = xi.pyxis.spawn.chestMessageByChestType[chestType][dropType][1]

    if #xi.pyxis.spawn.chestMessageByChestType[chestType][dropType] > 1 then
        drop = xi.pyxis.spawn.chestMessageByChestType[chestType][dropType][chestTier]
    end

    local message = drop.messageId

    local nbItem = 0
    if drop.maxItem then
        nbItem = math.random(1, drop.maxItem)
    end

    local restore = 0

    if chestTier <= 3 then
        restore = math.random(1, 3)
    else
        restore = chestTier
    end

    return chestSize, chestType, chestModel, chestTier, amountCorrectAnswerNeeded, dropType, message, restore, nbItem
end

local function GetRedChestInfos(player, lightValues)
    -- The bearer will experience greater fortune with blue pyxides in Abyssea.
    local abyssitesExperiences =
    {
        xi.ki.AZURE_ABYSSITE_OF_PROSPERITY,
        xi.ki.JADE_ABYSSITE_OF_PROSPERITY,
        xi.ki.IVORY_ABYSSITE_OF_PROSPERITY,
    }

    local dataRubyTiers =
    {
        [1] = { min = 0  , max = 63  },
        [2] = { min = 64 , max = 127 },
        [3] = { min = 128, max = 191 },
        [4] = { min = 192, max = 223 },
        [5] = { min = 224, max = 255 },
    }

    local chestModel = 968
    local dropType = xi.pyxis.chestDropType.LIGHT
    local chestSize = 3
    local playerRubyLight = lightValues[xi.abyssea.lightType.RUBY]
    local redabyssitebonus = 0
    local chestTier = 1

    for i, abyssite in pairs(abyssitesExperiences) do
        if player:hasKeyItem(abyssite) then
            redabyssitebonus = redabyssitebonus + 1
        end
    end

    for tier, rubytier in pairs(dataRubyTiers) do
        if playerRubyLight >= rubytier.min and playerRubyLight <= rubytier.max then
            if math.random(1, 100) < 5 then
                chestTier = math.max(tier, math.random(tier, 5))
            else
                chestTier = tier
            end
        end
    end

    chestTier = math.min(chestTier + redabyssitebonus, 5)

    local lightAvailable = {}
    local nb = 1

    for key, value in pairs(xi.pyxis.spawn.chestLightValues[chestTier]) do
        lightAvailable[nb] = key
        nb = nb + 1
    end

    local randLight = math.random(1, #lightAvailable)
    local light = lightAvailable[randLight]
    local message = xi.pyxis.spawn.lightsMessage[light][chestTier]
    local chestLightValue = xi.pyxis.spawn.chestLightValues[chestTier][light]

    return dropType, chestModel, chestSize, chestTier, light, message, chestLightValue
end

local function GetGoldChestInfos(player, lightValues)
    local abyssites =
    {
        xi.ki.VIRIDIAN_ABYSSITE_OF_DESTINY,
        xi.ki.CRIMSON_ABYSSITE_OF_DESTINY,
        xi.ki.IVORY_ABYSSITE_OF_DESTINY,
    }

    local dataAmberTiers =
    {
        [1] = { min =   0, max = 63 , maxUnlockNumber = 24 },
        [2] = { min =  64, max = 127, maxUnlockNumber = 35 },
        [3] = { min = 128, max = 191, maxUnlockNumber = 46 },
        [4] = { min = 192, max = 223, maxUnlockNumber = 68 },
        [5] = { min = 224, max = 255, maxUnlockNumber = 90 },
    }

    local playerAmberLight = lightValues[xi.abyssea.lightType.AMBER]
    local chestSize = xi.pyxis.spawn.goldCofferSize.LITTLE_CHEST
    local chestType = xi.pyxis.chestType.GOLD
    local maxUnlockNumber = 35
    local chestTier = 1
    local amberabyssitebonus = 0
    local chestModel = 969

    for i, abyssite in pairs(abyssites) do
        if player:hasKeyItem(abyssite) then
            amberabyssitebonus = amberabyssitebonus + 1
        end
    end

    for tier, amberTier in pairs(dataAmberTiers) do
        if playerAmberLight >= amberTier.min and playerAmberLight <= amberTier.max then
            if math.random(1, 100) < 5 then
                chestTier = math.max(tier, math.random(tier, 5))
                maxUnlockNumber = dataAmberTiers[tier + 1].maxUnlockNumber
            else
                chestTier = tier
                maxUnlockNumber = amberTier.maxUnlockNumber
            end
        end
    end

    chestTier = math.min(chestTier + amberabyssitebonus, 5)

    if chestTier >= 5 or math.random(1, 100) < 5 then
        chestSize = xi.pyxis.spawn.goldCofferSize.BIG_CHEST
    end

    local droptype = math.random(1, #xi.pyxis.spawn.chestMessageByChestType[chestType][chestSize])
    local drop = xi.pyxis.spawn.chestMessageByChestType[chestType][chestSize][droptype]
    local nbItem = 1

    for i = 2, drop.maxItem do
        if math.random(1, 100) < 40 then
            nbItem = nbItem + 1
        end
    end

    local message = drop.message

    return chestSize, maxUnlockNumber, chestTier, chestModel, droptype, nbItem, message
end

---------------------------------------------------------------------------------------------
-- Desc: This method allow you to set local var for blue red and gold chest
---------------------------------------------------------------------------------------------
local function SetPyxisData(npc, mob, player)
    local ID                = zones[player:getZoneID()]
    local lightValues       = xi.abyssea.getLightsTable(player)
    local chestType         = determineChestType(lightValues)
    local chestModel        = 0
    local chestTier         = 0
    local dropType          = 0
    local message           = 0
    local restore           = 0
    local nbItem            = 0
    local maxUnlockNumber   = 0
    local partyLeaderId     = player:getLeaderID()
    local required          = math.random(1, 6)
    local randnum           = 0
    local mobPos            = mob:getPos()
    local chestLightValue   = 0
    local sizeflag          = 3
    local light             = 1

    switch(chestType): caseof
    {
        [xi.pyxis.chestType.BLUE] = function()
            local bcChestSize, bcChestType, bcChestModel, bcChestTier, bcAmountCorrectAnswerNeeded, bcDroptype, bcMessage, bcRestore, bcNbItem = GetBlueChestInfos(player, lightValues)
            randnum     = math.random(10, 99)
            sizeflag    = bcChestSize
            message     = bcMessage
            dropType    = bcDroptype
            chestTier   = bcChestTier
            chestType   = bcChestType
            chestModel  = bcChestModel
            required    = bcAmountCorrectAnswerNeeded
            restore     = bcRestore
            nbItem      = bcNbItem
        end,

        [xi.pyxis.chestType.RED] = function()
            local rcDropType, rcChestModel, rcChestSize, rcChestTier, rcLight, rcMessage, rcChestLightValue = GetRedChestInfos(player, lightValues)
            randnum         = math.random(25, 60)
            sizeflag        = rcChestSize
            dropType        = rcDropType
            message         = rcMessage
            chestModel      = rcChestModel
            chestTier       = rcChestTier
            chestLightValue = rcChestLightValue
            light           = rcLight
        end,

        [xi.pyxis.chestType.GOLD] = function()
            local gcSize, gcMaxUnlockNumber, gcChestTier, gcChestModel, gcDroptype, gcNbItem, gcMessage = GetGoldChestInfos(player, lightValues)
            randnum         = math.random(11, gcMaxUnlockNumber)
            maxUnlockNumber = gcMaxUnlockNumber
            sizeflag        = gcSize
            dropType        = gcDroptype
            nbItem          = gcNbItem
            message         = gcMessage
            chestTier       = gcChestTier
            chestModel      = gcChestModel
        end,
    }

    if npc ~= nil or npc:getStatus() == xi.status.DISAPPEAR then
        npc:resetLocalVars()
        --------------------------------------
        -- Change flags
        --------------------------------------
        npc:setNpcFlags(sizeflag)

        -------------------------------------
        -- Chest data
        -------------------------------------
        npc:setLocalVar("PLAYERID", player:getID())
        npc:setLocalVar("PARTYLEADERID", partyLeaderId)
        npc:setLocalVar("TIER", chestTier)
        npc:setLocalVar("SIZE", sizeflag)
        npc:setLocalVar("CHESTTYPE", chestType)
        npc:setLocalVar("[pyxis]SPAWNTIME", os.time())
        npc:setLocalVar("RAND_NUM", randnum)
        npc:setLocalVar("REQUIRED", required)
        npc:setLocalVar("MAX_UNLOCK_NUMBER", maxUnlockNumber)
        npc:setLocalVar("NB_ITEM", nbItem)
        npc:setLocalVar("MESSAGE", message)
        npc:setLocalVar("DROPTYPE", dropType)
        npc:setLocalVar("LIGHT", light)
        npc:setLocalVar("CRUOR", 250 * chestTier)
        npc:setLocalVar("EXP", 250 * chestTier)
        npc:setLocalVar("RESTORE", restore)
        npc:setLocalVar("LIGHT_VALUE", chestLightValue)
        npc:setLocalVar("SPAWNSTATUS", 1)
        npc:setLocalVar("CHESTID", npc:getID())
        npc:setPos(mobPos.x, mobPos.y, mobPos.z, mobPos.rot)
        npc:setStatus(xi.status.NORMAL)
        npc:entityAnimationPacket("deru")
        npc:setAnimationSub(12)
        xi.pyxis.messageChest(player, ID.text.MONSTER_CONCEALED_CHEST, 0, 0, 0, 0)
        npc:setModelId(chestModel)

        npc:timer(180000, function(npcArg)
            if npcArg:getStatus() == xi.status.NORMAL then
                xi.pyxis.removeChest(player, npc, 0, 1)
            end
        end)
    else
        print("ERROR: Trying to spawn chest that is already spawned!")
    end
end

xi.pyxis.spawnPyxis = function(mob, player)
    local chestId = GetPyxisID(player)
    local npc = GetNPCByID(chestId)

    if chestId == 0 then
        return
    end

    if CanSpawnPyxis(player) then
        SetPyxisData(npc, mob, player)
    end
end
