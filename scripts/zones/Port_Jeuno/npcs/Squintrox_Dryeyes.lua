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
local entity = {}

local blueCoralKeyItems =
{
    xi.ki.STURDY_METAL_STRIP,
    xi.ki.PIECE_OF_RUGGED_TREE_BARK,
    xi.ki.SAVORY_LAMB_ROAST,
}

local countersealKeyItems =
{
    xi.ki.AMBER_COUNTERSEAL,
    xi.ki.AZURE_COUNTERSEAL,
    xi.ki.CERULEAN_COUNTERSEAL,
    xi.ki.EMERALD_COUNTERSEAL,
    xi.ki.SCARLET_COUNTERSEAL,
    xi.ki.VIOLET_COUNTERSEAL,
}

local dominasSeals =
{
    xi.ki.DOMINAS_SCARLET_SEAL,
    xi.ki.DOMINAS_CERULEAN_SEAL,
    xi.ki.DOMINAS_EMERALD_SEAL,
    xi.ki.DOMINAS_AMBER_SEAL,
    xi.ki.DOMINAS_VIOLET_SEAL,
    xi.ki.DOMINAS_AZURE_SEAL,
}

local luminousFragments =
{
    xi.ki.LUMINOUS_PURPLE_FRAGMENT,
    xi.ki.LUMINOUS_YELLOW_FRAGMENT,
    xi.ki.LUMINOUS_BLUE_FRAGMENT,
    xi.ki.LUMINOUS_BEIGE_FRAGMENT,
    xi.ki.LUMINOUS_RED_FRAGMENT,
    xi.ki.LUMINOUS_GREEN_FRAGMENT,
}

local orbKeyItems =
{
    xi.ki.ORB_OF_CUPS,
    xi.ki.ORB_OF_COINS,
    xi.ki.ORB_OF_BATONS,
    xi.ki.ORB_OF_SWORDS,
}

local sapCrystals =
{
    xi.ki.FIRE_SAP_CRYSTAL,
    xi.ki.WATER_SAP_CRYSTAL,
    xi.ki.WIND_SAP_CRYSTAL,
    xi.ki.EARTH_SAP_CRYSTAL,
    xi.ki.LIGHTNING_SAP_CRYSTAL,
    xi.ki.ICE_SAP_CRYSTAL,
    xi.ki.LIGHT_SAP_CRYSTAL,
    xi.ki.DARK_SAP_CRYSTAL,
}

local seedspallKeyItems =
{
    xi.ki.SEEDSPALL_ROSEUM,
    xi.ki.SEEDSPALL_CAERULUM,
    xi.ki.SEEDSPALL_VIRIDIS,
}

local tabletsOfHexes =
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
}

local viridianKeyItems =
{
    xi.ki.BOWL_OF_BLAND_GOBLIN_SALAD,
    xi.ki.JUG_OF_GREASY_GOBLIN_JUICE,
    xi.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB,
}

local function getKeyItemCount(player, keyItemTable)
    local numKeyItems = 0

    for _, keyItemId in ipairs(keyItemTable) do
        if player:hasKeyItem(keyItemId) then
            numKeyItems = numKeyItems + 1
        end
    end

    return numKeyItems
end

local function hasKeyItems(player, keyItemTable)
    for _, keyItemId in ipairs(keyItemTable) do
        if not player:hasKeyItem(keyItemId) then
            return false
        end
    end

    return true
end

local function delKeyItems(player, keyItemTable)
    for _, keyItemId in ipairs(keyItemTable) do
        player:delKeyItem(keyItemId)
    end
end

