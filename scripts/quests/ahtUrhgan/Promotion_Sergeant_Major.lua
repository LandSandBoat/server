-----------------------------------
-- Promotion: Promotion Sergeant Major
-- Naja Salaheem !pos 26 -8 -45.5 50
-----------------------------------
local whitegateID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_SERGEANT_MAJOR)

quest.reward =
{
    keyItem = xi.ki.SM_WILDCAT_BADGE,
    title   = xi.title.SERGEANT_MAJOR,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getCharVar('AssaultPromotion') >= 25 and
            player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_SERGEANT) == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:progressEvent(5048),

            onEventFinish =
            {
                [5048] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', VanadielUniqueDay())
                    if option == 2 then
                        quest:setVar(player, 'Stage', 1)
                    end
                end,
            },
        },
    },
    {
        -- Didnt pass 1st game and has to redo
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Stage == 0 and
            vars.Prog < VanadielUniqueDay()
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:progressEvent(5049),

            onEventFinish =
            {
                [5049] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', VanadielUniqueDay())
                    if option == 2 then
                        -- passed 1st mini game, onto 2nd
                        quest:setVar(player, 'Stage', 1)
                    end
                end,
            },
        },
    },
    {
        -- Passed 1st mini game, start 2nd
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Stage == 1 and
            vars.Prog < VanadielUniqueDay()
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:progressEvent(5050),

            onEventFinish =
            {
                [5050] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', VanadielUniqueDay())
                    if option == 2 then
                        -- passed mini game, onto 3rd game
                        quest:setVar(player, 'Stage', 3)
                    else
                        -- failed and has to do again
                        quest:setVar(player, 'Stage', 2)
                    end
                end,
            },
        },
    },
    {
        -- Didnt pass 2nd game, redo
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Stage == 2 and
            vars.Prog < VanadielUniqueDay()
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:progressEvent(5051),

            onEventFinish =
            {
                [5051] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', VanadielUniqueDay())
                    if option == 2 then
                        -- passed mini game, onto 3rd game
                        quest:setVar(player, 'Stage', 3)
                    end
                end,
            },
        },
    },
    {
        -- Passed 2nd mini game, start 3rd
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Stage == 3 and
            vars.Prog < VanadielUniqueDay()
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:progressEvent(5052),

            onEventFinish =
            {
                [5052] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', VanadielUniqueDay())
                    if option == 2 then
                        -- passed mini game, You did it!
                        quest:setVar(player, 'Stage', 5)
                    else
                        -- failed and has to do again
                        quest:setVar(player, 'Stage', 4)
                    end
                end,
            },
        },
    },
    {
        -- Didnt pass 3rd game, Redo
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Stage == 4 and
            vars.Prog < VanadielUniqueDay()
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:progressEvent(5053),

            onEventFinish =
            {
                [5053] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', VanadielUniqueDay())
                    if option == 2 then
                        -- passed mini game, complete
                        quest:setVar(player, 'Stage', 5)
                    end
                end,
            },
        },
    },
    {
        -- Passed all games and 1 game day wait
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Stage == 5 and
            vars.Prog < VanadielUniqueDay()
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:progressEvent(5054),

            onEventFinish =
            {
                [5054] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setCharVar('AssaultPromotion', 0)
                        player:delKeyItem(xi.ki.S_WILDCAT_BADGE)
                        player:messageSpecial(whitegateID.text.PROMOTION_SERGEANT_MAJOR)
                    end
                end,
            },
        },
    },
}

return quest
