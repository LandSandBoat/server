-----------------------------------
-- Area: Bastok Markets (S) (G-10)
--  NPC: Loussaire
-- !pos -248.677 -8.523 -125.734 87
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- TODO: Reduce complexity
-- Disable cyclomatic complexity check for this function:
-- luacheck: ignore 561
entity.onTrigger = function(player, npc)
    local mLvl          = player:getMainLvl()
    local mJob          = player:getMainJob()
    local downwardHelix = player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.DOWNWARD_HELIX)

    -- Controls the progress of each step. Everything will start at 1 and end at 4 (complete).
    local loafersQuestProgress = player:getCharVar('AF_SCH_BOOTS')
    local pantsQuestProgress   = player:getCharVar('AF_SCH_PANTS')
    local gownQuestProgress    = player:getCharVar('AF_SCH_BODY')
    local afProgress           = player:getCharVar('AF_Loussaire')

    if player:getCharVar('AF_SCH_COMPLETE') == 0 then

        -- They have a piece in progress.
        if
            afProgress > 0 and
            (
                loafersQuestProgress == 1 or
                pantsQuestProgress == 1 or
                gownQuestProgress == 1 or
                loafersQuestProgress == 2 or
                pantsQuestProgress == 2 or
                gownQuestProgress == 2
            )
        then
            local itemid   = xi.item.SCHOLARS_GOWN
            local firstKI  = xi.ki.PEISTE_DUNG
            local secondKI = xi.ki.SAMPLE_OF_GRAUBERG_CHERT

            if loafersQuestProgress == 1 or loafersQuestProgress == 2 then
                itemid   = xi.item.SCHOLARS_LOAFERS
                firstKI  = xi.ki.RAFFLESIA_DREAMSPIT
                secondKI = xi.ki.DROGAROGAN_BONEMEAL

            elseif pantsQuestProgress == 1 or pantsQuestProgress == 2 then
                itemid   = xi.item.SCHOLARS_PANTS
                firstKI  = xi.ki.SLUG_MUCUS
                secondKI = xi.ki.DJINN_EMBER
            end

            player:startEvent(50, itemid, firstKI, secondKI)

        -- Nothing in progress and meet the starting requirements.
        elseif
            downwardHelix == xi.questStatus.QUEST_COMPLETED and
            mJob == xi.job.SCH and
            mLvl >= xi.settings.main.AF2_QUEST_LEVEL
        then
            -- If a player has completed any of the paths, it will be a different cutscene.
            local counter = 0
            if loafersQuestProgress == 4 then
                counter = counter + 1
            end

            if pantsQuestProgress == 4 then
                counter = counter + 1
            end

            if gownQuestProgress == 4 then
                counter = counter + 1
            end

            -- Controls which CS to give the player based on completed paths.
            local cutsceneID = 51
            if counter == 1 then
                cutsceneID = 52
            elseif counter == 2 then
                cutsceneID = 54
            end

            -- Check Key Items and give them their dynamic event.
            if
                player:hasKeyItem(xi.ki.RAFFLESIA_DREAMSPIT) and
                player:hasKeyItem(xi.ki.DROGAROGAN_BONEMEAL) and
                loafersQuestProgress == 3
            then
                -- Scholar's Loafers
                player:startEvent(cutsceneID, 15748)
                player:setLocalVar('item', 15748)
                player:setLocalVar('firstKI', xi.ki.RAFFLESIA_DREAMSPIT)
                player:setLocalVar('secondKI', xi.ki.DROGAROGAN_BONEMEAL)

            elseif
                player:hasKeyItem(xi.ki.SLUG_MUCUS) and
                player:hasKeyItem(xi.ki.DJINN_EMBER) and
                pantsQuestProgress == 3
            then
                -- Scholar's Pants
                player:startEvent(cutsceneID, 16311)
                player:setLocalVar('item', 16311)
                player:setLocalVar('firstKI', xi.ki.SLUG_MUCUS)
                player:setLocalVar('secondKI', xi.ki.DJINN_EMBER)

            elseif
                player:hasKeyItem(xi.ki.PEISTE_DUNG) and
                player:hasKeyItem(xi.ki.SAMPLE_OF_GRAUBERG_CHERT) and
                gownQuestProgress == 3
            then
                -- Scholar's Gown
                player:startEvent(cutsceneID, 14580)
                player:setLocalVar('item', 14580)
                player:setLocalVar('firstKI', xi.ki.PEISTE_DUNG)
                player:setLocalVar('secondKI', xi.ki.SAMPLE_OF_GRAUBERG_CHERT)

            -- Show them the normal Menu to select from.
            else
                local params = 0 -- Controls which items to hide (Binary - 0XXX)

                -- Scholar's Loafers
                if loafersQuestProgress ~= 0 then
                    params = 1
                end

                -- Scholar's Pants
                if pantsQuestProgress ~= 0 then
                    params = params + 2
                end

                -- Scholar's Gown
                if gownQuestProgress ~= 0 then
                    params = params + 4
                end

                if params < 8 then
                    if afProgress > 0 then
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

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 49 or csid == 53 then
        -- Display Loafers
        if option == 2 then
            player:updateEvent(option, xi.ki.RAFFLESIA_DREAMSPIT, xi.ki.DROGAROGAN_BONEMEAL, 0, 0, 0, 0, 0)

        -- Display Pants
        elseif option == 4 then
            player:updateEvent(option, xi.ki.SLUG_MUCUS, xi.ki.DJINN_EMBER, 0, 0, 0, 0, 0)

        -- Display Gown
        elseif option == 6 then
            player:updateEvent(option, xi.ki.PEISTE_DUNG, xi.ki.SAMPLE_OF_GRAUBERG_CHERT, 0, 0, 0, 0, 0)

        -- Confirm Loafers
        elseif option == 1 then
            player:setCharVar('AF_SCH_BOOTS', 1)

        -- Confirm Pants
        elseif option == 3 then
            player:setCharVar('AF_SCH_PANTS', 1)

        -- Confirm Gown
        elseif option == 5 then
            player:setCharVar('AF_SCH_BODY', 1)

        elseif option > 7 then
            player:printToPlayer('There was an error in the CS. Inform your Server Admin/GM.')
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 49 and option == 0 then
        player:setCharVar('AF_Loussaire', 1)

    elseif csid == 51 or csid == 52 or csid == 54 then
        local itemid   = player:getLocalVar('item')
        local firstKI  = player:getLocalVar('firstKI')
        local secondKI = player:getLocalVar('secondKI')

        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, itemid)

        else
            -- Remove LocalVars
            player:setLocalVar('item', 0)
            player:setLocalVar('firstKI', 0)
            player:setLocalVar('secondKI', 0)

            -- Flag the path complete
            if itemid == 15748 then
                player:setCharVar('AF_SCH_BOOTS', 4)
            elseif itemid == 16311 then
                player:setCharVar('AF_SCH_PANTS', 4)
            else
                player:setCharVar('AF_SCH_BODY', 4)
            end

            local afProgress = player:getCharVar('AF_Loussaire')
            if afProgress == 3 then

                -- They are done. Clean-up
                player:setCharVar('AF_SCH_BOOTS',    0)
                player:setCharVar('AF_SCH_PANTS',    0)
                player:setCharVar('AF_SCH_BODY',     0)
                player:setCharVar('AF_Loussaire',    0)
                player:setCharVar('AF_SCH_COMPLETE', 1)

            else
                player:setCharVar('AF_Loussaire', afProgress + 1) -- They got an item. Add it!
            end

            player:delKeyItem(firstKI)
            player:delKeyItem(secondKI)
            player:messageSpecial(ID.text.ITEM_OBTAINED, itemid)
            player:addItem(itemid)
        end
    end
end

return entity
