-----------------------------------
-- Lure of the Wildcat (Windurst)
-----------------------------------
-- !addquest 2 94
-- Ibwam : !pos -25.655 1.749 -60.651 241
-----------------------------------
local windurstWoodsID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT)

quest.reward =
{
    fame     = 150,
    fameArea = xi.fameArea.WINDURST,
    keyItem  = xi.ki.GREEN_INVITATION_CARD,
}

local wildcatNpcData =
{
    ['Soni-Muni'        ] = {  0, 735 }, -- !pos -17.073 1.749 -59.327 241
    ['Etsa_Rhuyuli'     ] = {  1, 734 }, -- !pos 62.482 -8.499 -139.836 241
    ['Cayu_Pensharhumi' ] = {  2, 733 }, -- !pos 39.437 -0.91 -40.808 241
    ['Umumu'            ] = {  3, 731 }, -- !pos 32.575 -5.25 141.372 241
    ['Nanaa_Mihgo'      ] = {  4, 732 }, -- !pos 62 -4 240 241
    ['Yoriri'           ] = {  5, 496 }, -- !pos 65.268 -8.5 -58.309 239
    ['Shantotto'        ] = {  6, 498 }, -- !pos 122 -2 112 239
    ['Moan-Maon'        ] = {  7, 497 }, -- !pos 88.244 -6.32 148.912 239
    ['Chomomo'          ] = {  8, 499 }, -- !pos -1.262 -11 290.224 239
    ['Naih_Arihmepp'    ] = {  9, 500 }, -- !pos -64.578 -13.465 202.147 239
    ['Npopo'            ] = { 10, 936 }, -- !pos -35.464 -5.999 239.12 238
    ['Lago-Charago'     ] = { 11, 940 }, -- !pos -57.271 -11.75 92.503 238
    ['Amagusa-Chigurusa'] = { 12, 937 }, -- !pos -28.746 -4.5 61.954 238
    ['Funpo-Shipo'      ] = { 13, 938 }, -- !pos -44.091 -4.499 41.728 238
    ['Kyume-Romeh'      ] = { 14, 939 }, -- !pos -58 -4 23 238
    ['Kunchichi'        ] = { 15, 623 }, -- !pos -115.933 -4.25 109.533 240
    ['Yaman-Hachuman'   ] = { 16, 624 }, -- !pos -101.209 -4.25 110.886 240
    ['Choyi_Totlihpa'   ] = { 17, 622 }, -- !pos -58.927 -5.732 132.819 240
    ['Three_of_Clubs'   ] = { 18, 625 }, -- !pos -7.238 -5 106.982 240
    ['Yujuju'           ] = { 19, 621 }, -- !pos 201.523 -4.785 138.978 240
}

local wildcatOnTrigger = function(player, npc)
    local npcData = wildcatNpcData[npc:getName()]

    if not quest:isVarBitsSet(player, 'Prog', npcData[1]) then
        return quest:progressEvent(npcData[2])
    end
end

local wildcatOnEventFinish = function(player, csid, option, npc)
    quest:setVarBit(player, 'Prog', wildcatNpcData[npc:getName()][1])
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                xi.settings.main.ENABLE_TOAU == 1
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Ibwam'] = quest:progressEvent(736),

            onEventFinish =
            {
                [736] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.GREEN_SENTINEL_BADGE)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Choyi_Totlihpa'] = wildcatOnTrigger,
            ['Kunchichi'     ] = wildcatOnTrigger,
            ['Three_of_Clubs'] = wildcatOnTrigger,
            ['Yaman-Hachuman'] = wildcatOnTrigger,
            ['Yujuju'        ] = wildcatOnTrigger,

            onEventFinish =
            {
                [621] = wildcatOnEventFinish,
                [622] = wildcatOnEventFinish,
                [623] = wildcatOnEventFinish,
                [624] = wildcatOnEventFinish,
                [625] = wildcatOnEventFinish,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Chomomo'      ] = wildcatOnTrigger,
            ['Moan-Maon'    ] = wildcatOnTrigger,
            ['Naih_Arihmepp'] = wildcatOnTrigger,
            ['Shantotto'    ] = wildcatOnTrigger,
            ['Yoriri'       ] = wildcatOnTrigger,

            onEventFinish =
            {
                [496] = wildcatOnEventFinish,
                [497] = wildcatOnEventFinish,
                [498] = wildcatOnEventFinish,
                [499] = wildcatOnEventFinish,
                [500] = wildcatOnEventFinish,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Amagusa-Chigurusa'] = wildcatOnTrigger,
            ['Funpo-Shipo'      ] = wildcatOnTrigger,
            ['Kyume-Romeh'      ] = wildcatOnTrigger,
            ['Lago-Charago'     ] = wildcatOnTrigger,
            ['Npopo'            ] = wildcatOnTrigger,

            onEventFinish =
            {
                [936] = wildcatOnEventFinish,
                [937] = wildcatOnEventFinish,
                [938] = wildcatOnEventFinish,
                [939] = wildcatOnEventFinish,
                [940] = wildcatOnEventFinish,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Ibwam'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:event(737)
                    elseif utils.mask.isFull(questProgress, 20) then
                        return quest:progressEvent(739)
                    else
                        return quest:event(738)
                    end
                end,
            },

            ['Cayu_Pensharhumi'] = wildcatOnTrigger,
            ['Etsa_Rhuyuli'    ] = wildcatOnTrigger,
            ['Nanaa_Mihgo'     ] = wildcatOnTrigger,
            ['Soni-Muni'       ] = wildcatOnTrigger,
            ['Umumu'           ] = wildcatOnTrigger,

            onEventFinish =
            {
                [731] = wildcatOnEventFinish,
                [732] = wildcatOnEventFinish,
                [733] = wildcatOnEventFinish,
                [734] = wildcatOnEventFinish,
                [735] = wildcatOnEventFinish,

                [739] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.GREEN_SENTINEL_BADGE)
                    player:messageSpecial(windurstWoodsID.text.KEYITEM_LOST, xi.ki.GREEN_SENTINEL_BADGE)

                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
