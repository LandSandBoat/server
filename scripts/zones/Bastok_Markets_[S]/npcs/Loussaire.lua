-----------------------------------
-- Area: Bastok Markets (S) (G-10)
--  NPC: Loussaire
-- !pos -248.677 -8.523 -125.734 87
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local mLvl          = player:getMainLvl()
    local mJob          = player:getMainJob()
    local downwardHelix = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.DOWNWARD_HELIX)

    -- Controls the progress of each step. Everything will start at 1 and end at 4 (complete).
    local loafersQuestProgress = player:getCharVar("AF_SCH_BOOTS")
    local pantsQuestProgress   = player:getCharVar("AF_SCH_PANTS")
    local gownQuestProgress    = player:getCharVar("AF_SCH_BODY")
    local AFProgress           = player:getCharVar("AF_Loussaire")

    if (player:getCharVar("AF_SCH_COMPLETE") == 0) then

        -- They have a piece in progress.
        if ((loafersQuestProgress == 1 or pantsQuestProgress == 1 or gownQuestProgress == 1 or
             loafersQuestProgress == 2 or pantsQuestProgress == 2 or gownQuestProgress == 2) and AFProgress > 0) then

            local itemid   = 14580 -- Scholar's Gown
            local FristKI  = tpz.ki.PEISTE_DUNG
            local SecondKI = tpz.ki.SAMPLE_OF_GRAUBERG_CHERT

            if (loafersQuestProgress == 1 or loafersQuestProgress == 2) then
                itemid   = 15748 -- Scholar's Loafers
                FristKI  = tpz.ki.RAFFLESIA_DREAMSPIT
                SecondKI = tpz.ki.DROGAROGAN_BONEMEAL

            elseif (pantsQuestProgress == 1 or pantsQuestProgress == 2) then
                itemid   = 16311 -- Scholar's Pants
                FristKI  = tpz.ki.SLUG_MUCUS
                SecondKI = tpz.ki.DJINN_EMBER
            end

            player:startEvent(50, itemid, FristKI, SecondKI)

        -- Nothing in progress and meet the starting requirements.
        elseif (downwardHelix == QUEST_COMPLETED and mJob == tpz.job.SCH and mLvl >= AF2_QUEST_LEVEL) then

             -- If a player has completed any of the paths, it will be a different cutscene.
            local counter = 0
            if (loafersQuestProgress == 4) then
                counter = counter + 1
            end
            if (pantsQuestProgress == 4) then
                counter = counter + 1
            end
            if (gownQuestProgress == 4) then
                counter = counter + 1
            end

            -- Controls which CS to give the player based on completed paths.
            local cutsceneID = 51
            if (counter == 1) then
                cutsceneID = 52
            elseif (counter == 2) then
                cutsceneID = 54
            end

            -- Check Key Items and give them their dynamic event.
            if (player:hasKeyItem(tpz.ki.RAFFLESIA_DREAMSPIT) and player:hasKeyItem(tpz.ki.DROGAROGAN_BONEMEAL) and loafersQuestProgress == 3) then -- Scholar's Loafers
                player:startEvent(cutsceneID, 15748)
                player:setLocalVar("item", 15748)
                player:setLocalVar("firstKI", tpz.ki.RAFFLESIA_DREAMSPIT)
                player:setLocalVar("secondKI", tpz.ki.DROGAROGAN_BONEMEAL)

            elseif (player:hasKeyItem(tpz.ki.SLUG_MUCUS) and player:hasKeyItem(tpz.ki.DJINN_EMBER) and pantsQuestProgress == 3) then -- Scholar's Pants
                player:startEvent(cutsceneID, 16311)
                player:setLocalVar("item", 16311)
                player:setLocalVar("firstKI", tpz.ki.SLUG_MUCUS)
                player:setLocalVar("secondKI", tpz.ki.DJINN_EMBER)

            elseif (player:hasKeyItem(tpz.ki.PEISTE_DUNG) and player:hasKeyItem(tpz.ki.SAMPLE_OF_GRAUBERG_CHERT) and gownQuestProgress == 3) then -- Scholar's Gown
                player:startEvent(cutsceneID, 14580)
                player:setLocalVar("item", 14580)
                player:setLocalVar("firstKI", tpz.ki.PEISTE_DUNG)
                player:setLocalVar("secondKI", tpz.ki.SAMPLE_OF_GRAUBERG_CHERT)

            -- Show them the normal Menu to select from.
            else

                local params = 0 -- Controls which items to hide (Binary - 0XXX)

                -- Scholar's Loafers
                if (loafersQuestProgress ~= 0) then
                    params = 1
                end

                -- Scholar's Pants
                if (pantsQuestProgress ~= 0) then
                    params = params + 2
                end

                -- Scholar's Gown
                if (gownQuestProgress ~= 0) then
                    params = params + 4
                end

                if (params < 8) then
                    if (AFProgress > 0) then
                        player:startEvent(53, params) -- Shorter CS than 49
                    else
                        player:startEvent(49, params)
                    end
                end
            end

        else
            player:startEvent(48) -- Default message
        end
    end
