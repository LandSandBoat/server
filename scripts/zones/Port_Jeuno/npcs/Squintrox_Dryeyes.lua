-----------------------------------
-- Area: Port Jeuno
--  NPC: Squintrox Dryeyes
-- Type: Addon Mission Merchant
-- !pos -100.071 -1 11.869 246
-- wiki has good info on his behavior: https://ffxiclopedia.fandom.com/wiki/Squintrox_Dryeyes
-- Essentially, he accomodates re-obtaining key items from completed mini expansion missions
-----------------------------------
local ID = zones[xi.zone.PORT_JEUNO]
require('scripts/missions/amk/helpers')
-----------------------------------
---@type TNpcEntity
local entity = {}

-- maps the menu options to the key items/missions that block access
-- second page is auto indexed as a list and matches the order of the 2nd page menu
-- first page is keyed by the key item, since the menu options don't have a clean pattern
-- first page mostly listed here to have one place to reference all the metadata about a menu option's flow, but also to clean up some of the complex event args
local menuMetadata =
{
    [1] =
    {
        ['initialList'] =
        {
            xi.ki.CRIMSON_KEY,
            xi.ki.VIRIDIAN_KEY,
            xi.ki.WHITE_CORAL_KEY,
            xi.ki.BLUE_CORAL_KEY,
            xi.ki.BLACK_CORAL_KEY,
            xi.ki.MOOGLE_KEY,
            xi.ki.BIRD_KEY,
            xi.ki.BOMB_KEY,
        },
        [xi.ki.CRIMSON_KEY] =
        {
            expansion    = 1,
            charVar      = 'LastCrimsonKey',
            reqItems     =
            {
                xi.item.SEEDSPALL_LUX,
                xi.item.SEEDSPALL_LUNA,
                xi.item.SEEDSPALL_ASTRUM,
            },
        },
        [xi.ki.VIRIDIAN_KEY] =
        {
            expansion   = 1,
            charVar     = 'LastViridianKey',
            reqKeyItems =
            {
                xi.ki.BOWL_OF_BLAND_GOBLIN_SALAD,
                xi.ki.JUG_OF_GREASY_GOBLIN_JUICE,
                xi.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB,
            }
        },
        [xi.ki.WHITE_CORAL_KEY] =
        {
            expansion = 2,
            charVar   = 'LastWhiteCoralKey',
            reqItems  =
            {
                xi.item.ORCISH_PLATE_ARMOR,
                xi.item.QUADAV_BACKSCALE,
                xi.item.YAGUDO_CAULK,
            },
        },
        [xi.ki.BLUE_CORAL_KEY] =
        {
            expansion   = 2,
            charVar     = 'LastBlueCoralKey',
            reqKeyItems =
            {
                xi.ki.STURDY_METAL_STRIP,
                xi.ki.PIECE_OF_RUGGED_TREE_BARK,
                xi.ki.SAVORY_LAMB_ROAST,
            },
        },
        [xi.ki.BLACK_CORAL_KEY] =
        {
            expansion   = 2,
            charVar     = 'LastBlackCoralKey',
            reqKeyItems =
            {
                xi.ki.MOLDY_WORM_EATEN_CHEST,
            },
        },
        [xi.ki.MOOGLE_KEY] =
        {
            expansion      = 3,
            charVar        = 'LastMoogleKey',
            reqItemCharVar = 'ASA_kit',
            reqItems       =
            {
                xi.item.ENFEEBLEMENT_KIT_OF_POISON,
                xi.item.ENFEEBLEMENT_KIT_OF_BLINDNESS,
                xi.item.ENFEEBLEMENT_KIT_OF_SLEEP,
                xi.item.ENFEEBLEMENT_KIT_OF_SILENCE,
            }
        },
        [xi.ki.BIRD_KEY] =
        {
            expansion    = 3,
            charVar      = 'LastBirdKey',
            reqItemCount = 3,
            reqKeyItems  =
            {
                xi.ki.AMBER_COUNTERSEAL,
                xi.ki.AZURE_COUNTERSEAL,
                xi.ki.CERULEAN_COUNTERSEAL,
                xi.ki.EMERALD_COUNTERSEAL,
                xi.ki.SCARLET_COUNTERSEAL,
                xi.ki.VIOLET_COUNTERSEAL,
            },
            prereqKeyItems =
            {
                xi.ki.DOMINAS_SCARLET_SEAL,
                xi.ki.DOMINAS_CERULEAN_SEAL,
                xi.ki.DOMINAS_EMERALD_SEAL,
                xi.ki.DOMINAS_AMBER_SEAL,
                xi.ki.DOMINAS_VIOLET_SEAL,
                xi.ki.DOMINAS_AZURE_SEAL,
            },
        },
        [xi.ki.BOMB_KEY] =
        {
            expansion   = 3,
            charVar     = 'LastBombKey',
            reqKeyItems =
            {
                xi.ki.LUMINOUS_PURPLE_FRAGMENT,
                xi.ki.LUMINOUS_YELLOW_FRAGMENT,
                xi.ki.LUMINOUS_BLUE_FRAGMENT,
                xi.ki.LUMINOUS_BEIGE_FRAGMENT,
                xi.ki.LUMINOUS_RED_FRAGMENT,
                xi.ki.LUMINOUS_GREEN_FRAGMENT,
            },
        },
    },
    [2] =
    {
        {
            expansion        = 1,
            costGil          = 500,
            costSeals        = 5,
            relevantKeyItems =
            {
                xi.ki.SEEDSPALL_ROSEUM,
                xi.ki.SEEDSPALL_CAERULUM,
                xi.ki.SEEDSPALL_VIRIDIS,
            },
        },
        {
            expansion        = 2,
            costGil          = 1500,
            costSeals        = 15,
            relevantKeyItems =
            {
                xi.ki.MARK_OF_SEED,
            },
        },
        {
            expansion        = 3,
            costGil          = 2000,
            costSeals        = 20,
            relevantKeyItems =
            {
                xi.ki.OMNIS_STONE,
            },
        },
        {
            expansion        = 1,
            costGil          = 500,
            costSeals        = 5,
            relevantKeyItems =
            {
                xi.ki.ORB_OF_CUPS,
                xi.ki.ORB_OF_COINS,
                xi.ki.ORB_OF_BATONS,
                xi.ki.ORB_OF_SWORDS,
            },
        },
        {
            expansion        = 2,
            costGil          = 1500,
            costSeals        = 15,
            relevantKeyItems =
            {
                xi.ki.NAVARATNA_TALISMAN,
            },
        },
        {
            expansion        = 3,
            costGil          = 2000,
            costSeals        = 20,
            relevantKeyItems =
            {
                xi.ki.MEGA_BONANZA_KUPON,
            },
        },
        {
            expansion        = 1,
            costGil          = 500,
            costSeals        = 5,
            relevantKeyItems =
            {
                xi.ki.BLACK_BOOK,
            },
        },
        {
            expansion        = 2,
            costGil          = 1500,
            costSeals        = 15,
            relevantKeyItems =
            {
                xi.ki.WATER_SAP_CRYSTAL,
                xi.ki.EARTH_SAP_CRYSTAL,
                xi.ki.ICE_SAP_CRYSTAL,
                xi.ki.WIND_SAP_CRYSTAL,
                xi.ki.LIGHTNING_SAP_CRYSTAL,
                xi.ki.FIRE_SAP_CRYSTAL,
                xi.ki.LIGHT_SAP_CRYSTAL,
                xi.ki.DARK_SAP_CRYSTAL,
            },
        },
        {
            expansion        = 3,
            costGil          = 2000,
            costSeals        = 20,
            relevantKeyItems =
            {
                xi.ki.TABLET_OF_HEXES_GREED,
                xi.ki.TABLET_OF_HEXES_ENVY,
                xi.ki.TABLET_OF_HEXES_MALICE,
                xi.ki.TABLET_OF_HEXES_DECEIT,
                xi.ki.TABLET_OF_HEXES_PRIDE,
                xi.ki.TABLET_OF_HEXES_BALE,
                xi.ki.TABLET_OF_HEXES_DESPAIR,
                xi.ki.TABLET_OF_HEXES_REGRET,
                xi.ki.TABLET_OF_HEXES_RAGE,
                xi.ki.TABLET_OF_HEXES_AGONY,
                xi.ki.TABLET_OF_HEXES_DOLOR,
                xi.ki.TABLET_OF_HEXES_RANCOR,
                xi.ki.TABLET_OF_HEXES_STRIFE,
                xi.ki.TABLET_OF_HEXES_PENURY,
                xi.ki.TABLET_OF_HEXES_BLIGHT,
                xi.ki.TABLET_OF_HEXES_DEATH,
            },
        },
    },
}

