-----------------------------------
-- An Affable Adamantking
-----------------------------------
-- Log ID: 4, Quest ID: 107
-- Beadeaux Zone     : !pos -45 24 60 147
-- Peshi Yohnts      : !pos -6 -6 -145 241
-- Beastmen's Banner : !pos 10 25 -50 148
-----------------------------------
-- !addquest 4 107
-- !addItem 885 -- Turtle Shell
-- !addItem 1637 -- Bugard Leather
-- !addItem 15201 -- Quadav Barbut
-----------------------------------
local qulunDomeID  = zones[xi.zone.QULUN_DOME]
local windurstWoodsID  = zones[xi.zone.WINDURST_WOODS]
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.AN_AFFABLE_ADAMANTKING)

quest.reward =
{
    title = xi.title.BRONZE_QUADAV,
    item = xi.item.DAVHUS_BARBUT
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.A_GENEROUS_GENERAL) ~= xi.questStatus.QUEST_ACCEPTED and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.AN_UNDERSTANDING_OVERLORD) ~= xi.questStatus.QUEST_ACCEPTED and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.A_MORAL_MANIFEST) ~= xi.questStatus.QUEST_ACCEPTED and
                player:getVar('BstHeadGearQuest_Conquest') < NextConquestTally() and
                not player:hasItem(xi.item.DAVHUS_BARBUT) and
                player:getMainLvl() >= 60
        end,

        [xi.zone.QULUN_DOME] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local pos = player:getPos()
                    if
                        pos.x >= 0 and
                        pos.y >= 20 and
                        pos.z >= 55 and
                        pos.x <= 6 and
                        pos.y <= 25 and
                        pos.z <= 65
                    then
                        return 60
                    end
                end,
            },

            onEventFinish =
            {
                [60] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player) -- begin quest
                    elseif option == 1 then
                        player:setVar('BstHeadGearQuest_Conquest', NextConquestTally()) -- if player declines they must wait until next conquest tally
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Peshi_Yohnts'] =
            {
                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')
                    local partsWait = quest:getVar(player, 'partsWait')
                    if prog == 0 then
                        return quest:progressEvent(710) -- tells player what items are needed
                    elseif prog == 1 then
                        return quest:event(711):importantOnce() -- reminder to get bugard leather and turtle shell or cancel quest
                    elseif
                        prog >= 2 and
                        partsWait ~= 0 -- player is currently waiting for parts
                    then
                        if
                            partsWait <= os.time() and
                            not quest:getMustZone(player)
                        then
                            return quest:progressEvent(715) -- ready to go
                        else
                            return quest:event(713):importantOnce() -- player must wait till vana midnight and zone
                        end
                    elseif prog == 3 then
                        return quest:event(714):importantOnce() -- Get another part for 100000 gil or give up
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHas(trade, { { xi.item.SQUARE_OF_BUGARD_LEATHER, 1 }, { xi.item.TURTLE_SHELL, 1 } }) and
                        trade:getGil() == 10000 and
                        trade:getItemCount() == 3 and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(712)
                    end
                end,
            },

            onEventFinish =
            {
                [710] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1) -- both options return 0
                end,

                [711] = function(player, csid, option, npc)
                    if option == 100 then
                        player:messageSpecial(windurstWoodsID.text.QUEST_CANCELED)
                        quest:setVar(player, 'Prog', 0) -- reset progress
                        player:delQuest(quest.areaId, quest.questId)
                        player:setVar('BstHeadGearQuest_Conquest', 0) -- player can accept other headgear quests upon cancelling without conquest wait
                    end
                end,

                [712] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    quest:setVar(player, 'partsWait', getVanaMidnight())
                    player:confirmTrade()
                    player:delGil(10000)
                    quest:setMustZone(player)
                end,

                [714] = function(player, csid, option, npc)
                    if option == 0 then
                        if player:getGil() > 100000 then
                            quest:setVar(player, 'partsWait', getVanaMidnight())
                            player:delGil(100000)
                            quest:setMustZone(player)
                        else
                            player:messageSpecial(windurstWoodsID.text.NOT_HAVE_ENOUGH_GIL)
                        end
                    elseif option == 100 then
                        player:messageSpecial(zones[player:getZoneID()].text.QUEST_CANCELED)
                        quest:setVar(player, 'Prog', 0)
                        player:delQuest(quest.areaId, quest.questId)
                        player:setVar('BstHeadGearQuest_Conquest', 0) -- player can accept other headgear quests upon cancelling
                    end
                end,

                [715] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.QUADAV_PARTS) then -- only progress vars if player receives parts
                        if quest:getVar(player, 'Prog') == 2 then
                            quest:setVar(player, 'Prog', 3) -- only progress if current prog is 2, otherwise player is already at, or beyond, Prog 3
                        end

                        quest:setVar(player, 'partsWait', 0)
                    end
                end,
            },
        },

        [xi.zone.QULUN_DOME] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local pos = player:getPos()
                    if
                        pos.x >= 0 and
                        pos.y >= 20 and
                        pos.z >= 55 and
                        pos.x <= 6 and
                        pos.y <= 25 and
                        pos.z <= 65 and
                        quest:getVar(player, 'Prog') == 3 and
                        player:getEquipID(xi.slot.HEAD) == xi.item.QUADAV_BARBUT
                    then
                        return 61 -- Give player seeker bats ki to plant
                    end
                end,
            },

            ['Beastmens_Banner'] =
            {
                onTrigger = function(player, npc)
                    local engaged = GetNPCByID(qulunDomeID.npc.BEASTMENS_BANNER):getLocalVar('engaged')
                    if
                        player:getEquipID(xi.slot.HEAD) == xi.item.QUADAV_BARBUT and
                        player:hasKeyItem(xi.ki.ORCISH_SEEKER_BATS)
                    then
                        if
                            engaged < os.time() and -- if engaged 3min timer has passed
                            engaged ~= 1 -- if not currently engaged
                        then
                            return quest:progressEvent(62) -- trigger fight
                        end
                    elseif quest:getVar(player, 'Prog') == 5 then
                        return quest:progressEvent(63) -- congratulate player on fight
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { xi.item.QUADAV_BARBUT }) and
                        quest:getVar(player, 'Prog') == 6
                    then
                        return quest:progressEvent(64) -- reward player with Da'Vhu's Barbut
                    end
                end,
            },

            ['Diamond_Quadav'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if qulunDomeID.mob.AFFABLE_ADAMANTKING_OFFSET == mob:getID() then
                        for i = qulunDomeID.mob.AFFABLE_ADAMANTKING_OFFSET + 1, qulunDomeID.mob.AFFABLE_ADAMANTKING_OFFSET + 6 do
                            DespawnMob(i)
                        end

                        player:delKeyItem(xi.ki.ORCISH_SEEKER_BATS)
                        GetNPCByID(qulunDomeID.npc.BEASTMENS_BANNER):setLocalVar('engaged', os.time()) -- no time gate after death
                        mob:setLocalVar('died', 1) -- set died so despawn doesn't trigger 3 min timer
                        quest:setVar(player, 'Prog', 5)
                    end
                end,
            },

            onEventFinish =
            {
                [61] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.ORCISH_SEEKER_BATS)
                    quest:setVar(player, 'Prog', 4)
                end,

                [62] = function(player, csid, option, npc)
                    if
                        npcUtil.popFromQM(player, npc, {
                            qulunDomeID.mob.AFFABLE_ADAMANTKING_OFFSET,
                            qulunDomeID.mob.AFFABLE_ADAMANTKING_OFFSET + 1,
                            qulunDomeID.mob.AFFABLE_ADAMANTKING_OFFSET + 2,
                            qulunDomeID.mob.AFFABLE_ADAMANTKING_OFFSET + 3,
                            qulunDomeID.mob.AFFABLE_ADAMANTKING_OFFSET + 4,
                            qulunDomeID.mob.AFFABLE_ADAMANTKING_OFFSET + 5,
                            qulunDomeID.mob.AFFABLE_ADAMANTKING_OFFSET + 6,
                        }, { claim = true, hide = 0 })
                    then
                        GetNPCByID(qulunDomeID.npc.BEASTMENS_BANNER):setLocalVar('engaged', 1)
                    end
                end,

                [63] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                end,

                [64] = function(player, csid, option, npc)
                    if player:getFreeSlotsCount() > 0 then
                        if quest:complete(player) then-- quest is marked complete, additional reward upon zoning w/ CS
                            player:setCharVar('affableZone', 1)
                            player:setVar('BstHeadGearQuest_Conquest', NextConquestTally())
                            player:confirmTrade()
                        end
                    else
                        player:messageSpecial(qulunDomeID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.DAVHUS_BARBUT)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.COMPLETED
        end,

        [xi.zone.QULUN_DOME] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local pos = player:getPos()
                    if
                        pos.x >= 0 and
                        pos.y >= 20 and
                        pos.z >= 55 and
                        pos.x <= 6 and
                        pos.y <= 25 and
                        pos.z <= 65 and
                        player:getCharVar('affableZone') == 1 and
                        player:getEquipID(xi.slot.HEAD) == xi.item.DAVHUS_BARBUT
                    then
                        return 65
                    end
                end,
            },

            onEventFinish =
            {
                [65] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.GOLD_BEASTCOIN) then
                        player:setCharVar('affableZone', 0)
                    end
                end,
            }
        },
    },
}

return quest
