-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: Brazier
-- Involved in Quests: Save my Sister
-- !pos 101 -33 -59 195 (F-9)
-- !pos 259 -33 99 195 (H-7)
-- !pos 99 -33 98 195 (F-7)
-- !pos 259 -33 -58 195 (H-9)
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SISTER) == QUEST_ACCEPTED and player:getCharVar("saveMySisterFireLantern") < 4 then
        player:setCharVar("saveMySisterLanternID", npc:getID())
        player:startEvent(44)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 44 and option == 0 then
        local lanternOrder = player:getCharVar("saveMySisterFireLantern")
        local offset = player:getCharVar("saveMySisterLanternID") - ID.npc.BRAZIER_OFFSET
        player:setCharVar("saveMySisterLanternID", 0)

        if lanternOrder == 0 then
            if offset == 0 then -- (F-9)
                player:messageSpecial(ID.text.THE_LIGHT_DIMLY, 0, 0, 0, xi.ki.DUCAL_GUARDS_LANTERN_LIT)
                player:setCharVar("saveMySisterFireLantern", 1)
            else
                player:messageSpecial(ID.text.REFUSE_TO_LIGHT, 0, 0, 0, xi.ki.DUCAL_GUARDS_LANTERN_LIT)
            end
        elseif lanternOrder == 1 then
            if offset == 1 then -- (H-7)
                player:messageSpecial(ID.text.THE_LIGHT_HAS_INTENSIFIED, 0, 0, 0, xi.ki.DUCAL_GUARDS_LANTERN_LIT)
                player:setCharVar("saveMySisterFireLantern", 2)
            else
                player:messageSpecial(ID.text.LANTERN_GOES_OUT, 0, 0, 0, xi.ki.DUCAL_GUARDS_LANTERN_LIT)
                player:setCharVar("saveMySisterFireLantern", 0)
            end
        elseif lanternOrder == 2 then
            if offset == 2 then -- (F-7)
                player:messageSpecial(ID.text.THE_LIGHT_HAS_INTENSIFIED, 0, 0, 0, xi.ki.DUCAL_GUARDS_LANTERN_LIT)
                player:setCharVar("saveMySisterFireLantern", 3)
            else
                player:messageSpecial(ID.text.LANTERN_GOES_OUT, 0, 0, 0, xi.ki.DUCAL_GUARDS_LANTERN_LIT)
                player:setCharVar("saveMySisterFireLantern", 0)
            end
        elseif lanternOrder == 3 then
            if offset == 3 then -- (H-9)
                player:messageSpecial(ID.text.THE_LIGHT_IS_FULLY_LIT, 0, 0, 0, xi.ki.DUCAL_GUARDS_LANTERN_LIT)
                player:setCharVar("saveMySisterFireLantern", 4)
            else
                player:messageSpecial(ID.text.LANTERN_GOES_OUT, 0, 0, 0, xi.ki.DUCAL_GUARDS_LANTERN_LIT)
                player:setCharVar("saveMySisterFireLantern", 0)
            end
        end
    end
end

return entity