-- Takes traded items if they are all there, squintrox responds either way, and bool return is true if the trade is successful
local function tradeForKeyItem(player, trade, ki)
    local charVar = menuMetadata[1][ki].charVar
    if
        not player:hasKeyItem(ki) and
        os.time() >= player:getCharVar(charVar)
    then
        player:tradeComplete()
        player:setCharVar(charVar, getMidnight())
        player:messageSpecial(ID.text.DRYEYES_2)
        npcUtil.giveKeyItem(player, ki)
        return true
    else
        player:messageSpecial(ID.text.DRYEYES_3, ki)
        return false
    end
end

local function verifyReqKeyItems(player, ki)
    local entry = menuMetadata[1][ki]
    local reqItemCount = 0
    if entry.reqItemCount ~= nil then
        reqItemCount = entry.reqItemCount
    end

    local count = 0
    for _, reqKeyItem in pairs(entry.reqKeyItems) do
        if reqItemCount > 0 then
            if player:hasKeyItem(reqKeyItem) then
                count = count + 1
            end
        elseif not player:hasKeyItem(reqKeyItem) then
            return false
        end
    end

    if reqItemCount > 0 then
        if count >= reqItemCount then
            return count
        else
            return 0
        end
    else
        return true
    end
end

local function takeReqKeyItems(player, ki)
    local entry = menuMetadata[1][ki]
    for _, reqKeyItem in pairs(entry.reqKeyItems) do
        if player:hasKeyItem(reqKeyItem) then
            player:messageSpecial(ID.text.KEYITEM_LOST, reqKeyItem)
            player:delKeyItem(reqKeyItem)
        end
    end

    if entry.prereqKeyItems then
        for _, reqKeyItem in pairs(entry.prereqKeyItems) do
            if player:hasKeyItem(reqKeyItem) then
                player:messageSpecial(ID.text.KEYITEM_LOST, reqKeyItem)
                player:delKeyItem(reqKeyItem)
            end
        end
    end

    player:setCharVar(entry.charVar, getMidnight())
    player:showText(player, ID.text.DRYEYES_2)
    npcUtil.giveKeyItem(player, ki)
