-----------------------------------
-- Area: Western Adoulin
--  NPC: Pagnelle
-- !pos -8 0 -100 256
-----------------------------------
local ID = zones[xi.zone.WESTERN_ADOULIN]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local raptorRapture = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.RAPTOR_RAPTURE)
    local raptorRaptureStatus = player:getCharVar('Raptor_Rapture_Status')

    if raptorRapture == xi.questStatus.QUEST_AVAILABLE then
        if raptorRaptureStatus < 3 then
            -- Starts chain of events for the introduction CS for Quest: 'Raptor Rapture'.
            -- If player somehow doesn't finish the chain of events, they can just talk to Pagnelle again to retry.
            player:setCharVar('Raptor_Rapture_Status', 1)
            player:startEvent(5032)
        else
            -- Player has finished introductory CS event chain, but didn't accept the quest.
            -- Offers Quest: 'Raptor Rapture' if player has yet to accept it.
            player:startEvent(5061)
        end
    elseif raptorRapture == xi.questStatus.QUEST_ACCEPTED then
        if raptorRaptureStatus == 4 then
            -- Reminder during Quest: 'Raptor Rapture', speak to Ilney.
            player:startEvent(5033)
        elseif raptorRaptureStatus == 5 then
            -- Progresses Quest: 'Raptor Rapture', spoke to Ilney.
            player:startEvent(5035)
        elseif raptorRaptureStatus == 6 then
            local hasRockberries = player:hasKeyItem(xi.ki.ROCKBERRY1) and player:hasKeyItem(xi.ki.ROCKBERRY2) and player:hasKeyItem(xi.ki.ROCKBERRY3)
            if hasRockberries then
                -- Progresses Quest: 'Raptor Rapture', turning in rockberries.
                player:startEvent(5037)
            else
                -- Reminder during Quest: 'Raptor Rapture', bring rockberries.
                player:startEvent(5036)
            end
        elseif raptorRaptureStatus == 7 then
            -- Reminder during Quest: 'Raptor Rapture', go to Rala.
            player:startEvent(5038)
        elseif raptorRaptureStatus == 8 then
            -- Finishes Quest: 'Raptor Rapture'
            player:startEvent(5039)
        end
    else
        if player:needToZone() then
            -- Dialogue after finishing Quest: 'Raptor Rapture', before zoning
            player:startEvent(5040)
        else
            -- Dialogue after finishing Quest: 'Raptor Rapture', after zoning
            player:startEvent(5041)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 5032 then
        -- Warps player to Rala Waterways to continue intrductory CS for Quest: 'Raptor Rapture'
        player:setPos(0, 0, 0, 0, 258)
    elseif csid == 5061 and option == 1 then
        -- Starts Quest: 'Raptor Rapture'
        player:addQuest(xi.questLog.ADOULIN, xi.quest.id.adoulin.RAPTOR_RAPTURE)
        player:setCharVar('Raptor_Rapture_Status', 4)
    elseif csid == 5035 then
        -- Progresses Quest: 'Raptor Rapture', spoke to Ilney, now need rockberries.
        player:setCharVar('Raptor_Rapture_Status', 6)
    elseif csid == 5037 then
        -- Progresses Quest: 'Raptor Rapture', brought rockberries, now need to go to Rala.
        player:delKeyItem(xi.ki.ROCKBERRY1)
        player:delKeyItem(xi.ki.ROCKBERRY2)
        player:delKeyItem(xi.ki.ROCKBERRY3)
        player:setCharVar('Raptor_Rapture_Status', 7)
    elseif csid == 5039 then
        -- Finishing Quest: 'Raptor Rapture'
        player:setCharVar('Raptor_Rapture_Status', 0)
        player:completeQuest(xi.questLog.ADOULIN, xi.quest.id.adoulin.RAPTOR_RAPTURE)
        player:addCurrency('bayld', 1000 * xi.settings.main.BAYLD_RATE)
        player:messageSpecial(ID.text.BAYLD_OBTAINED, 1000 * xi.settings.main.BAYLD_RATE)

        -- TODO: Verify fame value added
        player:addFame(xi.fameArea.ADOULIN, 30)
        player:needToZone(true)
    end
end

return entity
