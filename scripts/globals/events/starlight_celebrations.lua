-----------------------------------
-- Starlight Celebrations
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/npc_util")
------------------------------------

xi = xi or {}
xi.events = xi.events or {}
xi.events.starlightCelebration = xi.events.starlightCelebration or {}

function xi.events.starlightCelebration.isStarlightEnabled()
    local option = 0
    local month = tonumber(os.date("%m"))
    local day = tonumber(os.date("%d"))

    if (month == 12 and day >= 16) or xi.settings.main.STARLIGHT_YEAR_ROUND then -- According to wiki Startlight Festival is December 16 - December 31.
        if xi.settings.main.STARLIGHT_2021 == 1 then
            option = 1
        end
    end

    return option
end

--------------------------------
-- For the Children Sub-Quest --
--------------------------------
function xi.events.starlightCelebration.onStarlightSmilebringersTrade(player, trade, npc)
    local ID = zones[player:getZoneID()]
    local contentEnabled = xi.events.starlightCelebration.isStarlightEnabled()
    local item = trade:getItemId()
    local npcID = tostring(npc:getID())
    local npcTrades = player:getLocalVar("[Smilebringers][" .. npcID .. "]GiftsReceived")
    local head = player:getEquipID(xi.slot.HEAD)
    ------------------
    -- 2007 Edition --
    ------------------
    if (contentEnabled == 1) then
        ----------------------
        -- Presents Allowed --
        ----------------------
        local gifts_table =
        {
            1742, -- Present for Kiddies
            1743, -- Present for Kiddies
            1744, -- Present for Kiddies
            1745, -- Present for Kiddies
            4215, -- Popstar
            4216, -- Brilliant Snow
            4217, -- Sparkling Hand
            4218, -- Air Rider
            4167, -- Cracker
            4168, -- Twinkle Shower
            4169, -- Little Comet
        }

        local presents_table =
        {
            1742,
            1743,
            1744,
            1745,
        }
        ---------------
        -- Hat Check --
        ---------------
        if (head == 15179 or head == 15178) then
            if (npcTrades < 14) then
                for itemInList = 1, #gifts_table do
                    if (item == gifts_table[itemInList] and (item == presents_table[itemInList]) and (player:getFameLevel(xi.quest.fame_area.HOLIDAY) < 9)) then
                        player:showText(npc, ID.text.GIFT_THANK_YOU)
                        player:messageSpecial(ID.text.BARRELS_JOY_TO_CHILDREN)
                        player:addFame(xi.quest.fame_area.HOLIDAY, 128)
                        player:tradeComplete()
                    elseif (item == gifts_table[itemInList] and (player:getFameLevel(xi.quest.fame_area.HOLIDAY) < 9)) then
                        player:showText(npc, ID.text.GIFT_THANK_YOU)
                        player:messageSpecial(ID.text.JOY_TO_CHILDREN)
                        player:addFame(xi.quest.fame_area.HOLIDAY, 32)
                        player:tradeComplete()
                    elseif ((item == gifts_table[itemInList]) and (player:getFameLevel(xi.quest.fame_area.HOLIDAY) >= 9)) then
                        player:showText(npc, ID.text.ONLY_TWO_HANDS)
                    end
                end
                player:setLocalVar("[Smilebringers][" .. npcID .. "]GiftsReceived", npcTrades + 1)
            else
                player:showText(npc, ID.text.ONLY_TWO_HANDS)
            end
        else
            return
        end
    end
end

--------------------------------
-- Gifts for NPCs Sub-Quest --
--------------------------------

function xi.events.starlightCelebration.npcGiftsMoogleOnTrigger(player)
    local startedQuest = player:getLocalVar("[StarlightNPCGifts]Started")
    local hasCompleted = player:getCharVar("[StarlightNPCGifts]Completed")
    if startedQuest ~= 0 then
        local npc1 = player:getLocalVar("[StarlightNPCGifts]Npc1")
        local npc2 = player:getLocalVar("[StarlightNPCGifts]Npc2")
        local npc3 = player:getLocalVar("[StarlightNPCGifts]Npc3")
        local npc4 = player:getLocalVar("[StarlightNPCGifts]Npc4")
        local delivered = tonumber(npc4 .. npc3 .. npc2 .. npc1, 2)
        if delivered == 15 then
            player:startEvent(32702)
        else
            player:startEvent(32701, delivered)
        end
    else
        if hasCompleted == VanadielUniqueDay() then
            player:startEvent(32700)
        else
            player:startEvent(32703)
        end
    end
