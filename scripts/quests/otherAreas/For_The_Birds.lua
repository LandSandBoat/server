-----------------------------------
-- For the Birds
-----------------------------------
-- Log ID: 4, Quest ID: 104
-- Koblakiq          !pos -64.851 21.834 -117.521
-- Daa Bola the Seer !pos -159.69 -16.26 191.923
-- GeFhu Yagudoeye   !pos -91.354 -3.251 -127.831
-----------------------------------
local castleID   = zones[xi.zone.CASTLE_OZTROJA]
local beadeauxID = zones[xi.zone.BEADEAUX]
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.FOR_THE_BIRDS)

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
                not xi.quest.getMustZone(player, xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.MISSIONARY_MOBLIN)
        end,

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Koblakiq'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressCutscene(14, 0, xi.item.ARNICA_ROOT)
                end,
            },

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
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:event(15) -- Reminder
                    elseif progress == 1 then
                        return quest:progressEvent(16, 0, xi.ki.GLITTERING_FRAGMENT)
                    elseif progress == 2 then
                        return quest:event(17) -- Reminder
                    elseif progress == 4 then
                        return quest:progressCutscene(18)
                    end
                end,
            },

            onEventFinish =
            {
                [16] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    npcUtil.giveKeyItem(player, xi.ki.GLITTERING_FRAGMENT)
                end,

                [18] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        quest:setMustZone(player)
                    end
                end,
            },
        },

        [xi.zone.CASTLE_OZTROJA] =
        {
            ['Daa_Bola_the_Seer'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, xi.item.ARNICA_ROOT) then
                        return quest:progressCutscene(87)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:event(86)
                    elseif quest:getMustZone(player) then
                        return quest:messageSpecial(castleID.text.LETTING_YOU_GO)
                    end
                end,
            },

            onEventFinish =
            {
                [87] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 1)
                    quest:setMustZone(player)
                end,
            },
        },

        [xi.zone.BEADEAUX] =
        {
            ['GeFhu_Yagudoeye'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if
                        progress == 3 and
                        quest:getVar(player, 'Option') == 4
                    then
                        return quest:progressCutscene(124)
                    elseif
                        progress == 2 and
                        not GetMobByID(beadeauxID.mob.MAGNES_QUADAV_NM):isSpawned() and
                        not GetMobByID(beadeauxID.mob.MAGNES_QUADAV_NM + 1):isSpawned() and
                        not GetMobByID(beadeauxID.mob.NICKEL_QUADAV_NM):isSpawned() and
                        not GetMobByID(beadeauxID.mob.NICKEL_QUADAV_NM + 1):isSpawned()
                    then
                        quest:setVar(player, 'Prog', 3)
                        for
                            i = 0, 3 do SpawnMob(beadeauxID.mob.MAGNES_QUADAV_NM + i):updateClaim(player)
                        end

                        player:delKeyItem(xi.ki.GLITTERING_FRAGMENT)
                        player:messageSpecial(beadeauxID.text.TAKEN_FROM_YOU, 0, xi.ki.GLITTERING_FRAGMENT)
                        return quest:messageSpecial(beadeauxID.text.QUADAV_ARE_ATTACKING)
                    elseif
                        progress == 3 and
                        not GetMobByID(beadeauxID.mob.MAGNES_QUADAV_NM):isSpawned() and
                        not GetMobByID(beadeauxID.mob.MAGNES_QUADAV_NM + 1):isSpawned() and
                        not GetMobByID(beadeauxID.mob.NICKEL_QUADAV_NM):isSpawned() and
                        not GetMobByID(beadeauxID.mob.NICKEL_QUADAV_NM + 1):isSpawned()
                    then
                        for
                            i = 0, 3 do SpawnMob(beadeauxID.mob.MAGNES_QUADAV_NM + i):updateClaim(player)
                        end

                        return quest:noAction()
                    end
                end,
            },

            ['Magnes_Quadav_NM'] =
            {
                onMobDeath = function(mob, player, optParams)
                    local questOption = quest:getVar(player, 'Option')

                    if quest:getVar(player, 'Prog') == 3 then
                        quest:setVar(player, 'Option', questOption + 1)
                    end
                end,
            },

            ['Nickel_Quadav_NM'] =
            {
                onMobDeath = function(mob, player, optParams)
                    local questOption = quest:getVar(player, 'Option')

                    if quest:getVar(player, 'Prog') == 3 then
                        quest:setVar(player, 'Option', questOption + 1)
                    end
                end,
            },

            onZoneOut = function(player)
                if quest:getVar(player, 'Prog') >= 2 then
                    quest:setVar(player, 'Option', 0)
                end
            end,

            onEventFinish =
            {
                [124] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                quest:getMustZone(player)
        end,

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Koblakiq'] = quest:event(19),
        },
    },
}

return quest