entity.onTrade = function(player, npc, trade)
    local now            = os.time()
    local nextMidnight   = getMidnight()
    local kit            = player:getCharVar('ASA_kit')

    -- Crimson Key: Trade Seedspall's Lux, Luna, Astrum
    if
        npcUtil.tradeHasExactly(trade, { xi.item.SEEDSPALL_LUX, xi.item.SEEDSPALL_LUNA, xi.item.SEEDSPALL_ASTRUM }) and
        player:getCurrentMission(xi.mission.log_id.ACP) == xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN
    then
        if
            not player:hasKeyItem(xi.ki.CRIMSON_KEY) and
            now >= player:getCharVar('LastCrimsonKey')
        then
            player:tradeComplete()
            player:setCharVar('LastCrimsonKey', nextMidnight)
            player:messageSpecial(ID.text.DRYEYES_2)
            npcUtil.giveKeyItem(player, xi.ki.CRIMSON_KEY)
        else
            player:messageSpecial(ID.text.DRYEYES_3, xi.ki.CRIMSON_KEY)
        end
    -- White Coral Key: trade 3 drops - orcish plate armor, quadav backscale, yagudo caulk
    elseif
        npcUtil.tradeHasExactly(trade, { xi.item.ORCISH_PLATE_ARMOR, xi.item.QUADAV_BACKSCALE, xi.item.YAGUDO_CAULK }) and
        player:getCurrentMission(xi.mission.log_id.AMK) == xi.mission.id.amk.A_MOOGLE_KUPO_DETAT_FIN
    then
        if
            not player:hasKeyItem(xi.ki.WHITE_CORAL_KEY) and
            now >= player:getCharVar('LastWhiteCoralKey')
        then
            player:tradeComplete()
            player:addKeyItem(xi.ki.WHITE_CORAL_KEY)
            player:setCharVar('LastWhiteCoralKey', nextMidnight)
            player:messageSpecial(ID.text.DRYEYES_2)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.WHITE_CORAL_KEY)
        else
            player:messageSpecial(ID.text.DRYEYES_3, xi.ki.WHITE_CORAL_KEY)
        end
    -- Moogle Key: trade proper enfeebling kit
    elseif
        kit ~= 0 and
        npcUtil.tradeHasExactly(trade, kit) and
        player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.A_SHANTOTTO_ASCENSION_FIN
    then
        if
            not player:hasKeyItem(xi.ki.MOOGLE_KEY) and
            now >= player:getCharVar('LastMoogleKey')
        then
            player:tradeComplete()
            player:addKeyItem(xi.ki.MOOGLE_KEY)
            player:setCharVar('LastMoogleKey', nextMidnight)
            player:setCharVar('ASA_kit', 0)
            player:messageSpecial(ID.text.DRYEYES_2)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MOOGLE_KEY)
        else
            player:messageSpecial(ID.text.DRYEYES_3, xi.ki.MOOGLE_KEY)
        end
    else
        player:showText(npc, ID.text.GET_LOST)
    end
end

-- [bitPos] = { requiredKeyItem, optRequiredExpireVar, reqLogId, reqMissionId },
local triggerArguments =
{
    [1] = { xi.ki.CRIMSON_KEY,                 nil, xi.mission.log_id.ACP, xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN },
    [2] = { xi.ki.VIRIDIAN_KEY,                nil, xi.mission.log_id.ACP, xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN },
    [3] = { xi.ki.WHITE_CORAL_KEY,             nil, xi.mission.log_id.AMK, xi.mission.id.amk.A_MOOGLE_KUPO_DETAT_FIN    },
    [4] = { xi.ki.BLUE_CORAL_KEY,              nil, xi.mission.log_id.AMK, xi.mission.id.amk.A_MOOGLE_KUPO_DETAT_FIN    },
    [5] = { xi.ki.BLACK_CORAL_KEY,             nil, xi.mission.log_id.AMK, xi.mission.id.amk.A_MOOGLE_KUPO_DETAT_FIN    },
    [6] = { xi.ki.MOOGLE_KEY,      'moogleKeyWait', xi.mission.log_id.ASA, xi.mission.id.asa.A_SHANTOTTO_ASCENSION_FIN  },
    [7] = { xi.ki.BIRD_KEY,          'birdKeyWait', xi.mission.log_id.ASA, xi.mission.id.asa.A_SHANTOTTO_ASCENSION_FIN  },
    [8] = { xi.ki.BOMB_KEY,          'bombKeyWait', xi.mission.log_id.ASA, xi.mission.id.asa.A_SHANTOTTO_ASCENSION_FIN  },
}

entity.onTrigger = function(player, npc)
    local restrictedKeyItems = 0

    -- If any of the below conditions are true, then set a bit to exclude it from the event.
    for bitPos, keyItemInfo in pairs(triggerArguments) do
        if
            player:hasKeyItem(keyItemInfo[1]) or
            player:getCurrentMission(keyItemInfo[3]) < keyItemInfo[4] or
            (keyItemInfo[2] and player:getCharVar(keyItemInfo[2]) ~= 0)
        then
            restrictedKeyItems = utils.mask.setBit(restrictedKeyItems, bitPos, true)
        end
    end

    -- No valid keyitems were found.
    if restrictedKeyItems == 510 then
        player:showText(npc, ID.text.GET_LOST)
    else
        player:startEvent(323, restrictedKeyItems)
    end
end

