-----------------------------------
-- Chasing Tales
-----------------------------------
-- !addquest 2 13
-- Tosuka-Porika   : !pos -26 -6 103 238
-- Furakku-Norakku : !pos -19 -5 101 238
-- Hae Jakkya      : !pos 57.387 -2.5 -140.757 241
-- Hae Jakhya      : !pos -75.36 -7.4 -23.82 230
-- TODO: This quest could be simplified with expanded use of Prog questVar.
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CHASING_TALES)

quest.reward =
{
    fame = 120,
    fameArea = xi.quest.fame_area.WINDURST,
    gil = 2800,
    title = xi.title.SAVIOR_OF_KNOWLEDGE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.EARLY_BIRD_CATCHES_THE_BOOKWORM) and
                player:getFameLevel(xi.quest.fame_area.WINDURST) >= 3 and
                not quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Tosuka-Porika'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: Requirements for availability need to be verified, and was referenced at the below location.  Left
                    -- in this block to make it easier to remove if it turns out to be inaccurate.
                    -- https://ffxiclopedia.fandom.com/wiki/Chasing_Tales
                    if
                        player:getNation() ~= xi.nation.WINDURST or
                        player:getCurrentMission(xi.mission.log_id.WINDURST) ~= xi.mission.id.windurst.THE_JESTER_WHOD_BE_KING
                    then
                        return quest:progressEvent(403)
                    end
                end,
            },

            onEventFinish =
            {
                [403] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Hae_Jakhya'] =
            {
                onTrigger = function(player, npc)
                    local hasBookKeyItem = player:hasKeyItem(xi.ki.A_SONG_OF_LOVE)

                    if
                        not hasBookKeyItem and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(611)
                    elseif hasBookKeyItem then
                        return quest:progressEvent(612, 0, xi.ki.A_SONG_OF_LOVE)
                    end
                end,
            },

            onEventFinish =
            {
                [611] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.A_SONG_OF_LOVE)
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Tosuka-Porika'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(406)
                    else
                        return quest:progressEvent(412)
                    end
                end,
            },

            ['Furakku-Norakku'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.OVERDUE_BOOK_NOTIFICATION_CHASING_TALES) then
                        return quest:progressEvent(404, 0, xi.ki.A_SONG_OF_LOVE)
                    elseif not player:hasKeyItem(xi.ki.A_SONG_OF_LOVE) then
                        if quest:getVar(player, 'Prog') == 1 then
                            return quest:progressEvent(409)
                        elseif player:hasKeyItem(xi.ki.OVERDUE_BOOK_NOTIFICATION_CHASING_TALES) then
                            return quest:progressEvent(405, 0, 126)
                        end
                    elseif player:hasKeyItem(xi.ki.A_SONG_OF_LOVE) then
                        return quest:progressEvent(410)
                    end
                end,
            },

            onEventFinish =
            {
                [404] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.OVERDUE_BOOK_NOTIFICATION_CHASING_TALES)
                end,

                [410] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.OVERDUE_BOOK_NOTIFICATION_CHASING_TALES)
                        player:delKeyItem(xi.ki.A_SONG_OF_LOVE)
                        player:setLocalVar('Quest[2][12]mustZone', 1)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['An_Polaali'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.A_SONG_OF_LOVE) then
                        return quest:progressEvent(407)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(404)
                    end
                end,
            },

            ['An_Shanaa'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.A_SONG_OF_LOVE) then
                        return quest:progressEvent(408, 0, xi.ki.A_SONG_OF_LOVE)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(405)
                    end
                end,
            },

            ['Hae_Jakkya'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.A_SONG_OF_LOVE) then
                        return quest:progressEvent(406)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(403, 0, xi.ki.A_SONG_OF_LOVE)
                    elseif player:hasKeyItem(xi.ki.OVERDUE_BOOK_NOTIFICATION_CHASING_TALES) then
                        return quest:progressEvent(402, 0, xi.ki.A_SONG_OF_LOVE)
                    end
                end,
            },

            onEventFinish =
            {
                [402] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Furakku-Norakku'] =
            {
                onTrigger = function(player, npc)
                    if player:getLocalVar('Quest[2][12]mustZone') == 1 then
                        return quest:event(411):replaceDefault()
                    end
                end,
            }
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['An_Polaali'] = quest:event(407):importantOnce(),
            ['An_Shanaa'] = quest:event(408, 0, 126):importantOnce(),
            ['Hae_Jakkya'] = quest:event(406):importantOnce(),
        },
    },
}

return quest
