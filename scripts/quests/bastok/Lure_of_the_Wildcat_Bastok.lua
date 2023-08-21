-----------------------------------
-- Lure of the Wildcat (Bastok)
-----------------------------------
-- Log ID: 1, Quest ID: 84
-- Alib-Mufalib : !pos 116.08 7.372 -31.82 236
-----------------------------------
local portBastokID = zones[xi.zone.PORT_BASTOK]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LURE_OF_THE_WILDCAT)

quest.reward =
{
    fame     = 150,
    fameArea = xi.quest.fame_area.BASTOK,
    keyItem  = xi.ki.BLUE_INVITATION_CARD,
}

local wildcatNpcData =
{
    ['Kaede']             = {  0, 352 }, -- !pos 48 -6 67 236
    ['Patient_Wheel']     = {  1, 354 }, -- !pos -107.988 3.898 52.557 236
    ['Paujean']           = {  2, 355 }, -- !pos -93.738 4.649 34.373 236
    ['Hilda']             = {  3, 356 }, -- !pos -163 -8 13 236
    ['Tilian']            = {  4, 353 }, -- !pos -118.460 4.999 -68.090 236
    ['Raibaht']           = {  5, 933 }, -- !pos -27 -10 -1 237
    ['Invincible_Shield'] = {  6, 932 }, -- !pos -51.083 -11 2.126 237
    ['Manilam']           = {  7, 931 }, -- !pos -57.300 -11 22.332 237
    ['Kaela']             = {  8, 934 }, -- !pos 40.167 -14.999 16.073 237
    ['Ayame']             = {  9, 935 }, -- !pos 133 -19 34 237
    ['Harmodios']         = { 10, 430 }, -- !pos -79.928 -4.824 -135.114 235
    ['Arawn']             = { 11, 429 }, -- !pos -121.492 -4 -123.923 235
    ['Horatius']          = { 12, 428 }, -- !pos -158 -6 -117 235
    ['Ken']               = { 13, 432 }, -- !pos -340.857 -11.003 -149.008 235
    ['Pavel']             = { 14, 431 }, -- !pos -349.798 -10.002 -181.296 235
    ['Griselda']          = { 15, 507 }, -- !pos -25.749 -0.044 52.360 234
    ['Goraow']            = { 16, 506 }, -- !pos 38 0.1 14 234
    ['Echo_Hawk']         = { 17, 505 }, -- !pos -0.965 5.999 -15.567 234
    ['Deidogg']           = { 18, 504 }, -- !pos -13 7 29 234
    ['Vaghron']           = { 19, 503 }, -- !pos -39.162 -1 -92.147 234
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
            return status == QUEST_AVAILABLE and
                xi.settings.main.ENABLE_TOAU == 1
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Alib-Mufalib'] = quest:progressEvent(357),

            onEventFinish =
            {
                [357] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.BLUE_SENTINEL_BADGE)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Arawn']     = wildcatOnTrigger,
            ['Harmodios'] = wildcatOnTrigger,
            ['Horatius']  = wildcatOnTrigger,
            ['Ken']       = wildcatOnTrigger,
            ['Pavel']     = wildcatOnTrigger,

            onEventFinish =
            {
                [428] = wildcatOnEventFinish,
                [429] = wildcatOnEventFinish,
                [430] = wildcatOnEventFinish,
                [431] = wildcatOnEventFinish,
                [432] = wildcatOnEventFinish,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Deidogg']   = wildcatOnTrigger,
            ['Echo_Hawk'] = wildcatOnTrigger,
            ['Goraow']    = wildcatOnTrigger,
            ['Griselda']  = wildcatOnTrigger,
            ['Vaghron']   = wildcatOnTrigger,

            onEventFinish =
            {
                [503] = wildcatOnEventFinish,
                [504] = wildcatOnEventFinish,
                [505] = wildcatOnEventFinish,
                [506] = wildcatOnEventFinish,
                [507] = wildcatOnEventFinish,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Ayame']             = wildcatOnTrigger,
            ['Invincible_Shield'] = wildcatOnTrigger,
            ['Kaela']             = wildcatOnTrigger,
            ['Manilam']           = wildcatOnTrigger,
            ['Raibaht']           = wildcatOnTrigger,

            onEventFinish =
            {
                [931] = wildcatOnEventFinish,
                [932] = wildcatOnEventFinish,
                [933] = wildcatOnEventFinish,
                [934] = wildcatOnEventFinish,
                [935] = wildcatOnEventFinish,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Alib-Mufalib'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:event(358)
                    elseif utils.mask.isFull(questProgress, 20) then
                        return quest:progressEvent(360)
                    else
                        return quest:event(359)
                    end
                end,
            },

            ['Hilda']         = wildcatOnTrigger,
            ['Kaede']         = wildcatOnTrigger,
            ['Patient_Wheel'] = wildcatOnTrigger,
            ['Paujean']       = wildcatOnTrigger,
            ['Tilian']        = wildcatOnTrigger,

            onEventFinish =
            {
                [352] = wildcatOnEventFinish,
                [353] = wildcatOnEventFinish,
                [354] = wildcatOnEventFinish,
                [355] = wildcatOnEventFinish,
                [356] = wildcatOnEventFinish,

                [360] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.BLUE_SENTINEL_BADGE)
                    player:messageSpecial(portBastokID.text.KEYITEM_LOST, xi.ki.BLUE_SENTINEL_BADGE)

                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