end

function onEventUpdate(player, csid, option)

    if (csid == 49 or csid == 53) then
        -- Display Loafers
        if (option == 2) then
            player:updateEvent(option, tpz.ki.RAFFLESIA_DREAMSPIT, tpz.ki.DROGAROGAN_BONEMEAL, 0, 0, 0, 0, 0)

        -- Display Pants
        elseif (option == 4) then
            player:updateEvent(option, tpz.ki.SLUG_MUCUS, tpz.ki.DJINN_EMBER, 0, 0, 0, 0, 0)

        -- Display Gown
        elseif (option == 6) then
            player:updateEvent(option, tpz.ki.PEISTE_DUNG, tpz.ki.SAMPLE_OF_GRAUBERG_CHERT, 0, 0, 0, 0, 0)

        -- Confirm Loafers
        elseif (option == 1) then
            player:setCharVar("AF_SCH_BOOTS", 1)

        -- Confirm Pants
        elseif (option == 3) then
            player:setCharVar("AF_SCH_PANTS", 1)

        -- Confirm Gown
        elseif (option == 5) then
            player:setCharVar("AF_SCH_BODY", 1)

        elseif (option > 7) then
            player:PrintToPlayer("There was an error in the CS. Inform your Server Admin/GM.")
        end
    end
end

function onEventFinish(player, csid, option)

    if (csid == 49 and option == 0) then
        player:setCharVar("AF_Loussaire", 1)

    elseif (csid == 51 or csid == 52 or csid == 54) then

        local itemid   = player:getLocalVar("item")
        local firstKI  = player:getLocalVar("firstKI")
        local secondKI = player:getLocalVar("secondKI")

        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, itemid)

        else
            -- Remove LocalVars
            player:setLocalVar("item", 0)
            player:setLocalVar("firstKI", 0)
            player:setLocalVar("secondKI", 0)

            -- Flag the path complete
            if (itemid == 15748) then
                player:setCharVar("AF_SCH_BOOTS", 4)
            elseif (itemid == 16311) then
                player:setCharVar("AF_SCH_PANTS", 4)
            else
                player:setCharVar("AF_SCH_BODY", 4)
            end

            local AFProgress = player:getCharVar("AF_Loussaire")
            if (AFProgress == 3) then

                -- They are done. Clean-up
                player:setCharVar("AF_SCH_BOOTS",    0)
                player:setCharVar("AF_SCH_PANTS",    0)
                player:setCharVar("AF_SCH_BODY",     0)
                player:setCharVar("AF_Loussaire",    0)
                player:setCharVar("AF_SCH_COMPLETE", 1)

            else
                player:setCharVar("AF_Loussaire", AFProgress + 1) -- They got an item. Add it!
            end

            player:delKeyItem(firstKI)
            player:delKeyItem(secondKI)
            player:messageSpecial(ID.text.ITEM_OBTAINED, itemid)
            player:addItem(itemid)
        end
    end
end
