-----------------------------------
-- The Sahagin's Stash
-----------------------------------
-- Log ID: 5, Quest ID: 135
-- Laisrean : !pos -2.251 -1 21.654 252
-- qm2      : !pos 295.276 27.129 213.043 176
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_SAHAGINS_STASH)

quest.reward =
{
    fame     = 75,
    fameArea = xi.quest.fame_area.NORG,
    item     = xi.item.SCROLL_OF_UTSUSEMI_ICHI,
    title    = xi.title.TREASURE_HOUSE_RANSACKER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.NORG) >= 4 and
                player:getMainLvl() >= 5
        end,

        [xi.zone.NORG] =
        {
            ['Laisrean'] =
            {
                onTrigger = function(player, npc)
                    local hasDeclined = quest:getVar(player, 'Option')

                    return quest:progressEvent(33, { [7] = hasDeclined })
                end,
            },

            onEventFinish =
            {
                [33] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    else
                        quest:setVar(player, 'Option', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NORG] =
        {
            ['Laisrean'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SEA_SERPENT_STATUE) then
                        return quest:progressEvent(35, xi.ki.SEA_SERPENT_STATUE)
                    else
                        return quest:event(34)
                    end
                end,
            },

            onEventFinish =
            {
                [35] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.SEA_SERPENT_STATUE)
                    end
                end,
            },
        },

        [xi.zone.SEA_SERPENT_GROTTO] =
        {
            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.SEA_SERPENT_STATUE) then
                        return quest:progressEvent(1)
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.SEA_SERPENT_STATUE)
                end,
            },
        },

    },
}

return quest
