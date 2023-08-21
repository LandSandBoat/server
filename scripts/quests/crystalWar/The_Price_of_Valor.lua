-----------------------------------
-- The Price of Valor
-----------------------------------
-- !addquest 7 44
-- Rholont       : !pos -168 -2 56 80
-----------------------------------
local vunkerlID = zones[xi.zone.VUNKERL_INLET_S]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_PRICE_OF_VALOR)

quest.reward =
{
    item = xi.item.PEISTE_SKIN,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.IN_A_HAZE_OF_GLORY)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Rholont'] =
            {
                onTrigger = function(player, npc)
                    if
                        not quest:getMustZone(player) and
                        quest:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
                        local questProgress = quest:getVar(player, 'Prog')

                        if questProgress == 0 then
                            return quest:progressEvent(638)
                        elseif questProgress == 1 then
                            if
                                player:hasKeyItem(xi.ki.LONG_LIFE_BISCUITS) and
                                player:hasKeyItem(xi.ki.FLASK_OF_KINGDOM_WATER) and
                                player:hasKeyItem(xi.ki.RONFAURE_MAPLE_SYRUP)
                            then
                                return quest:progressEvent(642)
                            else
                                return quest:event(643)
                            end
                        elseif questProgress == 2 then
                            return quest:event(645)
                        end
                    else
                        return quest:event(49)
                    end
                end,
            },

            ['Tree_Hollow'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.LONG_LIFE_BISCUITS) and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(640)
                    end
                end,
            },

            ['Well'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.FLASK_OF_KINGDOM_WATER) and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(641)
                    end
                end,
            },

            onEventFinish =
            {
                [638] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [640] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LONG_LIFE_BISCUITS)
                end,

                [641] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.FLASK_OF_KINGDOM_WATER)
                end,

                [642] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.BISCUIT_A_LA_RHOLONT)

                    player:delKeyItem(xi.ki.LONG_LIFE_BISCUITS)
                    player:delKeyItem(xi.ki.FLASK_OF_KINGDOM_WATER)
                    player:delKeyItem(xi.ki.RONFAURE_MAPLE_SYRUP)

                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.JUGNER_FOREST_S] =
        {
            ['Felled_Trees'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(211)
                    end
                end,
            },

            onEventFinish =
            {
                [211] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.VUNKERL_INLET_S] =
        {
            ['Toppled_Cresset_1'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(202)
                    end
                end,
            },

            ['Toppled_Cresset_2'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(203)
                    end
                end,
            },

            ['Underbrush'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 4 then
                        return quest:progressEvent(204)
                    elseif questProgress == 5 then
                        if quest:getLocalVar(player, 'nmDefeated') == 0 then
                            local zoneObj = player:getZone()
                            local mobObj  = zoneObj:queryEntitiesByName('Madthrasher_Zradbodd')[1]

                            if not mobObj:isSpawned() then
                                quest:setLocalVar(player, 'nmId', mobObj:getID())
                                return quest:progressEvent(205)
                            else
                                return quest:messageSpecial(vunkerlID.text.NOW_IS_NOT_THE_TIME)
                            end
                        else
                            return quest:progressEvent(206)
                        end
                    end
                end,
            },

            ['Madthrasher_Zradbodd'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 5 then
                        quest:setLocalVar(player, 'nmDefeated', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [202] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [203] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,

                [204] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,

                [205] = function(player, csid, option, npc)
                    local mobId = quest:getLocalVar(player, 'nmId')

                    SpawnMob(mobId):updateClaim(player)
                end,

                [206] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                end,
            },
        },

        [xi.zone.PASHHOW_MARSHLANDS_S] =
        {
            ['Shimmering_Pondweed'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 6 then
                        return quest:progressEvent(105)
                    end
                end,
            },

            onEventFinish =
            {
                [105] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