end

function xi.events.starlightCelebration.npcGiftsMoogleOnFinish(player, id, csid, option)
    if csid == 32703 and option == 1 then
        player:setLocalVar("[StarlightNPCGifts]Started", 1)
        player:setLocalVar("[StarlightNPCGifts]Npc1", 0)
        player:setLocalVar("[StarlightNPCGifts]Npc2", 0)
        player:setLocalVar("[StarlightNPCGifts]Npc3", 0)
        player:setLocalVar("[StarlightNPCGifts]Npc4", 0)
    elseif csid == 32702 then
        local hasToken = player:hasKeyItem(xi.keyItem.SNOW_THEMED_GIFT_TOKEN)
        local gift_table =
        {
            5622,   -- Candy Cane
            5621,   -- Candy Ring
        }
        local fireworks_table =
        {
            4215, -- Popstar
            4216, -- Brilliant Snow
            4217, -- Sparkling Hand
            4218, -- Air Rider
            4167, -- Cracker
            4168, -- Twinkle Shower
            4169, -- Little Comet
        }
        if hasToken == true then
            npcUtil.giveItem(player, gift_table[math.random(1, 2)])
        else
            player:addKeyItem(xi.keyItem.SNOW_THEMED_GIFT_TOKEN)
            player:messageSpecial(id.text.KEYITEM_OBTAINED, xi.keyItem.SNOW_THEMED_GIFT_TOKEN)
        end
        npcUtil.giveItem(player, { { fireworks_table[math.random( 1, 7 )], 10 } })
        player:setLocalVar("[StarlightNPCGifts]Started", 0)
        player:setCharVar("[StarlightNPCGifts]Completed", VanadielUniqueDay())
    end
end

local npcGiftsEvents =
{
    32693,
    32692,
    32691,
    32690,
}

function xi.events.starlightCelebration.npcGiftsNpcOnTrigger(player, eventid)
    local startedQuest = player:getLocalVar("[StarlightNPCGifts]Started")
    local npcProgress = player:getLocalVar("[StarlightNPCGifts]Npc" .. tostring(eventid))

    if startedQuest ~= 0 then
        if npcProgress ~= 1 then
            local eventTable = npcGiftsEvents
            local questUpdateStr = "[StarlightNPCGifts]Npc" .. eventid
            player:setLocalVar(questUpdateStr, 1)
            player:startEvent(eventTable[eventid])
        end
    else
        return
    end
end

--------------------------------
-- Token Redemption Sub-Quest --
--------------------------------

function xi.events.starlightCelebration.tokenMoogleOnTrigger(player)
    local startedTokens = player:getCharVar("[StarlightTokens]Started")
    if startedTokens ~= 0 then
        local snowToken = player:hasKeyItem(xi.keyItem.SNOW_THEMED_GIFT_TOKEN)
        local bellToken = player:hasKeyItem(xi.keyItem.BELL_THEMED_GIFT_TOKEN)
        local starToken = player:hasKeyItem(xi.keyItem.STAR_THEMED_GIFT_TOKEN)

        if (snowToken == true and bellToken == true and starToken == true) then
            player:startEvent(32705)
        else
            if snowToken then
                player:startEvent(32704, xi.keyItem.SNOW_THEMED_GIFT_TOKEN)
            elseif bellToken then
                player:startEvent(32704, xi.keyItem.BELL_THEMED_GIFT_TOKEN)
            elseif starToken then
                player:startEvent(32704, xi.keyItem.STAR_THEMED_GIFT_TOKEN)
            else
                player:startEvent(32706)
            end
        end

    else
        player:startEvent(32706)
    end
end

