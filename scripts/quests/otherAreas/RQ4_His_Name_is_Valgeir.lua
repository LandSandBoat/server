-----------------------------------
-- His Name is Valgeir
-- Variable Prefix: [4][3]
-----------------------------------
-- ZONE,    NPC,      POS
-- Mhaura,  Rycharde, !pos 17.451 -16.000 88.815 249
-- Selbina, Valgeir,  !pos 57.496 -15.273 20.229 248
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.HIS_NAME_IS_VALGEIR)

quest.reward =
{
    fame     = 120,
    fameArea = xi.quest.fame_area.WINDURST,
    gil      = 2000,
    keyItem  = xi.ki.MAP_OF_THE_TORAIMARAI_CANAL,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.UNENDING_CHASE) == QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getCharVar('Quest[4][2]DayCompleted') + 2 < VanadielUniqueDay() and
                        player:getFameLevel(xi.quest.fame_area.WINDURST) > 2
                    then
                        return quest:progressEvent(86) -- His Name is Valgeir starting event.
                    else
                        return quest:event(75)
                    end
                end,
            },

            ['Take'] = quest:event(65),

            onEventFinish =
            {
                [86] = function(player, csid, option, npc)
                    if option == 80 or option == 81 then -- Accept quest option.
                        player:setCharVar('Quest[4][2]DayCompleted', 0)   -- Delete previous quest (Unending Chase) variables
                        npcUtil.giveKeyItem(player, xi.ki.ARAGONEU_PIZZA) -- Give pizza to player
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepeted.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.MHAURA] =
        {
            ['Felisa'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.ARAGONEU_PIZZA) and -- No free ride after delivering Pizza.
                        player:getZPos() > 38.5 and -- Pos check.
                        quest:setVar(player, 'Prog') == 0 -- Hasn't taken the free ride.
                    then
                        return quest:progressEvent(230) -- Free ride. 1 time only. Non-Mandatory step.
                    end
                end,
            },

            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.ARAGONEU_PIZZA) then
                        return quest:progressEvent(88) -- Finish quest.
                    else
                        return quest:event(87) -- Not delivered the pizza yet.
                    end
                end,
            },

            ['Take'] = quest:event(65),

            onEventFinish =
            {
                [88] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addExp(2000)
                        quest:setVar(player, 'DayCompleted', VanadielUniqueDay()) -- Set completition day of quest.
                    end
                end,

                [230] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Valgeir'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ARAGONEU_PIZZA) then
                        return quest:progressEvent(100) -- Deliver Pizza.
                    else
                        return quest:event(101) -- Pizza delivered.
                    end
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.ARAGONEU_PIZZA)
                end,
            },
        },
    },
}

return quest
