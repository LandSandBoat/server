-----------------------------------
-- For the Birds
-----------------------------------
-- Log ID: 4, Quest ID: 104
-- Koblakiq          !pos -64 21 -117 11
-- Daa Bola the Seer !pos -157 -17 193 151
-- GeFhu Yagudoeye   !pos -91 -3 -127 147
-----------------------------------
local beadeauxID = zones[xi.zone.BEADEAUX]
-----------------------------------
local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.FOR_THE_BIRDS)
local quadavOffset = beadeauxID.mob.FOR_THE_BIRDS_MOBS

quest.reward =
{
    item = xi.item.JAGUAR_MANTLE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:hasCompletedQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.MISSIONARY_MOBLIN) and
            not quest:getMustZone(player)
        end,

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Koblakiq'] = quest:progressEvent(14, 0, xi.item.ARNICA_ROOT),

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
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Koblakiq'] =
            {
                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')

                    if prog == 0 then
                        return quest:event(15, 0, xi.item.ARNICA_ROOT)
                    elseif prog == 1 and not player:hasKeyItem(xi.ki.GLITTERING_FRAGMENT) then
                        return quest:progressEvent(16, 0, xi.ki.GLITTERING_FRAGMENT)
                    elseif prog == 2 then
                        return quest:event(17)
                    elseif prog == 3 then
                        return quest:progressEvent(18)
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
                        xi.quest.setMustZone(player, xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.BETTER_THE_DEMON_YOU_KNOW)
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
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        npcUtil.tradeHasExactly(trade, xi.item.ARNICA_ROOT)
                    then
                        return quest:progressEvent(87, 0, xi.item.ARNICA_ROOT)
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
                        npcUtil.popFromQM(player, npc, { quadavOffset, quadavOffset + 1, quadavOffset + 2, quadavOffset + 3 }, { claim = true, hide = 0 })
                    then
                        return quest:messageSpecial(beadeauxID.text.TAKEN_FROM_YOU, 0, xi.ki.GLITTERING_FRAGMENT)
                    elseif
                        quest:getVar(player, 'Prog') == 2 and
                        quest:getVar(player, 'magnes_nmKilled') == 1 and
                        quest:getVar(player, 'nickel_nmKilled') == 1
                    then
                        return quest:progressEvent(124)
                    end
                end,
            },

            ['Magnes_Quadav'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        GetMobByID(quadavOffset):isDead() and
                        GetMobByID(quadavOffset + 2):isDead()
                    then
                        quest:setVar(player, 'magnes_nmKilled', 1)
                    end
                end,
            },

            ['Nickel_Quadav'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        GetMobByID(quadavOffset + 1):isDead() and
                        GetMobByID(quadavOffset + 3):isDead()
                    then
                        quest:setVar(player, 'nickel_nmKilled', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [124] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    quest:setVar(player, 'magnes_nmKilled', 0)
                    quest:setVar(player, 'nickel_nmKilled', 0)
                end,
            },
        },
    },
}

return quest
