-----------------------------------
-- Got It All
-- Tehf Kimasnahya !pos -89.897 -1 6.199 50
-- Ekhu Pesshyadha !pos -13.043 0.999 103.423 50
-- Zabahf !pos -90.070 -1 10.140 50
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.GOT_IT_ALL)

quest.reward = {
    item = xi.items.BIBIKI_SEASHELL,
}

quest.sections = {
    -- Section: Begin quest
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] = {
            ['Tehf_Kimasnahya'] = quest:progressEvent(520),
            ['Ekhu_Pesshyadha'] = quest:event(532),
            ['Zabahf'] = quest:event(533),

            onEventFinish = {
                [520] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
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
            ['Tehf_Kimasnahya'] = {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress < 4 then
                        return quest:event(521)
                    elseif progress == 4 then
                        return quest:progressEvent(525)
                    elseif progress == 5 then
                        return quest:event(534)
                    elseif progress == 6 then
                        return quest:progressEvent(527)
                    elseif progress == 7 then
                        if not player:needToZone() and quest:getVar(player, 'Stage') < os.time() then
                            return quest:progressEvent(528)
                        else
                            return quest:event(539)
                        end
                    end
                end,
            },

            ['Ekhu_Pesshyadha'] = {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 1 then
                        return quest:progressEvent(522)
                    elseif progress == 2 then
                        return quest:event(536)
                    elseif progress == 3 then
                        return quest:progressEvent(524)
                    elseif progress >= 4 then
                        return quest:event(537)
                    end
                end,
            },

            ['Zabahf'] = {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 2 then
                        return quest:progressEvent(523)
                    elseif progress == 5 then
                        return quest:event(538)
                    elseif progress == 6 then
                        return quest:event(540)
                    elseif progress == 7 then
                        return quest:event(535)
                    else
                        return quest:event(533)
                    end
                end,
            },

            onRegionEnter = {
                [1] = function(player, region)
                    if quest:getVar(player, 'Prog') == 5 then
                        return quest:progressEvent(526)
                    end
                end,
            },

            onEventFinish = {
                [522] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [523] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [524] = function(player, csid, option, npc)
                    if npcUtil.giveKeyItem(player, xi.ki.VIAL_OF_LUMINOUS_WATER) then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,

                [525] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 5)
                        player:delKeyItem(xi.ki.VIAL_OF_LUMINOUS_WATER)
                    end
                end,

                [526] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                    player:setPos(60, 0, -71, 38)
                end,

                [527] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 7)
                    quest:setVar(player, 'Stage', getMidnight())
                    player:needToZone(true)
                end,

                [528] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },

    -- Section: After completion
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] = {
            ['Ekhu_Pesshyadha'] = {
                onTrigger = function(player, npc)
                    return quest:event(531)
                end,
            },
        },
    },
}

return quest
