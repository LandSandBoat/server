-----------------------------------
-- Area: Port Jeuno
--  NPC: Shami
-- Orb Seller (BCNM)
-- !pos -14 8 44 246
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local NumberItem = trade:getItemCount()
    local BeastmensSeal = player:getSeals(0)
    local KindredsSeal = player:getSeals(1)
    local KindredsCrest = player:getSeals(2)
    local HighKindredsCrest = player:getSeals(3)
    local SacredKindredsCrest = player:getSeals(4)

    -----------------------------------
    -- Trading Seals/Crests to Shami
    -----------------------------------
    if (trade:hasItemQty(1126, NumberItem) and trade:getItemCount() == NumberItem) then
        player:startEvent(321, 0, BeastmensSeal + NumberItem) -- Giving Shami Beastmen's Seal
        player:addSeals(NumberItem, 0)
        player:tradeComplete(trade)
    elseif (trade:hasItemQty(1127, NumberItem) and trade:getItemCount() == NumberItem) then
        player:startEvent(321, 1, KindredsSeal + NumberItem) -- Giving Shami Kindred's Seal
        player:addSeals(NumberItem, 1)
        player:tradeComplete(trade)
    elseif (trade:hasItemQty(2955, NumberItem) and trade:getItemCount() == NumberItem) then
        player:startEvent(321, 2, KindredsCrest + NumberItem) -- Giving Shami Kindred's Crest
        player:addSeals(NumberItem, 2)
        player:tradeComplete(trade)
    elseif (trade:hasItemQty(2956, NumberItem) and trade:getItemCount() == NumberItem) then
        player:startEvent(321, 3, HighKindredsCrest + NumberItem) -- Giving Shami High Kindred's Crest
        player:addSeals(NumberItem, 3)
        player:tradeComplete(trade)
    elseif (trade:hasItemQty(2957, NumberItem) and trade:getItemCount() == NumberItem) then
        player:startEvent(321, 4, SacredKindredsCrest + NumberItem) -- Giving Shami Sacred Kindred's Crest
        player:addSeals(NumberItem, 4)
        player:tradeComplete(trade)

    -----------------------------------
    -- Trading Cracked BCNM Orbs or checking where you can bring the Orb
    -----------------------------------
    elseif (trade:hasItemQty(1551, 1) and NumberItem == 1) then
        if (player:hasWornItem(1551)) then
            player:startEvent(22) -- Cloudy Orb is Cracked
        else
            player:startEvent(5)  -- Cloudy Orb is ok, List where you can take the orb.
        end
    elseif (trade:hasItemQty(1552, 1) and NumberItem == 1) then
        if (player:hasWornItem(1552)) then
            player:startEvent(22) -- Sky Orb is Cracked
        else
            player:startEvent(9) -- Sky Orb is ok, List where you can take the orb.
        end
    elseif (trade:hasItemQty(1131, 1) and NumberItem == 1) then
        if (player:hasWornItem(1131)) then
            player:startEvent(22) -- Star Orb is Cracked
        else
            player:startEvent(9) -- Star Orb is ok, List where you can take the orb.
        end
    elseif (trade:hasItemQty(1177, 1) and NumberItem == 1) then
        if (player:hasWornItem(1177)) then
            player:startEvent(22) -- Comet Orb is Cracked
        else
            player:startEvent(9) -- Comet Orb is ok, List where you can take the orb.
        end
    elseif (trade:hasItemQty(1130, 1) and NumberItem == 1) then
        if (player:hasWornItem(1130)) then
            player:startEvent(22) -- Moon Orb is Cracked
        else
            player:startEvent(9) -- Moon Orb is ok, List where you can take the orb.
        end

    -----------------------------------
    -- Trading Cracked KSNM Orbs or checking where you can bring the Orb
    -----------------------------------
    elseif (trade:hasItemQty(1180, 1) and NumberItem == 1) then
        if (player:hasWornItem(1180)) then
            player:startEvent(22) -- Atropos Orb is Cracked
        else
            player:startEvent(9) -- Atropos Orb is ok, List where you can take the orb.
        end
    elseif (trade:hasItemQty(1175, 1) and NumberItem == 1) then
        if (player:hasWornItem(1175)) then
            player:startEvent(22) -- Clotho Orb is Cracked
        else
            player:startEvent(9) -- Clotho Orb is ok, List where you can take the orb.
        end
    elseif (trade:hasItemQty(1178, 1) and NumberItem == 1) then
        if (player:hasWornItem(1178)) then
            player:startEvent(22) -- Lachesis Orb is Cracked
        else
            player:startEvent(9) -- Lachesis Orb is ok, List where you can take the orb.
        end
    elseif (trade:hasItemQty(1553, 1) and NumberItem == 1) then
        if (player:hasWornItem(1553)) then
            player:startEvent(22) -- Themis Orb is Cracked
        else
            player:startEvent(11) -- Themis Orb is ok, List where you can take the orb.
        end

    -----------------------------------
    -- Trading Cracked KCNM Orbs or checking where you can bring the Orb
    -----------------------------------
    elseif (trade:hasItemQty(3351, 1) and NumberItem == 1) then
        if (player:hasWornItem(3351)) then
            player:startEvent(22) -- Phobos Orb is Cracked
        else
            player:startEvent(11) -- Phobos Orb is ok, List where you can take the orb.
        end
    elseif (trade:hasItemQty(3352, 1) and NumberItem == 1) then
        if (player:hasWornItem(3352)) then
            player:startEvent(22) -- Deimos Orb is Cracked
        else
            player:startEvent(11) -- Deimos Orb is ok, List where you can take the orb.
        end

    -----------------------------------
    -- Trading Cracked HKCNM Orbs or checking where you can bring the Orb
    -----------------------------------
    elseif (trade:hasItemQty(3454, 1) and NumberItem == 1) then
        if (player:hasWornItem(3454)) then
            player:startEvent(22) -- Zelos Orb is Cracked
        else
            player:startEvent(11) -- Zelos Orb is ok, List where you can take the orb.
        end
    elseif (trade:hasItemQty(3455, 1) and NumberItem == 1) then
        if (player:hasWornItem(3455)) then
            player:startEvent(22) -- Bia Orb is Cracked
        else
            player:startEvent(11) -- Bia Orb is ok, List where you can take the orb.
        end

    -----------------------------------
    -- Trading Cracked SKCNM Orbs or checking where you can bring the Orb
    -----------------------------------
    elseif (trade:hasItemQty(4062, 1) and NumberItem == 1) then
        if (player:hasWornItem(4062)) then
            player:startEvent(22) -- Microcosmic Orb is Cracked
        else
            player:startEvent(11) -- Microcosmic Orb is ok, List where you can take the orb.
        end
    elseif (trade:hasItemQty(4063, 1) and NumberItem == 1) then
        if (player:hasWornItem(4063)) then
            player:startEvent(22) -- Macrocosmic Orb is Cracked
        else
            player:startEvent(11) -- Macrocosmic Orb is ok, List where you can take the orb.
        end

    -- TODO : find cutscene that tells you where you can bring it
    end
