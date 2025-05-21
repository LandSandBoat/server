-----------------------------------
-- X Marks the Spot
-----------------------------------
-- Log ID: 4, Quest ID: 65
-----------------------------------
-- CoP Mission 2-5 Ancient Vows Completed
-----------------------------------
-- !addmission 6 20
-- Tavnazian Safehold       !zone 26
-- Despachiaire             !pos 111.2090 -40.0148 -85.4810
-- Parelbriaux              !pos 113.701 -41 42.3653
-- Odeya                    !pos 83.3227 -34.25 -70.0384
-- Phomiuna Aqueducts       !zone 27
-- Hidden Hallway 2nd Gate  !pos 138.1027 -24 60.3209
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.X_MARKS_THE_SPOT)

quest.reward =
{
    gil = 4000,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.ANCIENT_VOWS
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] = quest:progressEvent(144),

            onEventFinish =
            {
                [144] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            -- Will repeat until the quest is completed.
            ['Despachiaire'] = quest:event(144):importantOnce(),

            ['Parelbriaux'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') <= 1 then
                        return quest:progressEvent(145)
                    end
                end,
            },

            ['Odeya'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 1 then
                        return quest:progressEvent(141, 0, xi.item.TAVNAZIAN_LIVER)
                    elseif progress == 2 then
                        return quest:event(146, 0, xi.item.TAVNAZIAN_LIVER)
                    elseif progress == 3 then
                        return quest:event(147)
                    elseif progress == 4 then
                        return quest:progressEvent(143)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        npcUtil.tradeHasExactly(trade, xi.item.TAVNAZIAN_LIVER)
                    then
                        return quest:progressEvent(142)
                    end
                end,
            },

            onEventFinish =
            {
                [141] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [142] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 3)
                end,

                [143] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        quest:setVar(player, 'Post', 1)
                    end
                end,

                [145] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.PHOMIUNA_AQUEDUCTS] =
        {
            ['_0r9'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(37)
                    else
                        return
                    end
                end,
            },

            onEventFinish =
            {
                [37] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },

        }
    },

    {
        -- Post Quest Dialogue, once the player gets this dialogue it will continue until the player zones.
        -- After zoning this is never seen again.
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Odeya'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Post') >= 1 then
                        return quest:event(148)
                    end
                end,
            },

            onEventFinish =
            {
                [148] = function(player, csid, option, npc)
                    quest:setVar(player, 'Post', 2)
                end,
            },

            onZoneOut = function(player)
                if quest:getVar(player, 'Post') == 2 then
                    quest:cleanup(player)
                end
            end,
        },
    },
}

return quest
