-----------------------------------
-- Lure of the Wildcat (San d'Oria)
-----------------------------------
-- !addquest 0 113
-- Amutiyaal : !pos 116 0.1 84 230
-----------------------------------
local southernSanDoriaID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT)

quest.reward =
{
    fame     = 150,
    fameArea = xi.fameArea.SANDORIA,
    keyItem  = xi.ki.RED_INVITATION_CARD,
}

local wildcatNpcData =
{
    ['Daggao'       ] = {  0, 810 }, -- !pos 89 0 119 230
    ['Authere'      ] = {  1, 809 }, -- !pos 33 1 -31 230
    ['Rouva'        ] = {  2, 808 }, -- !pos -17 2 10 230
    ['Femitte'      ] = {  3, 807 }, -- !pos -17 2 10 230
    ['Deraquien'    ] = {  4, 811 }, -- !pos -98 -2 31 230
    ['Giaunne'      ] = {  5, 805 }, -- !pos -13 0 36 231
    ['Anilla'       ] = {  6, 808 }, -- !pos 8 0.1 61 231
    ['Maloquedil'   ] = {  7, 807 }, -- !pos 35 0.1 60 231
    ['Phairupegiont'] = {  8, 806 }, -- !pos -46 0.1 76 231
    ['Bertenont'    ] = {  9, 809 }, -- !pos -165 0.1 226 231
    ['Perdiouvilet' ] = { 10, 750 }, -- !pos -59 -5 -29 232
    ['Pomilla'      ] = { 11, 749 }, -- !pos -38 -4 -55 232
    ['Cherlodeau'   ] = { 12, 748 }, -- !pos -20 -4 -69 232
    ['Parcarin'     ] = { 13, 747 }, -- !pos -9 -13 -151 232
    ['Rugiette'     ] = { 14, 746 }, -- !pos 71 -9 -73 232
    ['Curilla'      ] = { 15, 562 }, -- !pos 27 0.1 0.1 233
    ['Halver'       ] = { 16, 558 }, -- !pos 2 0.1 0.1 233
    ['Rahal'        ] = { 17, 559 }, -- !pos -28 0.1 -6 233
    ['Perfaumand'   ] = { 18, 560 }, -- !pos -39 -3 69 233
    ['Chalvatot'    ] = { 19, 561 }, -- !pos -105 0.1 72 233
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

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Amutiyaal'] = quest:progressEvent(812),

            onEventFinish =
            {
                [812] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.RED_SENTINEL_BADGE)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Chalvatot' ] = wildcatOnTrigger,
            ['Curilla'   ] = wildcatOnTrigger,
            ['Halver'    ] = wildcatOnTrigger,
            ['Perfaumand'] = wildcatOnTrigger,
            ['Rahal'     ] = wildcatOnTrigger,

            onEventFinish =
            {
                [558] = wildcatOnEventFinish,
                [559] = wildcatOnEventFinish,
                [560] = wildcatOnEventFinish,
                [561] = wildcatOnEventFinish,
                [562] = wildcatOnEventFinish,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Anilla'       ] = wildcatOnTrigger,
            ['Bertenont'    ] = wildcatOnTrigger,
            ['Giaunne'      ] = wildcatOnTrigger,
            ['Maloquedil'   ] = wildcatOnTrigger,
            ['Phairupegiont'] = wildcatOnTrigger,

            onEventFinish =
            {
                [805] = wildcatOnEventFinish,
                [806] = wildcatOnEventFinish,
                [807] = wildcatOnEventFinish,
                [808] = wildcatOnEventFinish,
                [809] = wildcatOnEventFinish,
            },
        },

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Cherlodeau'  ] = wildcatOnTrigger,
            ['Parcarin'    ] = wildcatOnTrigger,
            ['Perdiouvilet'] = wildcatOnTrigger,
            ['Pomilla'     ] = wildcatOnTrigger,
            ['Rugiette'    ] = wildcatOnTrigger,

            onEventFinish =
            {
                [746] = wildcatOnEventFinish,
                [747] = wildcatOnEventFinish,
                [748] = wildcatOnEventFinish,
                [749] = wildcatOnEventFinish,
                [750] = wildcatOnEventFinish,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Amutiyaal'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:event(813)
                    elseif utils.mask.isFull(questProgress, 20) then
                        return quest:progressEvent(815)
                    else
                        return quest:event(814)
                    end
                end,
            },

            ['Authere'  ] = wildcatOnTrigger,
            ['Daggao'   ] = wildcatOnTrigger,
            ['Deraquien'] = wildcatOnTrigger,
            ['Femitte'  ] = wildcatOnTrigger,
            ['Rouva'    ] = wildcatOnTrigger,

            onEventFinish =
            {
                [807] = wildcatOnEventFinish,
                [808] = wildcatOnEventFinish,
                [809] = wildcatOnEventFinish,
                [810] = wildcatOnEventFinish,
                [811] = wildcatOnEventFinish,

                [815] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.RED_SENTINEL_BADGE)
                    player:messageSpecial(southernSanDoriaID.text.KEYITEM_LOST, xi.ki.RED_SENTINEL_BADGE)

                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
