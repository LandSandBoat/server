-----------------------------------
-- Better The Demon You Know
-----------------------------------
-- Log ID: 4, Quest ID: 105
-- Koblakiq !pos -64.851 21.834 -117.521
-- qm2      !pos 19.4 -24.141 19.185
-----------------------------------
local zvahlID = zones[xi.zone.CASTLE_ZVAHL_BAILEYS]
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.BETTER_THE_DEMON_YOU_KNOW)

quest.reward =
{
    item = xi.item.GOBLIN_GRENADE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.FOR_THE_BIRDS) and
                not xi.quest.getMustZone(player, xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.FOR_THE_BIRDS)
        end,

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Koblakiq'] = quest:progressCutscene(20, 0, xi.item.DEMON_PEN),

            onEventFinish =
            {
                [20] = function(player, csid, option, npc)
                    quest:begin(player)
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
                    local waitTime = quest:getVar(player, 'Wait')

                    if progress == 0 then
                        return quest:event(21, 0, xi.item.DEMON_PEN):setPriority(101) -- Reminder to get Demon Pen
                    elseif progress == 1 then
                            if GetSystemTime() >= waitTime + 60 then
                                return quest:progressCutscene(24) -- Go to Castle Zvahl Baileys
                            else
                                return quest:event(23):setPriority(101) -- Wait Longer
                            end
                    elseif progress == 2 then
                        return quest:event(25):setPriority(101) -- Reminder to go to castle Zvahl Baileys
                    elseif progress == 3 then
                        return quest:progressCutscene(26)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, xi.item.DEMON_PEN) then
                        return quest:progressCutscene(22)
                    end
                end,
            },

            onEventFinish =
            {
                [22] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 1)
                    quest:setVar(player, 'Wait', GetSystemTime() + 60) -- 1 Minute wait time
                end,

                [24] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [26] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.ZEELOZOKS_EARPLUG)
                    end
                end,
            },
        },

        [xi.zone.CASTLE_ZVAHL_BAILEYS] =
        {
            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if
                        player:getLocalVar('NMKilled') == 1 and
                        progress == 2
                    then
                        player:addKeyItem(xi.ki.ZEELOZOKS_EARPLUG)
                        quest:setVar(player, 'Prog', 3)
                        return quest:messageSpecial(zvahlID.text.KEYITEM_OBTAINED, xi.ki.ZEELOZOKS_EARPLUG)
                    elseif
                        progress == 2 and
                        not GetMobByID(zvahlID.mob.MARQUIS_ANDREALPUS):isSpawned() and
                        not GetMobByID(zvahlID.mob.MARQUIS_ANDREALPUS + 1):isSpawned() and
                        not GetMobByID(zvahlID.mob.MARQUIS_ANDREALPUS + 2):isSpawned() and
                        not GetMobByID(zvahlID.mob.MARQUIS_ANDREALPUS + 3):isSpawned() and
                        not GetMobByID(zvahlID.mob.MARQUIS_ANDREALPUS + 4):isSpawned()
                    then
                        for i = 0, 4 do
                            SpawnMob(zvahlID.mob.MARQUIS_ANDREALPUS + i):updateClaim(player)
                        end

                        player:messageSpecial(zvahlID.text.MOBLIN_EARPLUG_ON_THE_GROUND)
                        return quest:messageSpecial(zvahlID.text.MARQUIS_ATTACKS)
                    end
                end,
            },

            ['Marquis_Andrealphus'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 2 then
                        player:setLocalVar('NMKilled', 1) -- If the player zones before getting the KI they need to refight the NM.
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Koblakiq'] = quest:event(27):replaceDefault()
        },
    },
}

return quest