end

entity.onTrigger = function(player, npc)
    local oldBeastmensSeal = player:getCharVar("ShamiBeastmensSeal")
    local oldKindredsSeal = player:getCharVar("ShamiKindredsSeal")
    local oldKindredsCrest = player:getCharVar("ShamiKindredsCrest")
    local oldHighKindredsCrest = player:getCharVar("ShamiHighKindredsCrest")
    local oldSacredKindredsCrest = player:getCharVar("ShamiSacredKindredsCrest")
    local BeastmensSeal = player:getSeals(0)
    local KindredsSeal = player:getSeals(1)
    local KindredsCrest = player:getSeals(2)
    local HighKindredsCrest = player:getSeals(3)
    local SacredKindredsCrest = player:getSeals(4)
    local WildcatJeuno = player:getCharVar("WildcatJeuno")

    if (oldBeastmensSeal > 0) then
        player:addSeals(oldBeastmensSeal, 0)
        player:setCharVar("ShamiBeastmensSeal", 0)
    end
    if (oldKindredsSeal > 0) then
        player:addSeals(oldKindredsSeal, 1)
        player:setCharVar("ShamiKindredsSeal", 0)
    end
    if (oldKindredsCrest > 0) then
        player:addSeals(oldKindredsCrest, 2)
        player:setCharVar("ShamiKindredsCrest", 0)
    end
    if (oldHighKindredsCrest > 0) then
        player:addSeals(oldHighKindredsCrest, 3)
        player:setCharVar("ShamiHighKindredsCrest", 0)
    end
    if (oldSacredKindredsCrest > 0) then
        player:addSeals(oldSacredKindredsCrest, 4)
        player:setCharVar("ShamiSacredKindredsCrest", 0)
    end
    -- TODO: player:startEvent(322, 0, 0, 0, 0, 1, 0, 1) -- First time talking to him WITH  beastmen seal in inventory
    if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatJeuno, 17)) then
        player:startEvent(317)
    elseif (BeastmensSeal + KindredsSeal + KindredsCrest + HighKindredsCrest + SacredKindredsCrest == 0) then
        player:startEvent(23) -- Standard dialog ?
    else
        player:startEvent(322, (KindredsSeal * 65536) + BeastmensSeal, (HighKindredsCrest * 65536) + KindredsCrest, SacredKindredsCrest, 0, 1, 0, 0) -- Standard dialog with menu
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local BeastmensSeal = player:getSeals(0)
    local KindredsSeal = player:getSeals(1)
    local KindredsCrest = player:getSeals(2)
    local HighKindredsCrest = player:getSeals(3)
    local SacredKindredsCrest = player:getSeals(4)

    if (csid == 22) then  -- Player gave Shami a cracked orb
        player:tradeComplete()
    elseif (option >= 508 and option ~= 1073741824) then  -- Player has asked to retrieve seals (1073741824 means someone hit escape during cutscene, don't remove this or people will get free seals)
        local takingSealCount = 0
        if ((option + 2)% 256 == 0) then
            if (player:getFreeSlotsCount() >=1) then

                takingSealCount = (option + 2)/256 - 1 -- Every seal requested adds 256 to the option value. The lowest is one seal which sets the option to 510, two seals would be 510 + 256. etc
                player:delSeals(takingSealCount, 0)
                player:addItem(1126, takingSealCount)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 1126)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1126)
            end
        elseif ((option + 1)% 256 == 0) then
            if (player:getFreeSlotsCount() >=1) then

                takingSealCount = (option + 1)/256 - 1 -- Every seal requested adds 256 to the option value. The lowest is one seal which sets the option to 511, two seals would be 511 + 256. etc
                player:delSeals(takingSealCount, 1)
                player:addItem(1127, takingSealCount)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 1127)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1127)
            end
        elseif ((option + 3)% 256 == 0) then
            if (player:getFreeSlotsCount() >=1) then

                takingSealCount = (option + 3)/256 - 1 -- Every seal requested adds 256 to the option value. The lowest is one seal which sets the option to 509, two seals would be 509 + 256. etc
                player:delSeals(takingSealCount, 2)
                player:addItem(2955, takingSealCount)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 2955)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 2955)
            end
        elseif ((option + 4)% 256 == 0) then
            if (player:getFreeSlotsCount() >=1) then

                takingSealCount = (option + 4)/256 - 1 -- Every seal requested adds 256 to the option value. The lowest is one seal which sets the option to 508, two seals would be 508 + 256. etc
                player:delSeals(takingSealCount, 3)
                player:addItem(2956, takingSealCount)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 2956)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 2956)
            end
        elseif ((option + 5)% 256 == 0) then
            if (player:getFreeSlotsCount() >=1) then

                takingSealCount = (option + 5)/256 - 1 -- Every seal requested adds 256 to the option value. The lowest is one seal which sets the option to 508, two seals would be 508 + 256. etc
                player:delSeals(takingSealCount, 4)
                player:addItem(2957, takingSealCount)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 2957)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 2957)
            end
        end

    -----------------------------------
    -- Begin BCNM orb Handout
    -----------------------------------
    elseif (csid == 322) then
        if (option == 1 and BeastmensSeal >= 20) then  -- Player asked for Cloudy orb
            if (player:getFreeSlotsCount() >= 1 and player:hasItem(1551) == false) then
                player:delSeals(20, 0)
                player:addItem(1551)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 1551)
                player:setCharVar("CloudyOrbIsCracked", 0)
            elseif (player:hasItem(1551)) then
                player:addItem(1551)  -- does not add the item but forces it to send the "you cannot carry anymore of these" message.
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1551)
            end
        elseif (option == 2 and BeastmensSeal >= 30) then   -- Player asked for Sky orb
            if (player:getFreeSlotsCount() >= 1 and player:hasItem(1552) == false) then
                player:delSeals(30, 0)
                player:addItem(1552)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 1552)
                player:setCharVar("SkyOrbIsCracked", 0)
            elseif (player:hasItem(1552)) then
                player:addItem(1552)  -- does not add the item but forces it to send the "you cannot carry anymore of these" message.
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1552)
            end
        elseif (option == 3 and BeastmensSeal >= 40) then   -- Player asked for Star orb
            if (player:getFreeSlotsCount() >= 1 and player:hasItem(1131) == false) then
                player:delSeals(40, 0)
                player:addItem(1131)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 1131)
                player:setCharVar("StarOrbIsCracked", 0)
            elseif (player:hasItem(1131) == true) then
                player:addItem(1131)  -- does not add the item but forces it to send the "you cannot carry anymore of these" message.
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1131)
            end
        elseif (option == 4 and BeastmensSeal >= 50) then   -- Player asked for Comet orb
            if (player:getFreeSlotsCount() >= 1 and player:hasItem(1177) == false) then
                player:delSeals(50, 0)
                player:addItem(1177)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 1177)
                player:setCharVar("CometOrbIsCracked", 0)
            elseif (player:hasItem(1177)) then
                player:addItem(1177)  -- does not add the item but forces it to send the "you cannot carry anymore of these" message.
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1177)
            end
        elseif (option == 5 and BeastmensSeal >= 60) then   -- Player asked for Moon orb
            if (player:getFreeSlotsCount() >= 1 and player:hasItem(1130) == false) then
                player:delSeals(60, 0)
                player:addItem(1130)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 1130)
                player:setCharVar("MoonOrbIsCracked", 0)
            elseif (player:hasItem(1130)) then
                player:addItem(1130)  -- does not add the item but forces it to send the "you cannot carry anymore of these" message.
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1130)
            end

        -----------------------------------
        -- Begin KSNM orb Handout
        -----------------------------------
        elseif (option == 6 and KindredsSeal >= 30) then   -- Player asked for Clotho Orb
            if (player:getFreeSlotsCount() >= 1 and player:hasItem(1175) == false) then
                player:delSeals(30, 1)
                player:addItem(1175)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 1175)
                player:setCharVar("ClothoOrbIsCracked", 0)
            elseif (player:hasItem(1175)) then
                player:addItem(1175)  -- does not add the item but forces it to send the "you cannot carry anymore of these" message.
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1175)
            end
        elseif (option == 7 and KindredsSeal >= 30) then   -- Player asked for Lachesis Orb
            if (player:getFreeSlotsCount() >= 1 and player:hasItem(1178) == false) then
                player:delSeals(30, 1)
                player:addItem(1178)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 1178)
                player:setCharVar("LachesisOrbIsCracked", 0)
            elseif (player:hasItem(1178) == true) then
                player:addItem(1178)  -- does not add the item but forces it to send the "you cannot carry anymore of these" message.
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1178)
            end
            elseif (option == 8 and KindredsSeal >= 30) then  -- Player asked for Atropos Orb
            if (player:getFreeSlotsCount() >= 1 and player:hasItem(1180) == false) then
                player:delSeals(30, 1)
                player:addItem(1180)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 1180)
                player:setCharVar("AtroposOrbIsCracked", 0)
            elseif (player:hasItem(1180)) then
                player:addItem(1180)  -- does not add the item but forces it to send the "you cannot carry anymore of these" message.
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1180)
            end
        elseif (option == 9 and KindredsSeal >= 99) then   -- Player asked for Themis Orb
            if (player:getFreeSlotsCount() >= 1 and player:hasItem(1553) == false) then
                player:delSeals(99, 1)
                player:addItem(1553)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 1553)
                player:setCharVar("ThemisOrbIsCracked", 0)
            elseif (player:hasItem(1553)) then
                player:addItem(1553)  -- does not add the item but forces it to send the "you cannot carry anymore of these" message.
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1553)
            end

        -----------------------------------
        -- Begin KCNM orb Handout
        -----------------------------------
        elseif (option == 10 and KindredsCrest >= 30) then   -- Player asked for Phobos Orb
            if (player:getFreeSlotsCount() >= 1 and player:hasItem(3351) == false) then
                player:delSeals(30, 2)
                player:addItem(3351)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 3351)
                player:setCharVar("PhobosOrbIsCracked", 0)
            elseif (player:hasItem(3351)) then
                player:addItem(3351)  -- does not add the item but forces it to send the "you cannot carry anymore of these" message.
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 3351)
            end
        elseif (option == 11 and KindredsCrest >= 50) then   -- Player asked for Deimos Orb
            if (player:getFreeSlotsCount() >= 1 and player:hasItem(3352) == false) then
                player:delSeals(50, 2)
                player:addItem(3352)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 3352)
                player:setCharVar("DeimosOrbIsCracked", 0)
            elseif (player:hasItem(3352)) then
                player:addItem(3352)  -- does not add the item but forces it to send the "you cannot carry anymore of these" message.
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 3352)
            end

        -----------------------------------
        -- Begin HKCNM orb Handout
        -----------------------------------
        elseif (option == 12 and HighKindredsCrest >= 30) then   -- Player asked for Zelos Orb
            if (player:getFreeSlotsCount() >= 1 and player:hasItem(3454) == false) then
                player:delSeals(30, 3)
                player:addItem(3454)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 3454)
                player:setCharVar("ZelosOrbIsCracked", 0)
            elseif (player:hasItem(3454)) then
                player:addItem(3454)  -- does not add the item but forces it to send the "you cannot carry anymore of these" message.
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 3454)
            end
        elseif (option == 13 and HighKindredsCrest >= 50) then   -- Player asked for Bia Orb
            if (player:getFreeSlotsCount() >= 1 and player:hasItem(3455) == false) then
                player:delSeals(50, 3)
                player:addItem(3455)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 3455)
                player:setCharVar("BiaOrbIsCracked", 0)
            elseif (player:hasItem(3455)) then
                player:addItem(3455)  -- does not add the item but forces it to send the "you cannot carry anymore of these" message.
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 3455)
            end

        -----------------------------------
        -- Begin SKCNM orb Handout
        -----------------------------------
        elseif (option == 14 and SacredKindredsCrest >= 10) then   -- Player asked for Microcosmic Orb
            if (player:getFreeSlotsCount() >= 1 and player:hasItem(4062) == false) then
                player:delSeals(10, 4)
                player:addItem(4062)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 4062)
                player:setCharVar("MicrocosmicOrbIsCracked", 0)
            elseif (player:hasItem(4062)) then
                player:addItem(4062)  -- does not add the item but forces it to send the "you cannot carry anymore of these" message.
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4062)
            end
        elseif (option == 15 and SacredKindredsCrest >= 20) then   -- Player asked for Macrocosmic Orb
            if (player:getFreeSlotsCount() >= 1 and player:hasItem(4063) == false) then
                player:delSeals(20, 4)
                player:addItem(4063)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 4063)
                player:setCharVar("MacrocosmicOrbIsCracked", 0)
            elseif (player:hasItem(4063)) then
                player:addItem(4063)  -- does not add the item but forces it to send the "you cannot carry anymore of these" message.
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4063)
            end
        end

    -- TODO : Find cutscene that tells you where you can bring it.
    elseif (csid == 317) then
        player:setCharVar("WildcatJeuno", utils.mask.setBit(player:getCharVar("WildcatJeuno"), 17, true))
    end
end

return entity