end

entity.onTrade = function(player, npc, trade)
    local count  = trade:getItemCount()
    local ki     = xi.ki.MOOGLE_KEY
    local asaKit = player:getCharVar(menuMetadata[1][ki].reqItemCharVar)

    if -- Crimson Key: Trade Seedspall's Lux, Luna, Astrum
        trade:hasItemQty(menuMetadata[1][xi.ki.CRIMSON_KEY].reqItems[1], 1) and
        trade:hasItemQty(menuMetadata[1][xi.ki.CRIMSON_KEY].reqItems[2], 1) and
        trade:hasItemQty(menuMetadata[1][xi.ki.CRIMSON_KEY].reqItems[3], 1) and
        count == 3 and
        player:getCurrentMission(xi.mission.log_id.ACP) == xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN
    then
        ki = xi.ki.CRIMSON_KEY
        tradeForKeyItem(player, trade, ki)
    elseif -- White Coral Key: orcish plate armor, quadav backscale, yagudo caulk
        trade:hasItemQty(menuMetadata[1][xi.ki.WHITE_CORAL_KEY].reqItems[1], 1) and
        trade:hasItemQty(menuMetadata[1][xi.ki.WHITE_CORAL_KEY].reqItems[2], 1) and
        trade:hasItemQty(menuMetadata[1][xi.ki.WHITE_CORAL_KEY].reqItems[3], 1) and
        count == 3 and
        player:getCurrentMission(xi.mission.log_id.AMK) == xi.mission.id.amk.A_MOOGLE_KUPO_DETAT_FIN
    then
        ki = xi.ki.WHITE_CORAL_KEY
        tradeForKeyItem(player, trade, ki)
    elseif -- Moogle Key: trade proper enfeebling kit
        asaKit ~= 0 and
        trade:hasItemQty(asaKit, 1) and
        count == 1 and
        player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.A_SHANTOTTO_ASCENSION_FIN
    then
        ki = xi.ki.MOOGLE_KEY
        if tradeForKeyItem(player, trade, ki) then
            player:setCharVar(menuMetadata[1][ki].reqItemCharVar, 0)
        end
    else
        player:showText(npc, ID.text.GET_LOST)
    end
