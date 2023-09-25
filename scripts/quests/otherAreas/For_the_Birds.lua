-----------------------------------
-- For the Birds
-----------------------------------
-- Log ID: 4, Quest ID: 104
-- Koblakiq          !pos -64 21 -117
-- Daa Bola the Seer !pos -157 -17 193
-- GeFhu Yagudoeye   !pos -91 -3 -127
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require('scripts/zones/Beadeaux/IDs')
-----------------------------------
local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.FOR_THE_BIRDS)

quest.reward =
{
    item = xi.items.JAGUAR_MANTLE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:hasCompletedQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.MISSIONARY_MOBLIN) and
            not quest:getMustZone(player)
        end,

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Koblakiq'] = quest:progressEvent(14, { [1] = xi.items.ARNICA_ROOT }),

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Koblakiq'] =
            {
                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')

                    if prog == 0 then
                        return quest:event(15, { [1] = xi.items.ARNICA_ROOT })
                    elseif prog == 1 and not player:hasKeyItem(xi.ki.GLITTERING_FRAGMENT) then
                        return quest:progressEvent(16, { [1] = xi.ki.GLITTERING_FRAGMENT })
                    elseif prog == 4 then
                        return quest:progressEvent(18)
                    elseif player:hasKeyItem(xi.ki.GLITTERING_FRAGMENT) then
                        return quest:event(17)
                    end
                end,
            },

            onEventFinish =
            {
                [16] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.GLITTERING_FRAGMENT)
                    quest:setVar(player, 'Prog', 2)
                end,

                [18] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.GLITTERING_FRAGMENT)
                        xi.quest.setMustZone(player, xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.BETTER_THE_DEMON_YOU_KNOW)
                    end
                end,
            },
        },

        [xi.zone.CASTLE_OZTROJA] =
        {
            ['Daa_Bola_the_Seer'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:event(86)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'Prog') == 0 and npcUtil.tradeHasExactly(trade, { xi.items.ARNICA_ROOT }) then
                        return quest:progressEvent(87, { [1] = xi.items.ARNICA_ROOT })
                    end
                end,
            },

            onEventFinish =
            {
                [87] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.BEADEAUX] =
        {
            ['GeFhu_Yagudoeye'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        player:hasKeyItem(xi.ki.GLITTERING_FRAGMENT) and
                        npcUtil.popFromQM(player, npc, ID.mob.FOR_THE_BIRDS_MOBS, { claim = true, hide = 0, })
                    then
                        return quest:message(ID.text.THE_QUADAV_ARE_ATTACKING)

                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(124)
                    end
                end,
            },

            ['Nickel_Quadav'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 2 then
                        quest:setVar(player, 'Prog', 3)
                    end
                end,
            },

            onEventFinish =
            {
                [124] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },
}

return quest