function xi.events.starlightCelebration.tokenMoogleOnFinish(player, id, csid, option)
    if csid == 32706 then
        player:setCharVar("[StarlightTokens]Started", 1)
    elseif csid == 32704 or (csid == 32705 and option ~= 1) then -- snow, bell, star
        local invAvailable = player:getFreeSlotsCount()
        local snowToken = player:hasKeyItem(xi.keyItem.SNOW_THEMED_GIFT_TOKEN)
        local bellToken = player:hasKeyItem(xi.keyItem.BELL_THEMED_GIFT_TOKEN)
        local starToken = player:hasKeyItem(xi.keyItem.STAR_THEMED_GIFT_TOKEN)
        local reward = 0
        local reward_table = {}
        local gifts_table =
            {
                SNOW_TOKEN =
                {
                    5552,   -- Black Pudding
                    18863,  -- Dream Bell
                    10382,  -- Dream Mittens
                    10383,  -- Dream Mittens +1
                    5542,   -- Gateau Aux Fraises
                    5616,   -- Lebkuchen House
                    5622,   -- Candy Cane
                    5621,   -- Candy Ring
                    177,    -- Snowman Miner
                    115,    -- Bastokan Tree
                },
                BELL_TOKEN =
                {
                    5552,   -- Black Pudding
                    5621,   -- Candy Ring
                    18863,  -- Dream Bell
                    15752,  -- Dream Boots
                    15753,  -- Dream Boots +1
                    5620,   -- Roast Turkey
                    178,    -- Snowman Mage
                    116,    -- Windurstian Tree
                },
                STAR_TOKEN =
                {
                    5550,   -- Buche au Chocolat
                    5622,   -- Candy Cane
                    5621,   -- Candy Ring
                    18863,  -- Dream Bell
                    14519,  -- Dream Robe
                    14520,  -- Dream Robe +1
                    5542,   -- Gateau Aux Fraises
                    5620,   -- Roast Turkey
                    176,    -- Snowman Knight
                    86,     -- San d'Orian Tree
                },
            }

        if invAvailable == 0 then
            player:messageSpecial(id.text.DEFAULT_CANNOT_BE_OBTAINED)
            return
        end

        if snowToken then
            player:delKeyItem(xi.keyItem.SNOW_THEMED_GIFT_TOKEN)
            reward_table = gifts_table.SNOW_TOKEN
        elseif bellToken then
            player:delKeyItem(xi.keyItem.BELL_THEMED_GIFT_TOKEN)
            reward_table = gifts_table.BELL_TOKEN
        elseif starToken then
            player:delKeyItem(xi.keyItem.STAR_THEMED_GIFT_TOKEN)
            reward_table = gifts_table.STAR_TOKEN
        end

        local count = #reward_table

        while count ~= 0 do
            local picked = reward_table[math.random(1, #reward_table)]
            if player:hasItem(picked) == false then
                reward = picked
                count = 0
                npcUtil.giveItem(player, reward)
            else
                if (picked > 178 and picked < 10382) then -- checks if reward is a food item
                    reward = picked
                    count = 0
                    npcUtil.giveItem(player, reward)
                else
                    table.remove(reward_table, picked) -- removes ra/ex items that player already has
                    count = count - 1
                end
            end
        end

    elseif (csid == 32705 and option == 1) then
        local hasNQ = player:hasItem(18863)
        local hasHQ = player:hasItem(18864)
        local invAvailable = player:getFreeSlotsCount()

        if invAvailable ~= 0 then
            if hasHQ then
                npcUtil.giveItem(player, { 5620, 5621, 5622 })
            elseif hasNQ then
                npcUtil.giveItem(player, 18864)
            else
                npcUtil.giveItem(player, 18863)
            end
            player:delKeyItem(xi.keyItem.SNOW_THEMED_GIFT_TOKEN)
            player:delKeyItem(xi.keyItem.BELL_THEMED_GIFT_TOKEN)
            player:delKeyItem(xi.keyItem.STAR_THEMED_GIFT_TOKEN)
        else
            player:messageSpecial(id.text.DEFAULT_CANNOT_BE_OBTAINED)
            return
        end
    end
end

-------------------------------------
-- Smilebringer Bootcamp Sub-Quest --
-------------------------------------

function xi.events.starlightCelebration.smileBringerSergeantOnTrigger(player, npc, zoneOption)
    local elapsedTime = (os.time() - player:getLocalVar("bootCampStarted"))
    local playerPoint = player:getLocalVar("playerBCCP")
    local completedDay = player:getCharVar("[SmileBootCamp]Completed")
    local currentDay = VanadielUniqueDay()
    local gil = player:getGil()
    local hasTree = player:hasItem(138)
    local recordHolderID = npc:getLocalVar("recordHolderID")
    local recordHolderName = ""
    local recordTime = 0
    local entry = 600
    local qualifyingTime = 540

    if recordHolderID ~= 0 then
        recordHolderName = GetPlayerByID(recordHolderID):getName()
        recordTime = npc:getLocalVar("recordTime")
    else
        recordHolderName = "Smilebringer"
        recordTime = 270
    end

    if completedDay ~= currentDay then
        if (gil >= 600) then
            if playerPoint ~= 0 then
                if playerPoint == 10 then
                    if (elapsedTime >= 540) then
                        player:startEvent(7011, elapsedTime, 10, 0, 35, 240, 17695260, 600, 0)
                    elseif (elapsedTime > recordTime and elapsedTime <= 540) then -- qualifying time
                        if hasTree == true then
                            player:startEvent(7005, elapsedTime, 5622, 0, 44519, -412436, 28, 1, 1)
                        else
                            player:startEvent(7005, elapsedTime, 138, 0, 44519, -412436, 28, 1, 1)
                        end
                    elseif (elapsedTime < recordTime) then -- new record
                        if hasTree == true then
                            player:startEvent(7005, elapsedTime, 5622, 0, 44519, -412436, 28, 1, 5)
                        else
                            player:startEvent(7005, elapsedTime, 138, 0, 44519, -412436, 28, 1, 5)
                        end
                        npc:setLocalVar("recordHolderID", player:getID())
                        npc:setLocalVar("recordTime", elapsedTime)
                    end
                else
                    player:startEvent(7004)
                end
            else
                player:startEventString(7001, recordHolderName, recordHolderName, recordHolderName, recordHolderName, 0, 0, 0, 1, recordTime, qualifyingTime, entry, zoneOption)
            end
        else
            player:startEventString(7001, recordHolderName, recordHolderName, recordHolderName, recordHolderName, 0, 0, 0, 0, recordTime, qualifyingTime, entry, zoneOption)
        end
    else
        player:startEventString(7001, recordHolderName, recordHolderName, recordHolderName, recordHolderName, 0, 1, 0, 0, recordTime, qualifyingTime, entry, zoneOption)
    end
end

function xi.events.starlightCelebration.smileBringerSergeantOnFinish(player, npc, id, csid, option)
    if csid == 7001 and option == 2 then
        local zoneid = player:getZoneID()
        player:delGil(600)
        player:showText(npc, id.text.SMILEBRINGER_START)
        player:setLocalVar("bootCampStarted", os.time())
        player:setLocalVar("playerBCCP", 1)
        xi.events.starlightCelebration.toggleSmileHelpers(zoneid)
    elseif csid == 7005 then
        local hasItem = player:hasItem(138)
        if hasItem == true then
            player:resetLocalVars()
            player:setCharVar("[SmileBootCamp]Completed", VanadielUniqueDay())
            npcUtil.giveItem( player, 5622, { silent = true } )
            if not player:hasKeyItem(xi.keyItem.BELL_THEMED_GIFT_TOKEN) then
                player:addKeyItem(xi.keyItem.BELL_THEMED_GIFT_TOKEN)
                player:messageSpecial(id.text.KEYITEM_OBTAINED, xi.keyItem.BELL_THEMED_GIFT_TOKEN)
            end
        else
            player:resetLocalVars()
            player:setCharVar("[SmileBootCamp]Completed", VanadielUniqueDay())
            npcUtil.giveItem( player, 138, { silent = true } )
        end
    elseif csid == 7011 then
        player:resetLocalVars()
    end
end

function xi.events.starlightCelebration.smileHelperTrigger(player, npc, id)
    local npcID = tostring(npc:getID())
    local playerTime = player:getLocalVar("bootCampStarted")
    local playerPoint = player:getLocalVar("playerBCCP")
    local npcPoint = player:getLocalVar("Checkpoint" .. npcID)
    local missedFlee = player:getLocalVar("missedFlee")
    local seconds = math.fmod(os.time() - playerTime, 60)
    local minutes = math.floor((os.time() - playerTime) / 60)

    if playerTime ~= 0 then
        if playerPoint ~= 0 then
            if (npcPoint == 0 and playerPoint ~= 10) then
                player:setLocalVar("playerBCCP", playerPoint + 1)
                player:setLocalVar("Checkpoint" .. npcID, 1)
                if player:getStatusEffect(xi.effect.FLEE) ~= nil or playerPoint == 0 or missedFlee == 0 then
                    player:setLocalVar("missedFlee", 0)
                    player:showText(npc, id.text.SMILEHELPER_CHECKPOINT_2, 0, playerPoint, minutes, seconds)
                    player:addStatusEffect(xi.effect.FLEE, 100, 0, 30)
                else
                    local rnd = math.random(0, 3)
                    if rnd ~= 3 then
                        player:setLocalVar("missedFlee", 1)
                        player:showText(npc, id.text.SMILEHELPER_CHECKPOINT_1, 0, playerPoint, minutes, seconds)
                    else
                        player:setLocalVar("missedFlee", 0)
                        player:showText(npc, id.text.SMILEHELPER_CHECKPOINT_2, 0, playerPoint, minutes, seconds)
                        player:addStatusEffect(xi.effect.FLEE, 100, 0, 30)
                    end
                end
            elseif playerPoint == 10 then
                player:showText(npc, id.text.SMILEHELPER_POINTS_CLEARED)
                player:addStatusEffect(xi.effect.FLEE, 100, 0, 30)
            elseif npcPoint ~= 0 then
                player:showText(npc, id.text.SMILEHELPER_ALREADY_VISITED, 0, playerPoint, minutes, seconds)
            end
        end
    else
        player:showText(npc, id.text.SMILEHELPER_IDLE)
    end
end

----------------------------------------------------------------
-- Apply Zone Decorations, Vendors, and Additional Event NPCs --
----------------------------------------------------------------
function xi.events.starlightCelebration.applyStarlightDecorations(zoneid)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        local decoration = zones[zoneid].npc.STARLIGHT_DECORATIONS
        if decoration then
            for id, v in pairs(decoration) do
                local npc = GetNPCByID(id)
                if npc then
                    npc:setStatus(xi.status.NORMAL)
                end
            end
        end
    end
end

function xi.events.starlightCelebration.toggleSmileHelpers(zoneid)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        local smileHelper = zones[zoneid].npc.SMILE_HELPERS
        if smileHelper then
            for id, v in pairs(smileHelper) do
                local npc = GetNPCByID(id)
                if npc then
                    npc:setStatus(xi.status.NORMAL)
                    npc:setLocalVar("depopTime", (os.time() + 3600))
                end
            end
        end
    end
end

function xi.events.starlightCelebration.resetSmileHelpers(zoneid)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        local smileHelper = zones[zoneid].npc.SMILE_HELPERS
        if smileHelper then
            for id, v in pairs(smileHelper) do
                local npc = GetNPCByID(id)
                local depopTime = npc:getLocalVar("depopTime")
                if depopTime < os.time() then
                    npc:setStatus(xi.status.DISAPPEAR)
                end
            end
        end
    end
end

----------------------------------
-- Goblin Merrymakers Sub-Quest --
----------------------------------

local merryMakersNPCs =
{
    Bastok_Markets =
    {
        17739830,   -- Lame Deer
        17739831,   -- Epione
        17739829,   -- Pavel
        17739833,   -- Tancredi
        17739837,   -- Red Canyon
        17739839,   -- Anguysh
    },
    Northern_SandOria =
    {
        17723550,    -- Villion
        17723468,    -- Telmoda
        17723470,    -- Rodaillece
        17723472,    -- Gilipese
        17723415,    -- Coullene
        17723520,    -- Vavegallet
    },
    Windurst_Waters =
    {
        17752170,    -- Bulolo
        17752160,    -- Pulyiki
        17752200,    -- Pia
        17752167,    -- Kobite-Mojite
        17752191,    -- Reh Hapli
        17752188     -- Kuesoso
    },
    Receive_Event_IDs =
    {
        4889,
        4887,
        4881,
        4885,
        4891,
        4883,
    },
    Send_Event_IDs =
    {
        4862,
        4859,
        4850,
        4856,
        4865,
        4853,
    }
}

function xi.events.starlightCelebration.getMerrymakerNPCIDs(zoneid)
    local npc_table = {}
    if xi.events.starlightCelebration.isStarlightEnabled ~= 0 then
        if zoneid == 231 then
            npc_table = merryMakersNPCs.Northern_SandOria
            return npc_table
        elseif zoneid == 235 then
            npc_table = merryMakersNPCs.Bastok_Markets
            return npc_table
        elseif zoneid == 238 then
            npc_table = merryMakersNPCs.Windurst_Waters
            return npc_table
        end
    end
end

function xi.events.starlightCelebration.merryMakersGoblinOnTrigger(player, npc, id)
    local questStatus = player:getLocalVar("[StarlightMerryMakers]Started")
    local hasTrust = player:getLocalVar("[StarlightMerryMakers]GoblinTrust")
    local hasPresent = player:getLocalVar("[StarlightMerryMakers]HasPresent")

    if questStatus ~= 0 then
        if hasTrust == npc:getID() then
            local loseTrust = math.random(0, 3)

            if loseTrust ~= 0 then
                if loseTrust == 1 then
                    player:showText(npc, id.text.MERRYMAKER_FRIEND) -- Response 1
                elseif loseTrust == 2 then
                    player:showText(npc, id.text.MERRYMAKER_WAHH) -- Response 2
                elseif loseTrust == 3 then
                    if hasPresent == 0 then
                        player:startEvent(4711) -- gives present
                    else
                        player:showText(npc, id.text.MERRYMAKER_NO) -- loses trust
                    end
                end
            else
                player:setLocalVar("[StarlightMerryMakers]GoblinTrust", 0)
                player:startEvent(4712)
            end
        else
            player:startEvent(4712)
        end
    else
        player:showText(npc, id.text.MERRYMAKER_DEFAULT)
    end
end

function xi.events.starlightCelebration.merryMakersGoblinOnFinish(player, csid, option, id)
    if csid == 4711 then
        local rnd = math.random(1, 3)

        if rnd == 1 then
            player:addKeyItem(xi.keyItem.RED_PRESENT)
            player:messageSpecial(id.text.KEYITEM_OBTAINED, xi.keyItem.RED_PRESENT)
        elseif rnd == 2 then
            player:addKeyItem(xi.keyItem.GREEN_PRESENT)
            player:messageSpecial(id.text.KEYITEM_OBTAINED, xi.keyItem.GREEN_PRESENT)
        else
            player:addKeyItem(xi.keyItem.BLUE_PRESENT)
            player:messageSpecial(id.text.KEYITEM_OBTAINED, xi.keyItem.BLUE_PRESENT)
        end

        player:setLocalVar("[StarlightMerryMakers]GoblinTrust", 0)
        player:setLocalVar("[StarlightMerryMakers]HasPresent", 1)
    end
end

function xi.events.starlightCelebration.merryMakersGoblinOnTrade(player, npc, trade, id)
    local questStatus = player:getLocalVar("[StarlightMerryMakers]Started")
    if questStatus ~= 0 then
        if npcUtil.tradeHasExactly(trade, 4495) then
            player:setLocalVar("[StarlightMerryMakers]GoblinTrust", npc:getID())
            player:tradeComplete()
            player:showText(npc, id.text.MERRYMAKER_TRADE)
        else
            player:showText(npc, id.text.MERRYMAKER_BLECH)
        end
    else
        player:showText(npc, id.text.MERRYMAKER_DEFAULT)
    end
end

function xi.events.starlightCelebration.merryMakersMoogleOnTrigger(player, npc)
    local questStatus = player:getLocalVar("[StarlightMerryMakers]Started")
    local sender = player:getLocalVar("[StarlightMerryMakers]Sender")
    local hasPresent = player:getLocalVar("[StarlightMerryMakers]HasPresent")
    local cleared = player:getLocalVar("[StarlightMerryMakers]Cleared")
    local confirmed = player:getLocalVar("[StarlightMerryMakers]Confirmed")
    local delivered = player:getLocalVar("[StarlightMerryMakers]Delivered")
    local red_present = player:hasKeyItem(xi.keyItem.RED_PRESENT)
    local green_present = player:hasKeyItem(xi.keyItem.GREEN_PRESENT)
    local blue_present = player:hasKeyItem(xi.keyItem.BLUE_PRESENT)

    if (red_present or green_present or blue_present) then
        player:setLocalVar("[StarlightMerryMakers]HasPresent", 1)
    end

    if questStatus ~= 0 then
        if cleared ~= 0 then
            player:startEvent(4702)
        elseif delivered ~= 0 then
            local npcName = GetNPCByID(sender):getName()
            if string.find(npcName, "%_") ~= 0 then
                npcName = string.gsub(npcName, "%_", " ")
            end
            player:startEventString(4705, npcName)
        elseif confirmed ~= 0 then
            local npcName = GetNPCByID(sender):getName()
            if string.find(npcName, "%_") ~= 0 then
                npcName = string.gsub(npcName, "%_", " ")
            end
            player:startEventString(4704, npcName)
        elseif (sender == 0 and hasPresent ~= 0) then

            local npc_table = xi.events.starlightCelebration.getMerrymakerNPCIDs(npc:getZoneID())

            if (red_present or green_present or blue_present) then
                local rnd = math.random(1, 6)
                local giftNpcID = npc_table[rnd]
                local giftNpc = GetNPCByID(giftNpcID):getName()

                if string.find(giftNpc, "%_") ~= 0 then
                    giftNpc = string.gsub(giftNpc, "%_", " ")
                end

                player:startEventString(4701, giftNpc)
                player:setLocalVar("[StarlightMerryMakers]Sender", giftNpcID)
                player:setLocalVar("[StarlightMerryMakers]SenderID", rnd)
            end
        else
            player:startEvent(4703, 2)
        end
    else
        player:startEvent(4700)
        player:setLocalVar("[StarlightMerryMakers]Started", 1)
    end
end

function xi.events.starlightCelebration.merryMakersMoogleOnFinish(player, id, csid, option)
    if csid == 4702 then
        local dreamPants = player:hasItem(11967)
        local dreamTrousers = player:hasItem(11965)
        local dreamPantsHQ = player:hasItem(11968)
        local dreamTrousersHQ = player:hasItem(11966)
        local starToken = player:hasKeyItem(xi.keyItem.STAR_THEMED_GIFT_TOKEN)

        local gender = player:getGender()

        if gender == 0 then
            if not dreamPants then
                npcUtil.giveItem(player, 11967)
            elseif (dreamPants and not dreamPantsHQ) then
                npcUtil.giveItem(player, 11968)
            elseif (dreamPantsHQ and starToken) then
                npcUtil.giveItem(player, 5622)
            else
                player:addKeyItem(xi.keyItem.STAR_THEMED_GIFT_TOKEN)
                player:messageSpecial(id.text.KEYITEM_OBTAINED, xi.keyItem.STAR_THEMED_GIFT_TOKEN)
            end
        else
            if not dreamTrousers then
                npcUtil.giveItem(player, 11965)
            elseif (dreamTrousers and not dreamTrousersHQ) then
                npcUtil.giveItem(player, 11966)
            elseif (dreamTrousersHQ and starToken) then
                npcUtil.giveItem(player, 5621)
            else
                player:addKeyItem(xi.keyItem.STAR_THEMED_GIFT_TOKEN)
                player:messageSpecial(id.text.KEYITEM_OBTAINED, xi.keyItem.STAR_THEMED_GIFT_TOKEN)
            end
        end
        player:setLocalVar("[StarlightMerryMakers]Cleared", 0)
    end
end

function xi.events.starlightCelebration.merryMakersNPCDeliverOnTrigger(player, npc, id)
    local npcID = npc:getID()
    local sender = player:getLocalVar("[StarlightMerryMakers]Sender")
    local questStatus = player:getLocalVar("[StarlightMerryMakers]Started")
    local confirmed = player:getLocalVar("[StarlightMerryMakers]Confirmed")
    local delivered = player:getLocalVar("[StarlightMerryMakers]Delivered")

    if questStatus ~= 0 then
        if delivered ~= 0 then
            player:setLocalVar("[StarlightMerryMakers]Sender", 0)
            player:setLocalVar("[StarlightMerryMakers]Confirmed", 0)
            player:setLocalVar("[StarlightMerryMakers]Delivered", 0)
            player:setLocalVar("[StarlightMerryMakers]Cleared", 1)
            player:showText(npc, id.text.MERRYMAKER_NPC_RETURNED)
        elseif confirmed ~= 0 then
            local npcName = GetNPCByID(sender):getName()
            local event_pos = player:getLocalVar("[StarlightMerryMakers]ConfirmedID")
            local event_table = merryMakersNPCs.Receive_Event_IDs[event_pos]
            local red_present = player:hasKeyItem(xi.keyItem.RED_PRESENT)
            local green_present = player:hasKeyItem(xi.keyItem.GREEN_PRESENT)
            local blue_present = player:hasKeyItem(xi.keyItem.BLUE_PRESENT)
            local currentNpc = npc:getID()

            if currentNpc ~= sender then
                if string.find(npcName, "%_") ~= 0 then
                    npcName = string.gsub(npcName, "%_", " ")
                end

                player:startEventString(event_table, npcName)
                player:setLocalVar("[StarlightMerryMakers]Confirmed", 0)
                player:setLocalVar("[StarlightMerryMakers]Delivered", npc:getID())

                if red_present then
                    player:delKeyItem(xi.keyItem.RED_PRESENT)
                    player:messageSpecial(id.text.KEYITEM_LOST, xi.keyItem.RED_PRESENT)
                elseif green_present then
                    player:delKeyItem(xi.keyItem.GREEN_PRESENT)
                    player:messageSpecial(id.text.KEYITEM_LOST, xi.keyItem.GREEN_PRESENT)
                elseif blue_present then
                    player:delKeyItem(xi.keyItem.BLUE_PRESENT)
                    player:messageSpecial(id.text.KEYITEM_LOST, xi.keyItem.BLUE_PRESENT)
                end
                player:setLocalVar("[StarlightMerryMakers]HasPresent", 0)
            elseif currentNpc == sender then
                local eventID = player:getLocalVar("[StarlightMerryMakers]SenderID")
                local target_table = merryMakersNPCs.Send_Event_IDs
                local targetID = player:getLocalVar("[StarlightMerryMakers]Confirmed")

                local targetName = GetNPCByID(targetID):getName()

                player:startEvent(target_table[eventID], targetName)
            end
        else
            if player:getLocalVar("[StarlightMerryMakers]Sender") == npcID then
                local eventID = player:getLocalVar("[StarlightMerryMakers]SenderID")
                local npc_table = xi.events.starlightCelebration.getMerrymakerNPCIDs(npc:getZoneID())
                local event_table = merryMakersNPCs.Send_Event_IDs
                local receiver = 0
                local receiveID = 0
                local count = #npc_table
                while count ~= 0 do
                    local rnd = math.random(1, #npc_table)
                    local picked = npc_table[rnd]
                    if picked ~= npcID then
                        receiver = picked
                        count = 0
                        receiveID = rnd
                    else
                        table.remove(npc_table, picked) -- removes this NPC's ID from table
                        count = count - 1
                    end
                end
                local npcName = GetNPCByID(receiver):getName()

                if string.find(npcName, "%_") ~= 0 then
                    npcName = string.gsub(npcName, "%_", " ")
                end
                player:startEvent(event_table[eventID], npcName)
                player:setLocalVar("[StarlightMerryMakers]Confirmed", receiver)
                player:setLocalVar("[StarlightMerryMakers]ConfirmedID", receiveID)
            else
                return
            end
        end
    else
        return
    end
end

return xi.events.starlightCelebration