end

entity.onTrigger = function(player, npc)
    if
        xi.settings.main.ENABLE_ACP == 0 and
        xi.settings.main.ENABLE_AMK == 0 and
        xi.settings.main.ENABLE_ASA == 0
    then
        player:showText(npc, ID.text.GET_LOST)
    else
        local now          = os.time()
        local finishedACP  = player:getCurrentMission(xi.mission.log_id.ACP) == xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN
        local finishedAMK  = player:getCurrentMission(xi.mission.log_id.AMK) == xi.mission.id.amk.A_MOOGLE_KUPO_DETAT_FIN
        local finishedASA  = player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.A_SHANTOTTO_ASCENSION_FIN

        -- Show only the key items available to retrive based on time gate and if you don't already have it
        local arg1 = 0
        for bitPos, ki in pairs(menuMetadata[1]['initialList']) do
            local entry = menuMetadata[1][ki]
            local hasCompletedExpansion = false
            if entry.expansion == 1 then
                hasCompletedExpansion = finishedACP
            elseif entry.expansion == 2 then
                hasCompletedExpansion = finishedAMK
            elseif entry.expansion == 3 then
                hasCompletedExpansion = finishedASA
            end

            -- Reminder that "True" here means the option should be excluded from the player's menu
            if
                not hasCompletedExpansion or
                player:hasKeyItem(ki) or
                now < player:getCharVar(entry.charVar)
            then
                arg1 = utils.mask.setBit(arg1, bitPos, true)
            end
        end

        player:startEvent(323, arg1)
    end
end

