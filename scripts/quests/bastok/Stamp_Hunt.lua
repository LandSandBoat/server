-----------------------------------
-- Stamp Hunt
-----------------------------------
-- Log ID: 1, Quest ID: 16
-- Arawn         : !pos -121.492 -4.000 -123.923 235
-- Pavel         : !pos -349.798 -10.002 -181.296 235
-- Deadly Spider : !pos -57.601 -8 -55.944 234
-- Tall Mountain : !pos 71 7 -7 234
-- Elayne        : !pos -36.414 8 -1.465 237
-- Romualdo      : !pos 135.035 -18.475 -37.419 237
-- Ehrhard       : !pos -70.661 4.898 44.886 236
-- Latifah       : !pos 51.241 7.499 -55.407 236
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.STAMP_HUNT)

quest.reward =
{
    fame = 50,
    fameArea = xi.quest.fame_area.BASTOK,
    item = xi.items.LEATHER_GORGET,
    title = xi.title.STAMPEDER,
}

local function progressOnUnsetBit(player, bitValue, eventID)
    if not quest:isVarBitsSet(player, 'Prog', bitValue) then
        return quest:progressEvent(eventID)
    end
end

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Arawn'] = quest:progressEvent(225),

            onEventFinish =
            {
                [225] = function(player, csid, option, npc)
                    if npcUtil.giveKeyItem(player, xi.ki.STAMP_SHEET) then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Arawn'] =
            {
                onTrigger = function(player, npc)
                    if quest:isVarBitsSet(player, 'Prog', 0, 1, 2, 3, 4, 5, 6) then
                        return quest:progressEvent(226)
                    end
                end,
            },

            ['Pavel'] =
            {
                onTrigger = function(player, npc)
                    return progressOnUnsetBit(player, 0, 227)
                end,
            },

            onEventFinish =
            {
                [226] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.STAMP_SHEET)
                    end
                end,

                [227] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Prog', 0)
                end,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Deadly_Spider'] =
            {
                onTrigger = function(player, npc)
                    return progressOnUnsetBit(player, 1, 86)
                end,
            },

            ['Tall_Mountain'] =
            {
                onTrigger = function(player, npc)
                    return progressOnUnsetBit(player, 2, 85)
                end,
            },

            onEventFinish =
            {
                [85] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Prog', 2)
                end,

                [86] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Elayne'] =
            {
                onTrigger = function(player, npc)
                    return progressOnUnsetBit(player, 3, 725)
                end,
            },

            ['Romualdo'] =
            {
                onTrigger = function(player, npc)
                    return progressOnUnsetBit(player, 4, 726)
                end,
            },

            onEventFinish =
            {
                [725] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Prog', 3)
                end,

                [726] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Ehrhard'] =
            {
                onTrigger = function(player, npc)
                    return progressOnUnsetBit(player, 5, 121)
                end,
            },

            ['Latifah'] =
            {
                onTrigger = function(player, npc)
                    return progressOnUnsetBit(player, 6, 120)
                end,
            },

            onEventFinish =
            {
                [120] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Prog', 6)
                end,

                [121] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Prog', 5)
                end,
            },
        },
    },
}

return quest
