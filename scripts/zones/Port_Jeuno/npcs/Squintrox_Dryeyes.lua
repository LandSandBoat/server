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

entity.onTrade = function(player, npc, trade)
    local now                   = os.time()
    local nextMidnight          = getMidnight()
    local count                 = trade:getItemCount()
    local finishedACP           = player:getCurrentMission(xi.mission.log_id.ACP) == xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN
    local finishedAMK           = player:getCurrentMission(xi.mission.log_id.AMK) == xi.mission.id.amk.A_MOOGLE_KUPO_DETAT_FIN
    local finishedASA           = player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.A_SHANTOTTO_ASCENSION_FIN
    local hasMoogleKey          = player:hasKeyItem(xi.ki.MOOGLE_KEY)
    local kit                   = player:getCharVar('ASA_kit')
    local hasMoogleItems        = kit ~= 0 and
                                    trade:hasItemQty(kit, 1) and
                                    count == 1
    local hasCrimsonItems       = trade:hasItemQty(xi.item.SEEDSPALL_LUX, 1)        and
                                    trade:hasItemQty(xi.item.SEEDSPALL_LUNA, 1)     and
                                    trade:hasItemQty(xi.item.SEEDSPALL_ASTRUM, 1)   and
                                    count == 3
    local hasWhiteCoralItems    = trade:hasItemQty(xi.item.ORCISH_PLATE_ARMOR, 1)   and
                                    trade:hasItemQty(xi.item.QUADAV_BACKSCALE, 1)   and
                                    trade:hasItemQty(xi.item.YAGUDO_CAULK, 1)       and
                                    count == 3

    -- Crimson Key: Trade Seedspall's Lux, Luna, Astrum
    if
        hasCrimsonItems and
        finishedACP
    then
        local ki = xi.ki.CRIMSON_KEY
        if
            not player:hasKeyItem(ki) and
            now >= player:getCharVar('LastCrimsonKey')
        then
            player:tradeComplete()
            player:addKeyItem(ki)
            player:setCharVar('LastCrimsonKey', nextMidnight)
            player:messageSpecial(ID.text.DRYEYES_2)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, ki)
        else
            player:messageSpecial(ID.text.DRYEYES_3, ki)
        end
    -- White Coral Key: trade 3 drops - orcish plate armor, quadav backscale, yagudo caulk
    elseif
        hasWhiteCoralItems and
        finishedAMK
    then
        local ki = xi.ki.WHITE_CORAL_KEY
        if
            not player:hasKeyItem(ki) and
            now >= player:getCharVar('LastWhiteCoralKey')
        then
            player:tradeComplete()
            player:addKeyItem(ki)
            player:setCharVar('LastWhiteCoralKey', nextMidnight)
            player:messageSpecial(ID.text.DRYEYES_2)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, ki)
        else
            player:messageSpecial(ID.text.DRYEYES_3, ki)
        end
    -- Moogle Key: trade proper enfeebling kit
    elseif
        hasEnfeebKit and
        finishedASA
    then
        local ki = xi.ki.MOOGLE_KEY
        if
            not player:hasKeyItem(ki) and
            now >= player:getCharVar('LastMoogleKey')
        then
            player:tradeComplete()
            player:addKeyItem(ki)
            player:setCharVar('LastMoogleKey', nextMidnight)
            player:setCharVar('ASA_kit', 0)
            player:messageSpecial(ID.text.DRYEYES_2)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, ki)
        else
            player:messageSpecial(ID.text.DRYEYES_3, ki)
        end
    else
        player:showText(npc, ID.text.GET_LOST)
    end
end

entity.onTrigger = function(player, npc)
    local now          = os.time()
    local nextMidnight = getMidnight()
    local finishedACP  = player:getCurrentMission(xi.mission.log_id.ACP) == xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN
    local finishedAMK  = player:getCurrentMission(xi.mission.log_id.AMK) == xi.mission.id.amk.A_MOOGLE_KUPO_DETAT_FIN
    local finishedASA  = player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.A_SHANTOTTO_ASCENSION_FIN

    -- Reminder that "True" means the option should be excluded from the player's menu
    local arg1 =
        ((finishedACP                                              or
            player:hasKeyItem(xi.ki.CRIMSON_KEY))                  and
                2 or 0) +
        ((finishedACP                                              or
            player:hasKeyItem(xi.ki.VIRIDIAN_KEY))                 and
                4 or 0) +
        ((finishedAMK                                              or
            player:hasKeyItem(xi.ki.WHITE_CORAL_KEY))              and
                8 or 0) +
        ((finishedAMK                                              or
            player:hasKeyItem(xi.ki.BLUE_CORAL_KEY))               and
                16 or 0) +
        ((finishedAMK                                              or
            player:hasKeyItem(xi.ki.BLACK_CORAL_KEY))              and
                32 or 0) +
        ((finishedASA                                              or
            player:hasKeyItem(xi.ki.MOOGLE_KEY)                    and
            now >= player:getCharVar('LastMoogleKey'))             and
                64 or 0) +
        ((finishedASA                                              or
            player:hasKeyItem(xi.ki.BIRD_KEY)                      and
            now >= player:getCharVar('LastBirdKey'))               and
                128 or 0) +
        ((finishedASA                                              or
            player:hasKeyItem(xi.ki.BOMB_KEY)                      and
            now >= player:getCharVar('LastBombKey'))               and
                256 or 0)

    -- matches none of the above
    if arg1 == 510 then
        player:showText(npc, ID.text.GET_LOST)
    else
        player:startEvent(323, arg1)
    end
