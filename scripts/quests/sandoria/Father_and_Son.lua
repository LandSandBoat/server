-----------------------------------
-- Father and Son
-----------------------------------
-- Log ID: 0, Quest ID: 4
-- Ailbeche : !pos 4 -1 24 231
-- Exoroche : !pos 72 -1 60 230
-----------------------------------
local northenSandoriaID = zones[xi.zone.NORTHERN_SAN_DORIA]
local southernSandoriaID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.FATHER_AND_SON)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    item = xi.item.WILLOW_FISHING_ROD,
    title = xi.title.LOST_CHILD_OFFICER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Ailbeche'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(508)
                end,
            },

            onEventFinish =
            {
                [508] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Ailbeche'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(509)
                    else
                        return quest:messageSpecial(northenSandoriaID.text.AILBECHE_FATHER_WHERE):progress()
                    end
                end,
            },

            onEventFinish =
            {
                [509] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        -- Progress for Part 2 of the quest (after complete).  This variable is cleaned
                        -- up after the trade event, and is blocking for PLD AF1 quest start.
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Exoroche'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(542)
                    else
                        return quest:messageSpecial(southernSandoriaID.text.EXOROCHE_PLEASE_TELL):progress()
                    end
                end,
            },

            onEventFinish =
            {
                [542] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Ailbeche'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        npcUtil.tradeHasExactly(trade, xi.item.WILLOW_FISHING_ROD)
                    then
                        return quest:progressEvent(61)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:messageSpecial(northenSandoriaID.text.AILBECHE_WHEN_FISHING):replaceDefault()
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:messageSpecial(northenSandoriaID.text.OH_I_WANT_MY_ITEM, xi.item.WILLOW_FISHING_ROD):progress()
                    end
                end,
            },

            onEventFinish =
            {
                [61] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:addTitle(xi.title.FAMILY_COUNSELOR)
                    quest:setVar(player, 'Prog', 0)
                end,
            },
        },
    },
}

return quest
