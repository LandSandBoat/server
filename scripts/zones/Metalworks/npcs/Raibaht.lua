-----------------------------------
-- Area: Metalworks
--  NPC: Raibaht
-- Starts and Finishes Quest: Dark Legacy
-- Involved in Quest: The Usual, Riding on the Clouds
-- !pos -27 -10 -1 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local darkLegacy = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_LEGACY)
    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()

    if (darkLegacy == QUEST_AVAILABLE and mJob == xi.job.DRK and mLvl >= xi.settings.main.AF1_QUEST_LEVEL) then
        player:startEvent(751) -- Start Quest "Dark Legacy"
    elseif (player:hasKeyItem(xi.ki.DARKSTEEL_FORMULA)) then
        player:startEvent(755) -- Finish Quest "Dark Legacy"
    elseif (player:hasKeyItem(xi.ki.STEAMING_SHEEP_INVITATION) and player:getCharVar("TheUsual_Event") ~= 1) then
        player:startEvent(510)
    else
        player:startEvent(501)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 510 and option == 0) then
        player:setCharVar("TheUsual_Event", 1)
    elseif (csid == 751) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_LEGACY)
        player:setCharVar("darkLegacyCS", 1)
    elseif (csid == 755) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 16798) -- Raven Scythe
        else
            player:delKeyItem(xi.ki.DARKSTEEL_FORMULA)
            player:addItem(16798)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 16798) -- Raven Scythe
            player:setCharVar("darkLegacyCS", 0)
            player:addFame(xi.quest.fame_area.BASTOK, 20)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_LEGACY)
        end
    end
end

return entity
