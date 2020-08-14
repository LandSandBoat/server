-----------------------------------
-- Area: Western Adoulin
--  NPC: Dewalt
-- Type: Standard NPC and Quest NPC
-- Involved with Quests: 'Flavors of our Lives', 'Dont Ever Leaf Me'
--  !pos -23 0 28 256
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local DELM = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.DONT_EVER_LEAF_ME)
    local FOOL = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.FLAVORS_OF_OUR_LIVES)
    if ((DELM == QUEST_ACCEPTED) and (player:getCharVar("DELM_Dewalt_Branch") < 1)) then
        -- Progresses Quest: 'Dont Ever Leaf Me'
        player:startEvent(5013)
    elseif ((FOOL == QUEST_ACCEPTED) and ((player:getCharVar("FOOL_Status") == 1) or (player:getCharVar("FOOL_Status") == 2)))  then
        if (player:getCharVar("FOOL_Status") == 1) then
            -- Progresses Quest: 'Flavors of Our Lives'
            player:startEvent(85)
        else
            -- Reminds player of hint for Quest: 'Flavors of Our Lives'
            player:startEvent(105)
        end
    elseif ((DELM == QUEST_ACCEPTED) and (player:getCharVar("DELM_Dewalt_Branch") < 2)) then
        -- Reminds player of hint for Quest: 'Dont Ever Leaf Me'
        player:startEvent(5014)
    else
        -- Standard dialogue
        player:startEvent(5017)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 5013) then
        -- Progresses Quest: 'Dont Ever Leaf Me'
        player:setCharVar("DELM_Dewalt_Branch", 1)
    elseif (csid == 85) then
        -- Progresses Quest: 'Flavors of Our Lives'
        player:setCharVar("FOOL_Status", 3)
    end
end
