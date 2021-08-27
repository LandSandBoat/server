-----------------------------------
-- Three Men and a Closet
-- Kubhe Ijyuhla !pos 23.257 0 21.532 50
-- Ratihb !pos 75 -6 -135 50
-- Tehf Kimasnahya !pos -89.897 -1 6.199 50
-- Ekhu Pesshyadha !pos -13.043 0.999 103.423 50
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.THREE_MEN_AND_A_CLOSET)

quest.reward = {
    item = xi.items.IMPERIAL_BRONZE_PIECE,
}

quest.sections = {
    -- Section: Begin quest
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.GOT_IT_ALL) == QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] = {
            ['Kubhe_Ijyuhla'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(player, 836)
                end
            },

            onEventFinish = {
                [836] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Questing
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] = {
            ['Kubhe_Ijyuhla'] = {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:event(837)
                    elseif progress == 1 then
                        return quest:progressEvent(838)
                    elseif progress == 2 then
                        return quest:event(839)
                    elseif progress == 3 then
                        return quest:event(842)
                    elseif progress == 4 then
                        return quest:progressEvent(845)
                    end
                end,
            },

            ['Tehf_Kimasnahya'] = {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 3 then
                        return quest:progressEvent(843)
                    elseif progress == 4 then
                        return quest:event(844)
                    end
                end,
            },

            ['Ratihb'] = {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 2 then
                        return quest:progressEvent(840)
                    elseif progress == 3 then
                        return quest:event(841)
                    end
                end,
            },

            onEventFinish = {
                [838] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [840] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [843] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,

                [845] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.WAJAOM_WOODLANDS] = {
            onZoneIn = {
                function(player, prevZone)
                    if prevZone == xi.zone.AHT_URHGAN_WHITEGATE and quest:getVar(player, 'Prog') == 0 then
                        return 510
                    end
                end,
            },

            onEventFinish = {
                [510] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    -- Section: Completed quest
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] = {
            ['Kubhe_Ijyuhla'] = quest:event(846),
        }
    }
}

return quest
