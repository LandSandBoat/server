-----------------------------------
-- The Fighting Fourth (WOTG Nation Quests Bastok Intro)
-- !addquest 7 7
-- Turbulent Storm : !pos 422.461 -48.000 -47.308 175
-- Adelbrecht      : !pos -325.766 -12.601 -76.977 87
-- Gebhardt        : !pos 206.299 -20.826 669.125 88
-- Roderich        : !pos -400.039 39.991 -90.445 88
-- Barricade       : !pos -514.960 37.979 583.287 88
-----------------------------------
local marketsID = zones[xi.zone.BASTOK_MARKETS_S]
-----------------------------------

local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH)

quest.reward =
{
    -- TODO: The messaging for this should be first keyItem and then item, but is swapped
    item    = xi.item.SPRINTERS_SHOES,
    keyItem = xi.keyItem.BRONZE_RIBBON_OF_SERVICE,
    title   = xi.title.FOURTH_DIVISION_SOLDIER,

    -- TODO: You should only get the item reward the first time you sign up to a campaign allegiance.
    --     : You shouldn't get it again if you switch allegiances (but not a huge deal, these are a cheap item)
}

local removeRations = function(player)
    -- Note the messaging specific to this interaction!
    player:delKeyItem(xi.keyItem.BATTLE_RATIONS)
    player:messageSpecial(marketsID.text.ARE_TAKEN_AWAY_FROM_CHAR, xi.keyItem.BATTLE_RATIONS)
end

local returnLetter = function(player)
    -- Note the messaging specific to this interaction!
    npcUtil.giveKeyItem(player, xi.keyItem.BLUE_RECOMMENDATION_LETTER, marketsID.text.ITEM_RETURNED_TO_CHAR)
end

local quitQuest = function(player)
    player:delQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH)
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
            -- TODO: Conditions to not have a different campaign allegiance?
        end,

        [xi.zone.THE_ELDIEME_NECROPOLIS_S] =
        {
            ['Turbulent_Storm'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: Conditions to not have a different campaign allegiance?

                    local hasLetter  = player:hasKeyItem(xi.keyItem.BLUE_RECOMMENDATION_LETTER)
                    local hasRations = player:hasKeyItem(xi.keyItem.BATTLE_RATIONS)

                    -- TODO: Verify the check for rations exists on retail
                    if hasLetter or hasRations then
                        -- You won't be considered a member of the Fighting Fourth until you take that blue recommendation letter to Bastok...
                        return quest:event(8)
                    else
                        -- Hold it right there. You don't look like one of ours.
                        return quest:event(7)
                    end
                end,
            },

            onEventFinish =
            {
                [7] = function(player, csid, option, npc)
                    if option == 0 then
                        npcUtil.giveKeyItem(player, xi.keyItem.BLUE_RECOMMENDATION_LETTER)
                    end
                end,
            },
        },

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Adelbrecht'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: Conditions to not have a different campaign allegiance?

                    if player:hasKeyItem(xi.keyItem.BLUE_RECOMMENDATION_LETTER) then
                        -- Greetings, civillian. The Seventh Cohors of the Republican Legion's Fourth Division is currently recruiting new troops.
                        -- Args (from caps): With recommendation letter
                        return quest:progressEvent(139, 0, 0)
                    else
                        -- Greetings, civillian. The Seventh Cohors of the Republican Legion's Fourth Division is currently recruiting new troops.
                        -- Args (from caps): Without recommendation letter (after first prompt)
                        return quest:progressEvent(139, 1, 23)
                    end
                end,
            },

            onEventFinish =
            {
                [139] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delKeyItem(xi.keyItem.BLUE_RECOMMENDATION_LETTER)
                        npcUtil.giveKeyItem(player, xi.keyItem.BATTLE_RATIONS)
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Adelbrecht'] =
            {
                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')

                    if prog == 0 then
                        -- I thought you didn't have any questions!
                        return quest:event(140)
                    elseif prog == 1 then
                        -- Good work, rookie. You've passed the test with flying colors! ...Or at least that's what I'd say...
                        return quest:event(141)
                    elseif prog == 2 then
                        -- I heard the news about the ambush.
                        return quest:event(142)
                    elseif prog == 3 then
                        -- Welcome back, rookie. I read the praefectus's report.
                        return quest:progressEvent(143)
                    end
                end,
            },

            onEventFinish =
            {
                [140] = function(player, csid, option, npc)
                    if option == 1 then
                        removeRations(player)
                        returnLetter(player)
                        quitQuest(player)
                    end
                end,

                [141] = function(player, csid, option, npc)
                    if option == 1 then
                        returnLetter(player)
                        quitQuest(player)
                    end
                end,

                [142] = function(player, csid, option, npc)
                    if option == 1 then
                        returnLetter(player)
                        quitQuest(player)
                    end
                end,

                [143] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.NORTH_GUSTABERG_S] =
        {
            ['Gebhardt'] =
            {
                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')

                    if prog == 0 then
                        -- Rations!? Hand those over, rookie!
                        return quest:progressEvent(102)
                    elseif prog == 1 then
                        return quest:event(103) -- Reminder
                    elseif prog == 2 then
                        -- Those turtlebacks intercepted the communication!?
                        return quest:event(107)
                    elseif prog == 3 then
                        -- Thanks to your diligence, the Republic is safe for another day.
                        return quest:event(108)
                    end
                end,
            },

            ['Roderich'] =
            {
                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')

                    if prog == 1 then
                        -- Centurion Gebhardt asked you to come all the way here...?
                        return quest:progressEvent(104)
                    elseif prog == 2 then
                        return quest:event(105) -- Reminder
                    elseif prog == 3 then
                        -- I just heard the report!
                        return quest:event(109)
                    end
                end,
            },

            ['Barricade'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        -- Stop right there! I think you have something of mine!
                        return quest:progressEvent(106)
                    end
                end,
            },

            onEventFinish =
            {
                [102] = function(player, csid, option, npc)
                    player:delKeyItem(xi.keyItem.BATTLE_RATIONS) -- TODO: Confirm on retail that these are actually taken, there's no message
                    quest:setVar(player, 'Prog', 1)
                end,

                [104] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [106] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        -- TODO: Are these new default texts forever, or only as long as you have this campaign allegiance?

        [xi.zone.THE_ELDIEME_NECROPOLIS_S] =
        {
            -- I heard about the news, recruit.
            ['Turbulent_Storm'] = quest:event(9):replaceDefault(),
        },

        [xi.zone.BASTOK_MARKETS_S] =
        {
            -- What are you doing soldier?
            ['Adelbrecht'] = quest:event(162):replaceDefault(),
        },

        [xi.zone.NORTH_GUSTABERG_S] =
        {
            -- Thanks to your diligence, the Republic is safe for another day.
            ['Gebhardt'] = quest:event(108):replaceDefault(),

            -- I just heard the report!
            ['Roderich'] = quest:event(109):replaceDefault(),
        },
    },
}

return quest
