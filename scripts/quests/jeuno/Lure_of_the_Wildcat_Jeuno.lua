-----------------------------------
-- Lure of the Wildcat (Jeuno)
-----------------------------------
-- !addquest 3 90
-- Ajithaam : !pos -82 0.1 160 244
-----------------------------------
local upperJeunoID = zones[xi.zone.UPPER_JEUNO]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.LURE_OF_THE_WILDCAT)

quest.reward =
{
    fame     = 150,
    fameArea = xi.quest.fame_area.JEUNO,
    keyItem  = xi.ki.WHITE_INVITATION_CARD,
}

local wildcatNpcData =
{
    ['Albiona']       = {  0, 10089 }, -- !pos -4.363 8.999 -31.901 243
    ['Crooked_Arrow'] = {  1, 10090 }, -- !pos -34.9 2.999 -10.877 243
    ['Muhoho']        = {  2, 10093 }, -- !pos -4.808 -4.999 27.83 243
    ['Adolie']        = {  3, 10091 }, -- !pos -35 2 59 243
    ['Yavoraile']     = {  4, 10092 }, -- !pos 30.173 2 68.864 243
    ['Sibila-Mobla']  = {  5, 10083 }, -- !pos -52.531 0 122.68 244
    ['Shiroro']       = {  6, 10084 }, -- !pos -72.632 -1.2 52.905 244
    ['Luto_Mewrilah'] = {  7, 10085 }, -- !pos -53 0 45 244
    ['Renik']         = {  8, 10086 }, -- !pos -14.672 0 38.624 244
    ['Hinda']         = {  9, 10087 }, -- !pos -25.605 -1.499 19.891 244
    ['Sutarara']      = { 10, 10055 }, -- !pos 30 0.1 -2 245
    ['Saprut']        = { 11, 10054 }, -- !pos 2.257 -5.999 -16.434 245
    ['Bluffnix']      = { 12, 10056 }, -- !pos -43.099 5.9 -114.788 245
    ['Naruru']        = { 13, 10053 }, -- !pos -56 0.1 -138 245
    ['Gurdern']       = { 14, 10052 }, -- !pos -98.021 0 -142.601 245
    ['Red_Ghost']     = { 15,   314 }, -- !pos -96.503 0 7.688 246
    ['Karl']          = { 16,   316 }, -- !pos -60 0.1 -8 246
    ['Shami']         = { 17,   317 }, -- !pos -53.9 0 10.8 246
    ['Rinzei']        = { 18,   315 }, -- !pos -14.388 0 -9.156 246
    ['Sagheera']      = { 19,   313 }, -- !pos -3 0.1 -9 246
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

        [xi.zone.UPPER_JEUNO] =
        {
            ['Ajithaam'] = quest:progressEvent(10088),

            onEventFinish =
            {
                [10088] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.WHITE_SENTINEL_BADGE)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Bluffnix'] = wildcatOnTrigger,
            ['Gurdern']  = wildcatOnTrigger,
            ['Naruru']   = wildcatOnTrigger,
            ['Saprut']   = wildcatOnTrigger,
            ['Sutarara'] = wildcatOnTrigger,

            onEventFinish =
            {
                [10052] = wildcatOnEventFinish,
                [10053] = wildcatOnEventFinish,
                [10054] = wildcatOnEventFinish,
                [10055] = wildcatOnEventFinish,
                [10056] = wildcatOnEventFinish,
            },
        },

        [xi.zone.PORT_JEUNO] =
        {
            ['Karl']      = wildcatOnTrigger,
            ['Red_Ghost'] = wildcatOnTrigger,
            ['Rinzei']    = wildcatOnTrigger,
            ['Sagheera']  = wildcatOnTrigger,
            ['Shami']     = wildcatOnTrigger,

            onEventFinish =
            {
                [313] = wildcatOnEventFinish,
                [314] = wildcatOnEventFinish,
                [315] = wildcatOnEventFinish,
                [316] = wildcatOnEventFinish,
                [317] = wildcatOnEventFinish,
            },
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Adolie']        = wildcatOnTrigger,
            ['Albiona']       = wildcatOnTrigger,
            ['Crooked_Arrow'] = wildcatOnTrigger,
            ['Muhoho']        = wildcatOnTrigger,
            ['Yavoraile']     = wildcatOnTrigger,

            onEventFinish =
            {
                [10089] = wildcatOnEventFinish,
                [10090] = wildcatOnEventFinish,
                [10091] = wildcatOnEventFinish,
                [10092] = wildcatOnEventFinish,
                [10093] = wildcatOnEventFinish,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Ajithaam'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:event(10089)
                    elseif utils.mask.isFull(questProgress, 20) then
                        return quest:progressEvent(10091)
                    else
                        return quest:event(10090)
                    end
                end,
            },

            ['Hinda']         = wildcatOnTrigger,
            ['Luto_Mewrilah'] = wildcatOnTrigger,
            ['Renik']         = wildcatOnTrigger,
            ['Shiroro']       = wildcatOnTrigger,
            ['Sibila-Mobla']  = wildcatOnTrigger,

            onEventFinish =
            {
                [10083] = wildcatOnEventFinish,
                [10084] = wildcatOnEventFinish,
                [10085] = wildcatOnEventFinish,
                [10086] = wildcatOnEventFinish,
                [10087] = wildcatOnEventFinish,

                [10091] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.WHITE_SENTINEL_BADGE)
                    player:messageSpecial(upperJeunoID.text.KEYITEM_LOST, xi.ki.WHITE_SENTINEL_BADGE)

                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