-- validation of prereqs done here, event option updated based on checks to be used in onEventFinish
entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 323 then
        if option == 100 then -- Viridian Key
            if verifyReqKeyItems(player, xi.ki.VIRIDIAN_KEY) then
                player:updateEvent(1)
            else
                player:updateEvent(0)
            end
        elseif option == 101 then -- blue coral Key
            if verifyReqKeyItems(player, xi.ki.BLUE_CORAL_KEY) then
                player:updateEvent(3)
            else
                player:updateEvent(0)
            end
        elseif option == 102 then -- black coral Key
            local ki = xi.ki.BLACK_CORAL_KEY
            if not player:hasKeyItem(menuMetadata[1][ki].reqKeyItems[1]) then
                -- extracts the eventID for the digging zone
                local diggingZoneEventID = xi.amk.helpers.getDiggingZone(player)
                if diggingZoneEventID ~= 0 then
                    player:updateEvent(0, 1, diggingZoneEventID)
                else
                    player:messageSpecial(ID.text.GET_LOST)
                end
            end
        elseif option == 103 then -- Moogle Key
            local entry = menuMetadata[1][xi.ki.MOOGLE_KEY]
            local asaKit = player:getCharVar(entry.reqItemCharVar)
            if asaKit == 0 then
                asaKit = entry.reqItems[math.random(1, #entry.reqItems)]
                player:setCharVar(entry.reqItemCharVar, asaKit)
            end

            player:updateEvent(asaKit)
        elseif option == 104 then -- Bird Key
            local completedSeals = verifyReqKeyItems(player, xi.ki.BIRD_KEY)

            -- if verifyReqKeyItems returns a positive number, it meens it was at least the minimum
            if not completedSeals or completedSeals <= 0 then
                -- distribute prereq seals
                player:updateEvent(0, 0, 1)
            else
                player:updateEvent(0, completedSeals, 2)
            end
        elseif option == 105 then -- Bomb Key
            if not verifyReqKeyItems(player, xi.ki.BOMB_KEY) then
                player:updateEvent(0, 0, 0, 0, 0, 0, 3)
            end
        elseif option == 203 then -- 2nd page menu to choose helper key items to allow player to go off and repeat the mission for the key item
            local finishedACP = player:getCurrentMission(xi.mission.log_id.ACP) == xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN
            local finishedAMK = player:getCurrentMission(xi.mission.log_id.AMK) == xi.mission.id.amk.A_MOOGLE_KUPO_DETAT_FIN
            local finishedASA = player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.A_SHANTOTTO_ASCENSION_FIN

            local arg1 = 0
            for bitPos, entry in pairs(menuMetadata[2]) do
                local hasCompletedExpansion = false
                if entry.expansion == 1 then
                    hasCompletedExpansion = finishedACP
                elseif entry.expansion == 2 then
                    hasCompletedExpansion = finishedAMK
                elseif entry.expansion == 3 then
                    hasCompletedExpansion = finishedASA
                end

                local hasAllRelevantKeyItem = true
                for _, keyItem in pairs(entry.relevantKeyItems) do
                    if not player:hasKeyItem(keyItem) then
                        hasAllRelevantKeyItem = false
                    end
                end

                -- Reminder that "True" here means the option should be excluded from the player's menu
                if not hasCompletedExpansion or hasAllRelevantKeyItem then
                    arg1 = utils.mask.setBit(arg1, bitPos, true)
                end
            end

            player:updateEvent(arg1)
        elseif option >= 200 and option <= 202 then -- Really want? 2nd page items confirmation requires an updateEvent to be called
            player:updateEvent(0)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 323 then
        if option == 1 then
            -- catchall "stop wasting my time" response, triggered via updateEvent(1)
            player:showText(player, ID.text.DRYEYES_1)
        elseif option == 100 then -- Viridian Key
            takeReqKeyItems(player, xi.ki.VIRIDIAN_KEY)
        elseif option == 101 then -- blue coral Key
            takeReqKeyItems(player, xi.ki.BLUE_CORAL_KEY)
        elseif option == 102 then -- black coral Key
            -- shouldn't trigger without the moldy chest, but just in case since the logic above is complex
            local ki = xi.ki.BLACK_CORAL_KEY
            if player:hasKeyItem(menuMetadata[1][ki].reqKeyItems[1]) then
                takeReqKeyItems(player, ki)
            end
        elseif option == 103 then -- Bird Key prereqs to run the bcnms
            npcUtil.giveKeyItem(player, menuMetadata[1][xi.ki.BIRD_KEY].prereqKeyItems)
        elseif option == 104 then -- Bomb Key
            takeReqKeyItems(player, xi.ki.BOMB_KEY)
        elseif option == 105 then -- Bird Key
            takeReqKeyItems(player, xi.ki.BIRD_KEY)
        elseif option >= 300 and option <= 308 then
            local entry = menuMetadata[2][option - 299]
            if player:getSeals(0) < entry.costSeals then
                player:messageSpecial(ID.text.DRYEYES_4)
            elseif player:getGil() < entry.costGil then
                player:messageSpecial(ID.text.DRYEYES_5)
            else
                player:delSeals(entry.costSeals, 0)
                player:delGil(entry.costGil)

                npcUtil.giveKeyItem(player, entry.relevantKeyItems)
            end
        end
    end
end

return entity
