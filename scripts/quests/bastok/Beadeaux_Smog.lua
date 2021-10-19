-----------------------------------
-- Beadeaux Smog
-----------------------------------
-- Log ID: 1, Quest ID: 33
-- High Bear    : !pos 25.231 -14.999 4.552 237
-- qm2 (for KI) : !pos -79 1 -99 147
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BEADEAUX_SMOG)

quest.reward =
{
    fame = 30,
    item = xi.items.CHAKRAM,
    title = xi.title.BEADEAUX_SURVEYOR,
}

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getFameLevel(BASTOK) >= 4
        end,

        [xi.zone.METALWORKS] =
        {
            --local BeaSmog = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BEADEAUX_SMOG)
            --local keyitem = player:hasKeyItem(xi.ki.CORRUPTED_DIRT)
            --if (BeaSmog == QUEST_AVAILABLE and player:getFameLevel(BASTOK) >= 4) then
            --    player:startEvent(731)
            --elseif (BeaSmog == QUEST_ACCEPTED and keyitem == false or BeaSmog == QUEST_COMPLETED) then
            --    player:startEvent(730)
            --elseif (BeaSmog == QUEST_ACCEPTED and keyitem == true) then
            --    player:startEvent(732)
            --end

            ['High_Bear'] = quest:progressEvent(731),

            onEventFinish =
            {
                [731] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        -- -- TODO: The ??? should only spawn during rainy weather, temporary fix in place to prevent players from getting the keyitem unless the proper weather is present.
        -- if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BEADEAUX_SMOG) == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.CORRUPTED_DIRT) == false and player:getWeather() == xi.weather.RAIN) then
        --     player:addKeyItem(xi.ki.CORRUPTED_DIRT)
        --     player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.CORRUPTED_DIRT)
        -- end

        [xi.zone.BEADEAUX] =
        {
            ['qm2'] = quest:progressEvent(257), -- TODO, the look information for this qm is wrong, recap me

            -- Get KI
        },
    },

    -- Section: Hand in quest
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED -- TODO: and has KI
        end,

        [xi.zone.METALWORKS] =
        {
            ['High_Bear'] = quest:progressEvent(732),

            onEventFinish =
            {
                [732] = function(player, csid, option, npc)
                    --player:addFame(BASTOK, 30)
                    --player:delKeyItem(xi.ki.CORRUPTED_DIRT)
                    --player:addItem(17284, 1) -- Chakram
                    --player:messageSpecial(ID.text.ITEM_OBTAINED, 17284)
                    --player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BEADEAUX_SMOG)
                    --player:setTitle(xi.title.BEADEAUX_SURVEYOR)
                end,
            },
        },
    },
}

return quest
