-----------------------------------
-- The Weekly Adventurer
-----------------------------------
-- !addquest 7 2
-- Naiko-Paneiko   : !pos 294.030 -33.443 -28.637 171
-- Rakula-Motakula : !pos -316.786 -12.448 -118.721 91
-----------------------------------

local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_WEEKLY_ADVENTURER)

quest.reward =
{
    exp     = 2000,
    gil     = 2000,
    keyItem = xi.keyItem.MAP_OF_FORT_KARUGO_NARUGO,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.CRAWLERS_NEST_S] =
        {
            ['Naiko-Paneiko'] =
            {
                onTrigger = function(player, npc)
                    -- Hey there, kid, I'm Naiko-Paneiko, up-and-coming ace journalist
                    return quest:progressEvent(16)
                end,
            },

            onEventFinish =
            {
                [16] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.keyItem.SCOOP_DEDICATED_LINKPEARL)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.CRAWLERS_NEST_S] =
        {
            ['Naiko-Paneiko'] =
            {
                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')

                    -- Default or Retry state
                    if prog == 0 or prog == 4 then
                        -- What are you doing, kid? Get to the Rolanberry Fields rightaru away!
                        return quest:progressEvent(21)
                    elseif prog == 1 then -- Success
                        -- Oh, there you are, kid. Greataru work!
                        return quest:progressEvent(19, 171, 1, 2984, 3, 0, 10, 0, 0)
                    elseif prog == 2 then -- Fail type 1
                        -- Oooh, look who's back! We got problems, kid? I just don'taru get it.
                        quest:setVar(player, 'Prog', 4)
                        return quest:progressEvent(17)
                    elseif prog == 3 then -- Fail type 2
                        -- Oooh, look who's back! We got problems, kid? This just doesn't make any sense!
                        quest:setVar(player, 'Prog', 4)
                        return quest:progressEvent(18)
                    end
                end,
            },

            onEventFinish =
            {
                [19] = function(player, csid, option, npc)
                    -- SCOOP_DEDICATED_LINKPEARL is removed silently
                    player:delKeyItem(xi.keyItem.SCOOP_DEDICATED_LINKPEARL)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.ROLANBERRY_FIELDS_S] =
        {
            -- NOTE: Merim-Kurim never interacts with you, despite looking like he does in the CS

            ['Rakula-Motakula'] =
            {
                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')

                    -- NOTE: The quiz answers are: 4-4-5.
                    if prog == 0 then
                        -- These are dangerous lands, adventurer. We advise that you distance yourself from here.
                        return quest:progressEvent(3)
                    elseif prog == 4 then
                        -- Oh, it's you again.
                        return quest:progressEvent(3, 0, 0, 0, 0, 0, 0, 0, 1)
                    end
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    if option == 0 then -- Passed the quiz
                        quest:setVar(player, 'Prog', 1)
                    elseif option == 1 then -- Picked wrong category
                        quest:setVar(player, 'Prog', 2)
                    elseif option == 2 then -- Reported wrong information
                        quest:setVar(player, 'Prog', 3)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.CRAWLERS_NEST_S] =
        {
            -- Alll rightaru! Let's make the news!
            ['Naiko-Paneiko'] = quest:event(20):replaceDefault(),
        },
    },
}

return quest
