-----------------------------------
-- Her Memories: Of Malign Maladies
-----------------------------------
-- !addquest 7 72
-- Amaura       : !pos -84.367 -6.949 91.148 230
-- Monberaux    : !pos -42 0 -2 244
-- Library Book : !pos -16.17 -6.25 112.289 238
-- Fey Blossoms : !pos -141.312 -6.75 564.417 89
-- Raustigne    : !pos 3.979 -1.999 44.456 80
-----------------------------------
require('scripts/missions/wotg/helpers')
-----------------------------------
local graubergID = zones[xi.zone.GRAUBERG_S]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.HER_MEMORIES_OF_MALIGN_MALADIES)

quest.reward =
{
    keyItem = xi.ki.LARGE_MEMORY_FRAGMENT2,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getCurrentMission(xi.mission.log_id.WOTG) == xi.mission.id.wotg.HER_MEMORIES
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Amaura'] = quest:progressEvent(955, 649992904, 0, 0, 0, 156286100, 19935, 0, 4),

            onEventFinish =
            {
                [955] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Amaura'] = quest:event(956, 649993042, 0, 27830, 94060, 0, 0, 0, 0):oncePerZone(),
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Monberaux'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(10190, 244, 1, 40, 0, 62914449, 41076209, 4095, 131105)
                    else
                        return quest:event(10191, 244, 1, 255, 0, 65339391, 27831, 4095, 131105)
                    end
                end,
            },

            onEventFinish =
            {
                [10190] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Library_book3'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 1 then
                        return quest:progressEvent(1017, 650060514, 0, 0, 0, 110, 6312479, 4095, 128)
                    elseif questProgress == 2 then
                        return quest:event(1018, 650060691, 0, 0, 0, 65863679, 4104166, 4095, 4)
                    end
                end,
            },

            onEventFinish =
            {
                [1017] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.GRAUBERG_S] =
        {
            ['Fey_Blossoms'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.PHILOSOPHERS_STONE) and
                        quest:getVar(player, 'Prog') == 2
                    then
                        return quest:progressEvent(30, 89, 23, 2964, 56, 0, 6029313, 0, 0)
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 2 then
                        return quest:messageSpecial(graubergID.text.SUITABLE_PLACE_TO_SOAK, xi.item.PHILOSOPHERS_STONE)
                    elseif
                        questProgress == 3 and
                        not player:hasKeyItem(xi.ki.FEY_STONE)
                    then
                        if quest:getVar(player, 'Timer') <= VanadielUniqueDay() then
                            return quest:progressEvent(32, 89, 6, 0, 56, 0, 6029328, 0, 0)
                        else
                            return quest:event(31, 89, 23, 2964, 56, 0, 6029313, 0, 0)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [30] = function(player, csid, option, npc)
                    player:confirmTrade()

                    quest:setVar(player, 'Prog', 3)
                    quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                end,

                [32] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.FEY_STONE)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Raustigne'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.FEY_STONE) then
                        return quest:progressEvent(169, 80, 23, 1756, 0, 67108863, 85453257, 3903, 131140)
                    end
                end,
            },

            onEventFinish =
            {
                [169] = function(player, csid, option, npc)
                    xi.wotg.helpers.checkMemoryFragments(player)

                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.FEY_STONE)
                    end
                end,
            },
        },
    },
}

return quest
