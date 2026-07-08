-----------------------------------
-- Area: Windurst Waters
--  NPC: Tosuka-Porika
-- Starts Quests: Early Bird Catches the Bookworm, Chasing Tales
-- Involved in Quests: Hat in Hand, Past Reflections, Blessed Radiance
-- Involved in Missions: Windurst 2-1/7-1/8-2, CoP 3-3
-- !pos -26 -6 103 238
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Hat in Hand
    if
        player:hasKeyItem(xi.ki.NEW_MODEL_HAT) and
        not utils.mask.getBit(player:getCharVar('QuestHatInHand_var'), 5)
    then
        player:messageSpecial(ID.text.YOU_SHOW_OFF_THE, 0, xi.ki.NEW_MODEL_HAT)
        player:startEvent(55)

    -- Standard dialogues
    elseif player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_SIXTH_MINISTRY) then
        player:startEvent(379) -- 'Hey, you're the adventurer from the other day!'
    elseif player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.LOST_FOR_WORDS) then
        player:startEvent(169) -- 'You must not frighten the others with rumors that the Book of the Gods has gone blank...'
    elseif player:getLocalVar('TosukaDialogueToggle') == 1 then
        player:startEvent(881) -- He toggles this event with 370 when player has no other mission/quest dialogue.
        player:setLocalVar('TosukaDialogueToggle', 0)
    else
        player:startEvent(370) -- 'It doesn't seem like you'd have any business with our distinguished Library of Magic...'
        player:setLocalVar('TosukaDialogueToggle', 1)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- Hat in Hand
    if csid == 55 then  -- Show Off Hat
        player:setCharVar('QuestHatInHand_var', utils.mask.setBit(player:getCharVar('QuestHatInHand_var'), 5, true))
        player:incrementCharVar('QuestHatInHand_count', 1)
    end
end

return entity
