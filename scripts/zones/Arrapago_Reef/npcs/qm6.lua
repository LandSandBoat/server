-----------------------------------
-- Area: Arrapago Reef
--  NPC: ??? (H-10 / COR boat)
-- Involved in Quests: 'Luck of the Draw', 'Equipped for All Occasions', 'Navigating the Unfriendly Seas'
-- !pos 468.767 -12.292 111.817 54
-----------------------------------
local ID = zones[xi.zone.ARRAPAGO_REEF]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local mJob   = player:getMainJob()
    local mLvl   = player:getMainLvl()
    local efao   = player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS)
    local ntus   = player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS)

    -- NAVIGATING THE UNFRIENDLY SEAS
    if
        efao == xi.questStatus.QUEST_COMPLETED and
        ntus == xi.questStatus.QUEST_AVAILABLE and
        mJob == xi.job.COR and
        mLvl >= xi.settings.main.AF2_QUEST_LEVEL
    then
        player:startEvent(232)
    elseif player:getCharVar('NavigatingtheUnfriendlySeas') == 4 then
        player:startEvent(233)

    -- DEFAULT DIALOG
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- NAVIGATING THE UNFRIENDLY SEAS
    if csid == 232 then
        player:addQuest(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS)
        player:setCharVar('NavigatingtheUnfriendlySeas', 1)
    elseif csid == 233 then
        npcUtil.completeQuest(player, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS, { item = 15601, var = { 'NavigatingtheUnfriendlySeas', 'HydrogauageTimer' } })
    end
end

return entity