-- validation of prereqs done here, event option updated based on checks to be used in onEventFinish
entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 323 then
        if option == 100 then -- Viridian Key
            if hasKeyItems(player, viridianKeyItems) then
                player:updateEvent(1)
            else
                player:updateEvent(0)
            end
        elseif option == 101 then -- blue coral Key
            if hasKeyItems(player, blueCoralKeyItems) then
                player:updateEvent(3)
            else
                player:updateEvent(0)
            end
        elseif option == 102 then -- black coral Key
            if not player:hasKeyItem(xi.ki.MOLDY_WORMEATEN_CHEST) then
                local diggingZone = 0
                if diggingZone ~= 0 then
                    player:updateEvent(0, 1, xi.amkHelpers.digSites[diggingZone].eventID)
                else
                    player:messageSpecial(ID.text.GET_LOST)
                end
            else
                player:updateEvent(0)
            end
        elseif option == 103 then -- Moogle Key
            local kit = player:getCharVar('ASA_kit')
            if kit == 0 then
                kit = xi.item.ENFEEBLEMENT_KIT_OF_POISON + math.random(0, 3)
                player:setCharVar('ASA_kit', kit)
            end

            player:updateEvent(kit)
        elseif option == 104 then -- Bird Key
            local completedSeals = getKeyItemCount(player, countersealKeyItems)

            if completedSeals >= 3 then
                player:setLocalVar('ASA_Status', completedSeals)
                player:updateEvent(0, completedSeals, 2)
            else
                player:updateEvent(0, 0, 1)
            end
        elseif option == 105 then -- Bomb Key
            local completedFragments = getKeyItemCount(player, luminousFragments)

            if completedFragments ~= 6 then
                player:updateEvent(0, 0, 0, 0, 0, 0, 3)
            end
        elseif option == 203 then -- 2nd page
            local finishedACP = player:getCurrentMission(xi.mission.log_id.ACP) == xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN
            local finishedAMK = player:getCurrentMission(xi.mission.log_id.AMK) == xi.mission.id.amk.A_MOOGLE_KUPO_DETAT_FIN
            local finishedASA = player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.A_SHANTOTTO_ASCENSION_FIN

            -- Reminder that "True" means the option should be excluded from the player's menu
            local arg1 = (not finishedACP or hasKeyItems(player, seedspallKeyItems) and 2 or 0) +
                (not finishedACP or player:hasKeyItem(xi.ki.MARK_OF_SEED) and 4 or 0) +
                (not finishedACP or player:hasKeyItem(xi.ki.OMNIS_STONE) and 8 or 0) +
                (not finishedAMK or hasKeyItems(player, orbKeyItems) and 16 or 0) +
                (not finishedAMK or player:hasKeyItem(xi.ki.NAVARATNA_TALISMAN) and 32 or 0) +
                (not finishedAMK or player:hasKeyItem(xi.ki.MEGA_BONANZA_KUPON) and 64 or 0) +
                (not finishedASA or player:hasKeyItem(xi.ki.BLACK_BOOK) and 128 or 0) +
                (not finishedASA or hasKeyItems(player, sapCrystals) and 256 or 0) +
                (not finishedASA or hasKeyItems(player, tabletsOfHexes) and 512 or 0)

            player:updateEvent(arg1)
        elseif option == 200 then -- Seedspalls, 4 Orbs, Black Book
            if player:getSeals(0) < 5 then
                player:updateEvent(1)
                player:messageSpecial(ID.text.DRYEYES_4)
            elseif player:getGil() < 500 then
                player:updateEvent(1)
                player:messageSpecial(ID.text.DRYEYES_5)
            else
                player:updateEvent(0)
            end
        elseif option == 201 then -- Mark of Seed, Navaratna Talisman, 8 Sap Crystals
            if player:getSeals(0) < 15 then
                player:updateEvent(1)
                player:messageSpecial(ID.text.DRYEYES_4)
            elseif player:getGil() < 1500 then
                player:updateEvent(1)
                player:messageSpecial(ID.text.DRYEYES_5)
            else
                player:updateEvent(0)
            end
        elseif option == 202 then -- Omnis Stone, Mega Bonanza Kupon, 16 Tablet of Hexes
            if player:getSeals(0) < 20 then
                player:updateEvent(1)
                player:messageSpecial(ID.text.DRYEYES_4)
            elseif player:getGil() < 2000 then
                player:updateEvent(1)
                player:messageSpecial(ID.text.DRYEYES_5)
            else
                player:updateEvent(0)
            end
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local now          = os.time()
    local nextMidnight = getMidnight()
    if csid == 323 then
        if option == 1 then
            player:showText(player, ID.text.DRYEYES_1)
        elseif option == 100 then -- Viridian Key
            if
                not player:hasKeyItem(xi.ki.VIRIDIAN_KEY) and
                now >= player:getCharVar('LastViridianKey')
            then
                delKeyItems(player, viridianKeyItems)

                player:setCharVar('LastViridianKey', nextMidnight)
                player:showText(player, ID.text.DRYEYES_2)
                npcUtil.giveKeyItem(player, xi.ki.VIRIDIAN_KEY)
            else
                player:messageSpecial(ID.text.DRYEYES_3, xi.ki.VIRIDIAN_KEY)
            end
        elseif option == 101 then -- blue coral Key
            if
                not player:hasKeyItem(xi.ki.BLUE_CORAL_KEY) and
                now >= player:getCharVar('LastBlueCoralKey')
            then
                delKeyItems(player, blueCoralKeyItems)

                player:setCharVar('LastBlueCoralKey', nextMidnight)
                player:showText(player, ID.text.DRYEYES_2)

                npcUtil.giveKeyItem(player, xi.ki.BLUE_CORAL_KEY)
            else
                player:messageSpecial(ID.text.DRYEYES_3, xi.ki.BLUE_CORAL_KEY)
            end
        elseif option == 102 then -- black coral Key
            -- shouldn't trigger without the key, but just in case
            if player:hasKeyItem(xi.ki.MOLDY_WORMEATEN_CHEST) then
                if
                    not player:hasKeyItem(xi.ki.BLACK_CORAL_KEY) and
                    now >= player:getCharVar('LastBlackCoralKey')
                then
                    player:addKeyItem(xi.ki.BLACK_CORAL_KEY)
                    player:delKeyItem(xi.ki.MOLDY_WORMEATEN_CHEST)
                    player:setCharVar('LastBlackCoralKey', nextMidnight)
                    player:showText(player, ID.text.DRYEYES_2)
                    player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BLACK_CORAL_KEY)
                else
                    player:messageSpecial(ID.text.DRYEYES_3, xi.ki.BLACK_CORAL_KEY)
                end
            end
        elseif option == 103 then -- Bird Key
            npcUtil.giveKeyItem(player, dominasSeals)
        elseif option == 104 then -- Bomb Key
            if
                not player:hasKeyItem(xi.ki.BOMB_KEY) and
                now >= player:getCharVar('LastBombKey')
            then
                player:setCharVar('LastBombKey', nextMidnight)
                player:messageSpecial(ID.text.DRYEYES_2)
                npcUtil.giveKeyItem(player, xi.ki.BOMB_KEY)
            end

            delKeyItems(player, luminousFragments)
        elseif option == 105 then -- Bird Key
            if
                not player:hasKeyItem(xi.ki.BIRD_KEY) and
                now >= player:getCharVar('LastBirdKey')
            then
                player:setCharVar('LastBirdKey', nextMidnight)
                player:messageSpecial(ID.text.DRYEYES_2)
                npcUtil.giveKeyItem(player, xi.ki.BIRD_KEY)

                delKeyItems(player, dominasSeals)
                delKeyItems(player, countersealKeyItems)
            else
                player:messageSpecial(ID.text.DRYEYES_1)
            end
        elseif option == 300 then -- 3 Seedspalls
            player:delSeals(5, 0)
            player:delGil(500)

            npcUtil.giveKeyItem(player, seedspallKeyItems)
        elseif option == 301 then -- Mark of Seed
            player:delSeals(15, 0)
            player:delGil(1500)

            npcUtil.giveKeyItem(player, xi.ki.MARK_OF_SEED)
        elseif option == 302 then -- Omnis Stone
            player:delSeals(20, 0)
            player:delGil(2000)

            npcUtil.giveKeyItem(player, xi.ki.OMNIS_STONE)
        elseif option == 303 then -- Cardians mana orbs
            player:delSeals(5, 0)
            player:delGil(500)

            npcUtil.giveKeyItem(player, orbKeyItems)
        elseif option == 304 then -- Navaratna Talisman
            player:delSeals(15, 0)
            player:delGil(1500)

            npcUtil.giveKeyItem(player, xi.ki.NAVARATNA_TALISMAN)
        elseif option == 305 then -- Mega Bonanza Kupon
            player:delSeals(20, 0)
            player:delGil(2000)

            npcUtil.giveKeyItem(player, xi.ki.MEGA_BONANZA_KUPON)
        elseif option == 306 then -- Black Book
            player:delSeals(5, 0)
            player:delGil(500)

            npcUtil.giveKeyItem(player, xi.ki.BLACK_BOOK)
        elseif option == 307 then -- Elemental Saps
            player:delSeals(15, 0)
            player:delGil(1500)

            npcUtil.giveKeyItem(player, sapCrystals)
        elseif option == 308 then -- Tablet of Hexes KIs
            player:delSeals(20, 0)
            player:delGil(2000)

            npcUtil.giveKeyItem(player, tabletsOfHexes)
        end
    end
end


return entity
