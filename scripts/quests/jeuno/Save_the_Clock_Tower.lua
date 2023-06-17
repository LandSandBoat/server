-----------------------------------
-- Save the Clock Tower
-----------------------------------
-- Log ID: 3, Quest ID: 3
-- Derrick : !pos -32 -1 -7 245
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_THE_CLOCK_TOWER)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    title    = xi.title.CLOCK_TOWER_PRESERVATIONIST,
}

local petitionNpcData =
{
    ['Pitantimand']     = { 0,  64 }, -- !pos -63 8 46 246
    ['Teigero-Bangero'] = { 1,  74 }, -- !pos -58 0 -143 245
    ['Zauko']           = { 2,  50 }, -- !pos -3 0 11 245
    ['Baudin']          = { 3, 177 }, -- !pos -75 0 80 244
    ['Collet']          = { 4, 115 }, -- !pos -44 0 107 244
    ['Constance']       = { 5, 180 }, -- !pos -48 0 4 244
    ['Monberaux']       = { 6,  91 }, -- !pos -43 0 -1 244
    ['Souren']          = { 7, 182 }, -- !pos -51 0 4 244
    ['Zuber']           = { 8, 126 }, -- !pos -106 0 90 244
    ['Radeivepart']     = { 9, 160 }, -- !pos 5 9 -39 243
}

local petitionOnTrade = function(player, npc, trade)
    local npcData = petitionNpcData[npc:getName()]

    if
        npcUtil.tradeHasExactly(trade, xi.items.CLOCK_TOWER_PETITION) and
        not quest:isVarBitsSet(player, 'Prog', npcData[1])
    then
        return quest:progressEvent(npcData[2], 9 - utils.mask.countBits(quest:getVar(player, 'Prog')))
    end
end

local petitionNpc =
{
    onTrade = petitionOnTrade,
}

local petitionOnEventFinish = function(player, csid, option, npc)
    quest:setVarBit(player, 'Prog', petitionNpcData[npc:getName()][1])
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_CLOCK_MOST_DELICATE) and
                player:getFameLevel(xi.quest.fame_area.JEUNO) >= 5
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Derrick'] =
            {
                onTrigger = function(player, npc)
                    local hasAirshipPass = player:hasKeyItem(xi.ki.AIRSHIP_PASS) and 2 or 0

                    return quest:progressEvent(230, 8 + hasAirshipPass, 10)
                end,
            },

            onEventFinish =
            {
                [230] = function(player, csid, option, npc)
                    if
                        option == 20 and
                        npcUtil.giveItem(player, xi.items.CLOCK_TOWER_PETITION)
                    then
                        quest:begin(player)
                    end
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Collet'] = quest:event(164),
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Derrick'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.CLOCK_TOWER_PETITION) and
                        utils.mask.countBits(quest:getVar(player, 'Prog')) == 10
                    then
                        return quest:progressEvent(231)
                    end
                end,

                onTrigger = function(player, npc)
                    local hasAirshipPass = player:hasKeyItem(xi.ki.AIRSHIP_PASS) and 2 or 0

                    return quest:progressEvent(230, 4 + hasAirshipPass, 10)
                end,
            },

            ['Teigero-Bangero'] = petitionNpc,
            ['Zauko']           = petitionNpc,

            onEventFinish =
            {
                [50] = petitionOnEventFinish,
                [74] = petitionOnEventFinish,

                [230] = function(player, csid, option, npc)
                    -- TODO: Verify if petition should be reset if the player still has one
                    -- in their inventory.

                    if
                        option == 30 and
                        npcUtil.giveItem(player, xi.items.CLOCK_TOWER_PETITION)
                    then
                        quest:setVar(player, 'Prog', 0)
                    end
                end,

                [231] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },

        [xi.zone.PORT_JEUNO] =
        {
            ['Pitantimand'] = petitionNpc,

            onEventFinish =
            {
                [64] = petitionOnEventFinish,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Baudin']    = petitionNpc,
            ['Collet']    = petitionNpc,
            ['Constance'] = petitionNpc,
            ['Monberaux'] = petitionNpc,
            ['Zuber']     = petitionNpc,

            ['Souren'] =
            {
                onTrade   = petitionOnTrade,
                onTrigger = quest:event(120),
            },

            onEventFinish =
            {
                [ 91] = petitionOnEventFinish,
                [115] = petitionOnEventFinish,
                [126] = petitionOnEventFinish,
                [177] = petitionOnEventFinish,
                [180] = petitionOnEventFinish,
                [182] = petitionOnEventFinish,
            },
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Radeivepart'] = petitionNpc,

            onEventFinish =
            {
                [160] = petitionOnEventFinish,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Souren'] = quest:event(181):replaceDefault(),
        },
    },
}

return quest
