-----------------------------------
-- Regaining Trust
-- Ratoto !pos 27 -1 -32 244
-- Luto Mewrilah !pos -53 0 45 244
-- Raimbroy !pos -141 -3 34.6 230
-- Qm1 !pos 260 40 79 148
-----------------------------------
require('scripts/globals/items')
-- require("scripts/globals/pets/fellow")
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
-----------------------------------


local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.MIXED_SIGNALS)

quest.sections = {

    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
                and player:getQuestStatus(JEUNO, BLESSED_RADIANCE) == QUEST_COMPLETED
                and player:getFellowValue("level") >= 56
                and player:getFellowValue("bond") >= 80
        end,

        [xi.zone.UPPER_JEUNO] = {
            ['Ratoto'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(10078, {[7] = getFellowParam(player)})
                end,
            },

            onEventFinish = {
                [10078] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.UPPER_JEUNO] = {
            ['Luto_Mewrilah'] = {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(10079, {[7] = getFellowParam(player)})
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:event(10071, {[7] = getFellowParam(player)})
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(10080, {[7] = getFellowParam(player)})
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(10081, {[7] = getFellowParam(player)})
                    end
                end,
            },

            onEventFinish = {
                [10079] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
                [10080] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
                [10081] = function(player, csid, option, npc)
                    player:setFellowValue("lvlcap", 65)
                    quest:complete(player)
                    npcUtil.giveItem(player, quest.foodItem(player))
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] = {
            ['Raimbroy'] = {
                onTrigger = function(player, npc)
                    if quest:getVar(player, "Prog") == 1 then
                        return quest:progressEvent(780, {[7] = getFellowParam(player)})
                    end
                end,
            },

            onEventFinish = {
                [780] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.QULUN_DOME] = {
            ['qm1'] = {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(67, {[7] = getFellowParam(player)})
                    end
                end,
            },

            onEventFinish = {
                [67] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },
}

quest.foodItem = function(player)
    local item = player:getFellowValue("personality")
    local foodTable =
    {
        [4]  = xi.items.CHUNK_OF_HOMEMADE_CHEESE,
        [8]  = xi.items.HOMEMADE_STEAK,
        [12] = xi.items.CONE_OF_HOMEMADE_GELATO,
        [16] = xi.items.LOAF_OF_HOMEMADE_BREAD,
        [40] = xi.items.HOMEMADE_SALISBURY_STEAK,
        [44] = xi.items.HOMEMADE_OMELETTE,
        [20] = xi.items.PLATE_OF_HOMEMADE_RISOTTO,
        [24] = xi.items.HOMEMADE_RICE_BALL,
        [28] = xi.items.PITCHER_OF_HOMEMADE_HERBAL_TEA,
        [32] = xi.items.BOWL_OF_HOMEMADE_STEW,
        [36] = xi.items.PLATE_OF_HOMEMADE_SALAD,
        [48] = xi.items.DISH_OF_HOMEMADE_CARBONARA,
    }

    return foodTable[item]
end

return quest
