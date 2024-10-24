-----------------------------------
-- Escort for Hire (San d'Oria)
-----------------------------------
-- Log ID: 0, Quest ID: 103
-- Rondipur !pos -154 10 153
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
-----------------------------------
local ID = zones[xi.zone.THE_ELDIEME_NECROPOLIS]
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.ESCORT_FOR_HIRE)

quest.firstTimeCompletion = true

quest.reward =
{
    gil = 10000,
    fame = 100,
    fameArea = xi.quest.area.SANDORIA,
    item = xi.item.MIRATETES_MEMOIRS,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getQuestStatus(xi.questLog.BASTOK, xi.quest.id.bastok.ESCORT_FOR_HIRE) ~= xi.questStatus.QUEST_ACCEPTED and
            player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.ESCORT_FOR_HIRE) ~= xi.questStatus.QUEST_ACCEPTED and
            player:getFameLevel(xi.fameArea.SANDORIA) >= 6 and
            player:getCharVar('ESCORT_CONQUEST') < NextConquestTally()
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Rondipur'] =
            {
                onTrigger = function(player, npc)
                    if player:hasCompletedQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.ESCORT_FOR_HIRE) then
                        quest.firstTimeCompletion = false
                    end

                    return quest:progressEvent(721) -- start
                end,
            },

            onEventFinish =
            {
                [721] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.BATALLIA_DOWNS] =
        {
            onTriggerAreaEnter =
            {
                [10] = function(player, triggerArea)
                    if quest:getVar(player, 'Prog') >= 0 and quest:getVar(player, 'Prog') <= 2 then
                        quest:setVar(player, 'Front', 1)
                    end
                end,
            },
        },

        [xi.zone.THE_ELDIEME_NECROPOLIS] =
        {
            onTriggerAreaLeave =
            {
                [1] = function(player, triggerArea)
                    quest:setVar(player, 'Front', 0)
                end
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if
                        quest:getVar(player, 'Front') == 1 and
                        GetServerVariable('[Escort]Cannau') == 0 and
                        not player:hasKeyItem(xi.ki.COMPLETION_CERTIFICATE)
                    then
                        if quest:getVar(player, 'Prog') == 0 then
                            return 51
                        elseif quest:getVar(player, 'Prog') == 2 then
                            return 51
                        end
                    end
                end,
            },

            onEventUpdate =
            {
                [51] = function(player, csid, option, npc)
                end,
            },

            onEventFinish =
            {
                [51] = function(player, csid, option, npc)
                    local function spawnEscort(escort, checkEscort, zone, playerPos)
                        local cannau = zone:insertDynamicEntity({
                            objtype = xi.objType.MOB,
                            name = 'Cannau',
                            groupId = 59,
                            groupZoneId = 195,
                            x = 0,
                            y = 0,
                            z = 0,
                            rotation = 0,
                            allegiance = xi.allegiance.PLAYER,
                            isAggroable = true,
                            specialSpawnAnimation = true,
                            releaseIdOnDisappear = true,
                        })

                        if cannau == nil then
                            return
                        end

                        SetServerVariable(escort, cannau:getID())

                        cannau:spawn()
                        cannau:timer(1000, function()
                            cannau:setPos(playerPos.x, playerPos.y, playerPos.z, playerPos.rot)
                        end)

                        cannau:setStatus(xi.status.NORMAL)

                        player:messageSpecial(ID.text.TIME_LIMIT, 30)
                        cannau:setLocalVar('escort', cannau:getID())
                        cannau:setLocalVar('player', player:getID())
                        cannau:setLocalVar('progress', 0)
                        cannau:setLocalVar('expire', os.time() + 1800)
                        player:getZone():setLocalVar('expire', os.time() + 1800)
                    end

                    local escort = '[Escort]Cannau'
                    local checkEscort = GetServerVariable(escort)
                    local zone = player:getZone()
                    local playerPos = player:getPos()

                    if checkEscort == 0 then
                        if quest:getVar(player, 'Prog') == 0 then
                            for _, v in ipairs(player:getParty()) do
                                if not player:hasKeyItem(xi.ki.COMPLETION_CERTIFICATE) then
                                    quest:setVar(v, 'Prog', 1)
                                end
                            end

                            spawnEscort(escort, checkEscort, zone, playerPos)
                        elseif quest:getVar(player, 'Prog') == 2 then
                            for _, v in ipairs(player:getParty()) do
                                if not player:hasKeyItem(xi.ki.COMPLETION_CERTIFICATE) then
                                    quest:setVar(v, 'Prog', 1)
                                end
                            end

                            spawnEscort(escort, checkEscort, zone, playerPos)
                        end
                    end
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Rondipur'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.COMPLETION_CERTIFICATE) then
                        return quest:progressEvent(723)
                    else
                        return quest:progressEvent(722)
                    end
                end,
            },

            onEventFinish =
            {
                [723] = function(player, csid, option, npc)
                    if player:getFreeSlotsCount() > 0 and not player:hasItem(quest.reward.item) then
                        if quest.firstTimeCompletion then
                            player:setCharVar('ESCORT_CONQUEST', NextConquestTally())
                            quest:complete(player)
                            player:delKeyItem(xi.ki.COMPLETION_CERTIFICATE)
                            quest:setVar(player, 'Front', 0)
                            quest:setVar(player, 'Prog', 0)
                        else
                            player:setCharVar('ESCORT_CONQUEST', NextConquestTally())
                            npcUtil.completeQuest(player, xi.questLog.SANDORIA, xi.quest.id.sandoria.ESCORT_FOR_HIRE, {
                                fame = 100,
                                fameArea = xi.quest.fame_area.SANDORIA,
                                item = xi.item.MIRATETES_MEMOIRS,
                            })
                            player:delKeyItem(xi.ki.COMPLETION_CERTIFICATE)
                            quest:setVar(player, 'Front', 0)
                            quest:setVar(player, 'Prog', 0)
                        end
                    else
                        player:messageSpecial(zones[xi.zone.NORTHERN_SAN_DORIA].text.ITEM_CANNOT_BE_OBTAINED, quest.reward.item)
                    end
                end,

                [722] = function(player, csid, option, npc)
                    if option == 0 then
                        player:delQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.ESCORT_FOR_HIRE)
                        quest:setVar(player, 'Front', 0)
                        quest:setVar(player, 'Prog', 0)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
            player:getQuestStatus(xi.questLog.BASTOK, xi.quest.id.bastok.ESCORT_FOR_HIRE) ~= xi.questStatus.QUEST_ACCEPTED and
            player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.ESCORT_FOR_HIRE) ~= xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Rondipur'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar('ESCORT_CONQUEST') < NextConquestTally() then
                        return quest:progressEvent(721)
                    elseif player:getCharVar('ESCORT_CONQUEST') > NextConquestTally() then
                        return quest:progressEvent(724) --! Need to get this ID
                    end
                end,
            },

            onEventFinish =
            {
                [721] = function(player, csid, option, npc)
                    player:delQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.ESCORT_FOR_HIRE)
                    quest:begin(player)
                end,
            },
        },
    },
}

return quest
