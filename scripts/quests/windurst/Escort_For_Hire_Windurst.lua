-----------------------------------
-- Escort for Hire (Windurst)
-----------------------------------
-- Log ID: 2, Quest ID: 88
-- Dehn Harzhapan !pos -7, -6, 152
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL]
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.ESCORT_FOR_HIRE)

quest.firstTimeCompletion = true

quest.reward =
{
    gil = 10000,
    fame = 100,
    fameArea = xi.quest.area.WINDURST,
    item = xi.item.MIRATETES_MEMOIRS,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getQuestStatus(xi.questLog.BASTOK, xi.quest.id.bastock.ESCORT_FOR_HIRE) ~= xi.questStatus.QUEST_ACCEPTED and
            player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.ESCORT_FOR_HIRE) ~= xi.questStatus.QUEST_ACCEPTED and
            player:getFameLevel(xi.fameArea.WINDURST) >= 6 and
            player:getCharVar('ESCORT_CONQUEST') < NextConquestTally()
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Dehn_Harzhapan'] =
            {
                onTrigger = function(player, npc)
                    if player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.ESCORT_FOR_HIRE) then
                        quest.firstTimeCompletion = false
                    end

                    return quest:progressEvent(10014) -- start
                end,
            },

            onEventFinish =
            {
                [10014] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.SAUROMUGUE_CHAMPAIGN] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if quest:getVar(player, 'Prog') >= 0 and quest:getVar(player, 'Prog') <= 2 then
                        quest:setVar(player, 'Front', 1)
                    end
                end,
            },
        },

        [xi.zone.GARLAIGE_CITADEL] =
        {
            onTriggerAreaLeave =
            {
                [30] = function(player, triggerArea)
                    quest:setVar(player, 'Front', 0)
                end
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if
                        quest:getVar(player, 'Front') == 1 and
                        GetServerVariable('[Escort]Wanzo') == 0 and
                        not player:hasKeyItem(xi.ki.COMPLETION_CERTIFICATE)
                    then
                        if quest:getVar(player, 'Prog') == 0 then
                            return 60
                        elseif quest:getVar(player, 'Prog') == 2 then
                            return 60
                        end
                    end
                end,
            },

            onEventUpdate =
            {
                [60] = function(player, csid, option, npc)
                end,
            },

            onEventFinish =
            {
                [60] = function(player, csid, option, npc)
                    local function spawnEscort(escort, checkEscort, zone, playerPos)
                        local wanzo = zone:insertDynamicEntity({
                            objtype = xi.objType.MOB,
                            name = 'Wanzo-Unzozo',
                            groupId = 49,
                            groupZoneId = 200,
                            x = 0,
                            y = 0,
                            z = 0,
                            rotation = 0,
                            allegiance = xi.allegiance.PLAYER,
                            isAggroable = true,
                            specialSpawnAnimation = true,
                            releaseIdOnDisappear = true,
                        })

                        if wanzo == nil then
                            return
                        end

                        SetServerVariable(escort, wanzo:getID())

                        wanzo:spawn()
                        wanzo:timer(1000, function()
                            wanzo:setPos(playerPos.x, playerPos.y, playerPos.z, playerPos.rot)
                        end)

                        wanzo:setStatus(xi.status.NORMAL)

                        player:messageSpecial(ID.text.TIME_LIMIT, 30)
                        wanzo:setLocalVar('escort', wanzo:getID())
                        wanzo:setLocalVar('player', player:getID())
                        wanzo:setLocalVar('progress', 0)
                        wanzo:setLocalVar('expire', os.time() + 1800)
                        player:getZone():setLocalVar('expire', os.time() + 1800)
                    end

                    local escort = '[Escort]Wanzo'
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

        [xi.zone.PORT_WINDURST] =
        {
            ['Dehn_Harzhapan'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.COMPLETION_CERTIFICATE) then
                        return quest:progressEvent(10016)
                    else
                        return quest:progressEvent(10015)
                    end
                end,
            },

            onEventFinish =
            {
                [10016] = function(player, csid, option, npc)
                    if player:getFreeSlotsCount() > 0 and not player:hasItem(quest.reward.item) then
                        if quest.firstTimeCompletion then
                            player:setCharVar('ESCORT_CONQUEST', NextConquestTally())
                            quest:complete(player)
                            player:delKeyItem(xi.ki.COMPLETION_CERTIFICATE)
                            quest:setVar(player, 'Front', 0)
                            quest:setVar(player, 'Prog', 0)
                        else
                            player:setCharVar('ESCORT_CONQUEST', NextConquestTally())
                            npcUtil.completeQuest(player, xi.questLog.WINDURST, xi.quest.id.windurst.ESCORT_FOR_HIRE, {
                                fame = 100,
                                fameArea = xi.quest.fame_area.WINDURST,
                                item = xi.item.MIRATETES_MEMOIRS,
                            })
                            player:delKeyItem(xi.ki.COMPLETION_CERTIFICATE)
                            quest:setVar(player, 'Front', 0)
                            quest:setVar(player, 'Prog', 0)
                        end
                    else
                        player:messageSpecial(zones[xi.zone.PORT_WINDURST].text.ITEM_CANNOT_BE_OBTAINED, quest.reward.item)
                    end
                end,

                [10015] = function(player, csid, option, npc)
                    if option == 0 then
                        player:delQuest(xi.questLog.WINDURST, xi.quest.id.windurst.ESCORT_FOR_HIRE)
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
            player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.ESCORT_FOR_HIRE) ~= xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Dehn_Harzhapan'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar('ESCORT_CONQUEST') < NextConquestTally() then
                        return quest:progressEvent(10014)
                    elseif player:getCharVar('ESCORT_CONQUEST') > NextConquestTally() then
                        return quest:progressEvent(10017)
                    end
                end,
            },

            onEventFinish =
            {
                [10014] = function(player, csid, option, npc)
                    player:delQuest(xi.questLog.WINDURST, xi.quest.id.windurst.ESCORT_FOR_HIRE)
                    quest:begin(player)
                end,
            },
        },
    },
}

return quest
