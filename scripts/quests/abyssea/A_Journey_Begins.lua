-----------------------------------
-- A Journey Begins
-----------------------------------
-- !addquest 8 160
-- Joachim : !pos -52.844 0 -9.978 246
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.A_JOURNEY_BEGINS)

quest.reward =
{
    keyItem = xi.ki.TRAVERSER_STONE1,
}

quest.sections =
{
    -- Retail behavior for this quest is to flag when the expansion has been purchased,
    -- and is flagged if Abyssea is enabled in onGameIn.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and player:getMainLvl() >= 30
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['Joachim'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(325)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 0 then
                        return 324
                    end
                end,
            },

            onEventFinish =
            {
                [324] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [325] = function(player, csid, option, npc)
                    if quest:complete(player) then

                        -- Traverser Stone epoch begins when 'The Truth Beckons' is flagged, and is
                        -- retail behavior.  This can be confirmed by checking the currency tab on
                        -- retail servers.
                        player:setTraverserEpoch()
                        player:addQuest(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.THE_TRUTH_BECKONS)
                    end
                end,
            },
        },
    },
}

return quest