end

-- validation of prereqs done here, event option updated based on checks to be used in onEventFinish
entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 323 then
        if option == 100 then -- Viridian Key
            if
                player:hasKeyItem(xi.ki.BOWL_OF_BLAND_GOBLIN_SALAD) and
                player:hasKeyItem(xi.ki.JUG_OF_GREASY_GOBLIN_JUICE) and
                player:hasKeyItem(xi.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB)
            then
                player:updateEvent(1)
            else
                player:updateEvent(0)
            end
        elseif option == 101 then -- blue coral Key
            if
                player:hasKeyItem(xi.ki.STURDY_METAL_STRIP) and
                player:hasKeyItem(xi.ki.PIECE_OF_RUGGED_TREE_BARK) and
                player:hasKeyItem(xi.ki.SAVORY_LAMB_ROAST)
            then
                player:updateEvent(3)
            else
                player:updateEvent(0)
            end
        elseif option == 102 then -- black coral Key
            if
                not player:hasKeyItem(xi.ki.MOLDY_WORMEATEN_CHEST)
            then
                local diggingZone = 0
                if diggingZone ~= 0 then
                    player:updateEvent(0, 1, amkHelpers.digSites[diggingZone].eventID)
                else
                    player:messageSpecial(ID.text.GET_LOST)
                end
            else
                player:updateEvent(0)
            end
        elseif option == 103 then -- Moogle Key
            local kit = player:getCharVar('ASA_kit')
            if kit == 0 then
                kit = xi.item.ENFEEBLEMENT_KIT_OF_POISON + math.random(0,3)
                player:setCharVar('ASA_kit', kit)
            end
            player:updateEvent(kit)
        elseif option == 104 then -- Bird Key
            local completedSeals =
            (player:hasKeyItem(xi.ki.AMBER_COUNTERSEAL)    and 1 or 0) +
            (player:hasKeyItem(xi.ki.AZURE_COUNTERSEAL)    and 1 or 0) +
            (player:hasKeyItem(xi.ki.CERULEAN_COUNTERSEAL) and 1 or 0) +
            (player:hasKeyItem(xi.ki.EMERALD_COUNTERSEAL)  and 1 or 0) +
            (player:hasKeyItem(xi.ki.SCARLET_COUNTERSEAL)  and 1 or 0) +
            (player:hasKeyItem(xi.ki.VIOLET_COUNTERSEAL)   and 1 or 0)

            if completedSeals >= 3 then
                player:setLocalVar('ASA_Status', completedSeals)
                player:updateEvent(0, completedSeals, 2)
            else
                player:updateEvent(0, 0, 1)
            end
        elseif option == 105 then -- Bomb Key
            local completedFragments =
                (player:hasKeyItem(xi.ki.LUMINOUS_PURPLE_FRAGMENT) and 1 or 0) +
                (player:hasKeyItem(xi.ki.LUMINOUS_YELLOW_FRAGMENT) and 1 or 0) +
                (player:hasKeyItem(xi.ki.LUMINOUS_BLUE_FRAGMENT)   and 1 or 0) +
                (player:hasKeyItem(xi.ki.LUMINOUS_BEIGE_FRAGMENT)  and 1 or 0) +
                (player:hasKeyItem(xi.ki.LUMINOUS_RED_FRAGMENT)    and 1 or 0) +
                (player:hasKeyItem(xi.ki.LUMINOUS_GREEN_FRAGMENT)  and 1 or 0)

            if completedFragments ~= 6 then
                player:updateEvent(0, 0, 0, 0, 0, 0, 3)
            end
        elseif option == 203 then -- 2nd page
            local finishedACP = player:getCurrentMission(xi.mission.log_id.ACP) == xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN
            local finishedAMK = player:getCurrentMission(xi.mission.log_id.AMK) == xi.mission.id.amk.A_MOOGLE_KUPO_DETAT_FIN
            local finishedASA = player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.A_SHANTOTTO_ASCENSION_FIN

            -- Reminder that "True" means the option should be excluded from the player's menu
            local arg1 = (not finishedACP                                                or
                             (player:hasKeyItem(xi.ki.SEEDSPALL_ROSEUM)                 and
                             player:hasKeyItem(xi.ki.SEEDSPALL_CAERULUM)                and
                             player:hasKeyItem(xi.ki.SEEDSPALL_VIRIDIS))                and
                                 2 or 0) +
                         (not finishedACP                                                or
                             (player:hasKeyItem(xi.ki.MARK_OF_SEED))                    and
                                 4 or 0) +
                         (not finishedACP                                                or
                             (player:hasKeyItem(xi.ki.OMNIS_STONE))                     and
                                 8 or 0) +
                         (not finishedAMK                                                or
                             (player:hasKeyItem(xi.ki.ORB_OF_CUPS)                      and
                             player:hasKeyItem(xi.ki.ORB_OF_COINS)                      and
                             player:hasKeyItem(xi.ki.ORB_OF_BATONS)                     and
                             player:hasKeyItem(xi.ki.ORB_OF_SWORDS))                    and
                                 16 or 0) +
                         (not finishedAMK                                                or
                             (player:hasKeyItem(xi.ki.NAVARATNA_TALISMAN))              and
                                 32 or 0) +
                         (not finishedAMK                                                or
                             (player:hasKeyItem(xi.ki.MEGA_BONANZA_KUPON))              and
                                 64 or 0) +
                         (not finishedASA                                                or
                             (player:hasKeyItem(xi.ki.BLACK_BOOK))                      and
                                 128 or 0) +
                         (not finishedASA                                                or
                             (player:hasKeyItem(xi.ki.WATER_SAP_CRYSTAL)                and
                             player:hasKeyItem(xi.ki.EARTH_SAP_CRYSTAL)                 and
                             player:hasKeyItem(xi.ki.ICE_SAP_CRYSTAL)                   and
                             player:hasKeyItem(xi.ki.WIND_SAP_CRYSTAL)                  and
                             player:hasKeyItem(xi.ki.LIGHTNING_SAP_CRYSTAL)             and
                             player:hasKeyItem(xi.ki.FIRE_SAP_CRYSTAL)                  and
                             player:hasKeyItem(xi.ki.LIGHT_SAP_CRYSTAL)                 and
                             player:hasKeyItem(xi.ki.DARK_SAP_CRYSTAL))                 and
                                 256 or 0) +
                         (not finishedASA                                                or
                             (player:hasKeyItem(xi.ki.TABLET_OF_HEXES_GREED)            and
                             player:hasKeyItem(xi.ki.TABLET_OF_HEXES_ENVY)              and
                             player:hasKeyItem(xi.ki.TABLET_OF_HEXES_MALICE)            and
                             player:hasKeyItem(xi.ki.TABLET_OF_HEXES_DECEIT)            and
                             player:hasKeyItem(xi.ki.TABLET_OF_HEXES_PRIDE)             and
                             player:hasKeyItem(xi.ki.TABLET_OF_HEXES_BALE)              and
                             player:hasKeyItem(xi.ki.TABLET_OF_HEXES_DESPAIR)           and
                             player:hasKeyItem(xi.ki.TABLET_OF_HEXES_REGRET)            and
                             player:hasKeyItem(xi.ki.TABLET_OF_HEXES_RAGE)              and
                             player:hasKeyItem(xi.ki.TABLET_OF_HEXES_AGONY)             and
                             player:hasKeyItem(xi.ki.TABLET_OF_HEXES_DOLOR)             and
                             player:hasKeyItem(xi.ki.TABLET_OF_HEXES_RANCOR)            and
                             player:hasKeyItem(xi.ki.TABLET_OF_HEXES_STRIFE)            and
                             player:hasKeyItem(xi.ki.TABLET_OF_HEXES_PENURY)            and
                             player:hasKeyItem(xi.ki.TABLET_OF_HEXES_BLIGHT)            and
                             player:hasKeyItem(xi.ki.TABLET_OF_HEXES_DEATH))            and
                                 512 or 0)

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
                now >= player:getCharVar('LastViridianKey') then
                player:addKeyItem(xi.ki.VIRIDIAN_KEY)
                player:delKeyItem(xi.ki.BOWL_OF_BLAND_GOBLIN_SALAD)
                player:delKeyItem(xi.ki.JUG_OF_GREASY_GOBLIN_JUICE)
                player:delKeyItem(xi.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB)
                player:setCharVar('LastViridianKey', nextMidnight)
                player:showText(player, ID.text.DRYEYES_2)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.VIRIDIAN_KEY)
            else
                player:messageSpecial(ID.text.DRYEYES_3, xi.ki.VIRIDIAN_KEY)
            end
        elseif option == 101 then -- blue coral Key
            local keyItem = xi.ki.BLUE_CORAL_KEY
            if
                not player:hasKeyItem(keyItem) and
                now >= player:getCharVar('LastBlueCoralKey')
            then
                player:addKeyItem(keyItem)
                player:delKeyItem(xi.ki.STURDY_METAL_STRIP)
                player:delKeyItem(xi.ki.PIECE_OF_RUGGED_TREE_BARK)
                player:delKeyItem(xi.ki.SAVORY_LAMB_ROAST)
                player:setCharVar('LastBlueCoralKey', nextMidnight)
                player:showText(player, ID.text.DRYEYES_2)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, keyItem)
            else
                player:messageSpecial(ID.text.DRYEYES_3, keyItem)
            end
        elseif option == 102 then -- black coral Key
            -- shouldn't trigger without the key, but just in case
            if player:hasKeyItem(xi.ki.MOLDY_WORMEATEN_CHEST) then
                local keyItem = xi.ki.BLACK_CORAL_KEY
                if
                    not player:hasKeyItem(keyItem) and
                    now >= player:getCharVar('LastBlackCoralKey')
                then
                    player:addKeyItem(keyItem)
                    player:delKeyItem(xi.ki.MOLDY_WORMEATEN_CHEST)
                    player:setCharVar('LastBlackCoralKey', nextMidnight)
                    player:showText(player, ID.text.DRYEYES_2)
                    player:messageSpecial(ID.text.KEYITEM_OBTAINED, keyItem)
                else
                    player:messageSpecial(ID.text.DRYEYES_3, keyItem)
                end
            end
        elseif option == 103 then -- Bird Key
            npcUtil.giveKeyItem(player, {
                xi.ki.DOMINAS_SCARLET_SEAL,
                xi.ki.DOMINAS_CERULEAN_SEAL,
                xi.ki.DOMINAS_EMERALD_SEAL,
                xi.ki.DOMINAS_AMBER_SEAL,
                xi.ki.DOMINAS_VIOLET_SEAL,
                xi.ki.DOMINAS_AZURE_SEAL
            })
        elseif option == 104 then -- Bomb Key
            if
                not player:hasKeyItem(xi.ki.BOMB_KEY) and
                now >= player:getCharVar('LastBombKey')
            then
                player:addKeyItem(xi.ki.BOMB_KEY)
                player:setCharVar('LastBombKey', nextMidnight)
                player:messageSpecial(ID.text.DRYEYES_2)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BOMB_KEY)
            end

            player:delKeyItem(xi.ki.LUMINOUS_PURPLE_FRAGMENT)
            player:delKeyItem(xi.ki.LUMINOUS_YELLOW_FRAGMENT)
            player:delKeyItem(xi.ki.LUMINOUS_BLUE_FRAGMENT)
            player:delKeyItem(xi.ki.LUMINOUS_BEIGE_FRAGMENT)
            player:delKeyItem(xi.ki.LUMINOUS_RED_FRAGMENT)
            player:delKeyItem(xi.ki.LUMINOUS_GREEN_FRAGMENT)
        elseif option == 105 then -- Bird Key
            if
                not player:hasKeyItem(xi.ki.BIRD_KEY) and
                now >= player:getCharVar('LastBirdKey')
            then
                player:addKeyItem(xi.ki.BIRD_KEY)
                player:setCharVar('LastBirdKey', nextMidnight)
                player:messageSpecial(ID.text.DRYEYES_2)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BIRD_KEY)

                player:delKeyItem(xi.ki.DOMINAS_SCARLET_SEAL)
                player:delKeyItem(xi.ki.DOMINAS_CERULEAN_SEAL)
                player:delKeyItem(xi.ki.DOMINAS_EMERALD_SEAL)
                player:delKeyItem(xi.ki.DOMINAS_AMBER_SEAL)
                player:delKeyItem(xi.ki.DOMINAS_VIOLET_SEAL)
                player:delKeyItem(xi.ki.DOMINAS_AZURE_SEAL)

                player:delKeyItem(xi.ki.SCARLET_COUNTERSEAL)
                player:delKeyItem(xi.ki.CERULEAN_COUNTERSEAL)
                player:delKeyItem(xi.ki.EMERALD_COUNTERSEAL)
                player:delKeyItem(xi.ki.AMBER_COUNTERSEAL)
                player:delKeyItem(xi.ki.VIOLET_COUNTERSEAL)
                player:delKeyItem(xi.ki.AZURE_COUNTERSEAL)
            else
                player:messageSpecial(ID.text.DRYEYES_1)
            end
        elseif option == 300 then -- 3 Seedspalls
            player:delSeals(5, 0)
            player:delGil(500)

            if not player:hasKeyItem(xi.ki.SEEDSPALL_ROSEUM) then
                player:addKeyItem(xi.ki.SEEDSPALL_ROSEUM)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SEEDSPALL_ROSEUM)
            end
            if not player:hasKeyItem(xi.ki.SEEDSPALL_CAERULUM) then
                player:addKeyItem(xi.ki.SEEDSPALL_CAERULUM)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SEEDSPALL_CAERULUM)
            end
            if not player:hasKeyItem(xi.ki.SEEDSPALL_VIRIDIS) then
                player:addKeyItem(xi.ki.SEEDSPALL_VIRIDIS)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SEEDSPALL_VIRIDIS)
            end
        elseif option == 301 then -- Mark of Seed
            player:delSeals(15, 0)
            player:delGil(1500)

            if not player:hasKeyItem(xi.ki.MARK_OF_SEED) then
                player:addKeyItem(xi.ki.MARK_OF_SEED)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MARK_OF_SEED)
            end
        elseif option == 302 then -- Omnis Stone
            player:delSeals(20, 0)
            player:delGil(2000)

            if not player:hasKeyItem(xi.ki.OMNIS_STONE) then
                player:addKeyItem(xi.ki.OMNIS_STONE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.OMNIS_STONE)
            end
        elseif option == 303 then -- Cardians mana orbs
            player:delSeals(5, 0)
            player:delGil(500)

            for i, ki in pairs({
                    xi.ki.ORB_OF_CUPS,
                    xi.ki.ORB_OF_COINS,
                    xi.ki.ORB_OF_BATONS,
                    xi.ki.ORB_OF_SWORDS,
                }) do
                if not player:hasKeyItem(ki) then
                    player:addKeyItem(ki)
                    player:messageSpecial(ID.text.KEYITEM_OBTAINED, ki)
                end
            end
        elseif option == 304 then -- Navaratna Talisman
            player:delSeals(15, 0)
            player:delGil(1500)

            local ki = xi.ki.NAVARATNA_TALISMAN
            if not player:hasKeyItem(ki) then
                player:addKeyItem(ki)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, ki)
            end
        elseif option == 305 then -- Mega Bonanza Kupon
            player:delSeals(20, 0)
            player:delGil(2000)

            local ki = xi.ki.MEGA_BONANZA_KUPON
            if not player:hasKeyItem(ki) then
                player:addKeyItem(ki)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, ki)
            end
        elseif option == 306 then -- Black Book
            player:delSeals(5, 0)
            player:delGil(500)

            local ki = xi.ki.BLACK_BOOK
            if not player:hasKeyItem(ki) then
                player:addKeyItem(ki)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, ki)
            end
        elseif option == 307 then -- Elemental Saps
            player:delSeals(15, 0)
            player:delGil(1500)

            for i, ki in pairs({
                    xi.ki.FIRE_SAP_CRYSTAL,
                    xi.ki.WATER_SAP_CRYSTAL,
                    xi.ki.WIND_SAP_CRYSTAL,
                    xi.ki.EARTH_SAP_CRYSTAL,
                    xi.ki.LIGHTNING_SAP_CRYSTAL,
                    xi.ki.ICE_SAP_CRYSTAL,
                    xi.ki.LIGHT_SAP_CRYSTAL,
                    xi.ki.DARK_SAP_CRYSTAL,
                }) do
                if not player:hasKeyItem(ki) then
                    player:addKeyItem(ki)
                    player:messageSpecial(ID.text.KEYITEM_OBTAINED, ki)
                end
            end
        elseif option == 308 then -- Tablet of Hexes KIs
            player:delSeals(20, 0)
            player:delGil(2000)

            for i, ki in pairs({
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
                }) do
                if not player:hasKeyItem(ki) then
                    player:addKeyItem(ki)
                    player:messageSpecial(ID.text.KEYITEM_OBTAINED, ki)
                end
            end
        end
    end
end


return entity
