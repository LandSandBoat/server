-----------------------------------
-- Area: Upper Jeuno
--  NPC: Bheem
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/pets/fellow")
require("scripts/globals/fellow_utils")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local unlistedQualities = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.UNLISTED_QUALITIES)
    local unlistedQualitiesProgress = player:getCharVar("[Quest]Unlisted_Qualities")
    local lookingGlass = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS)
    local lookingGlassProgress = player:getCharVar("[Quest]Looking_Glass")
    local fellowParam = 0
    if
        unlistedQualities >= QUEST_ACCEPTED and
        (unlistedQualitiesProgress >= 7 or
        unlistedQualitiesProgress == 0)
    then
        fellowParam = xi.fellow_utils.getFellowParam(player)
    end

    if
        unlistedQualities == QUEST_ACCEPTED and
        unlistedQualitiesProgress < 7
    then
        player:startEvent(10037)
    elseif
        unlistedQualities == QUEST_ACCEPTED and
        unlistedQualitiesProgress == 7
    then
        player:startEvent(10171, 0, 0, 0, 0, 0, 0, 0, fellowParam)
    elseif
        lookingGlass == QUEST_ACCEPTED and
        lookingGlassProgress == 1
    then
        player:startEvent(10040, 244, 0, 0, 0, 0, 0, 0, fellowParam)
    else
        player:startEvent(157)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10171 then
        player:setCharVar("[Quest]Unlisted_Qualities", utils.mask.setBit(player:getCharVar("[Quest]Unlisted_Qualities"), 3, true))
    elseif csid == 10040 then
        player:setCharVar("[Quest]Looking_Glass", 2)
    end
end

return entity
