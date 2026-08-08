-----------------------------------
-- Eco-Warrior (Bastok)
-----------------------------------
-- Log ID: 1, Quest ID: 65
-- !addquest 1 65
-- Raifa : !pos -166.416 -8.48 7.153 236
-- Degga : !pos 40 -68 -259 196
-- qm5   : !pos 22.796 -61.156 -19.687 196
-----------------------------------
-- The indigested ore alone gates the turn-in. Returning to Degga first is optional.
-- Event 16 does not remove the level restriction. Removal stays available through event 15.
-- Completing any nation's Eco-Warrior locks all three until the next conquest tally.
-----------------------------------
local gusgenID = zones[xi.zone.GUSGEN_MINES]
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.ECO_WARRIOR)

quest.reward =
{
    fame     = 20,
    fameArea = xi.fameArea.BASTOK,
    gil      = 5000,
    item     = xi.item.DRAGON_CHRONICLES,
    title    = xi.title.CERULEAN_SOLDIER,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Raifa'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.ECO_WARRIOR) == xi.questStatus.QUEST_ACCEPTED or
                        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.ECO_WARRIOR) == xi.questStatus.QUEST_ACCEPTED
                    then
                        return quest:event(283) -- Already on another nation's Eco-Warrior.
                    elseif
                        player:getFameLevel(xi.fameArea.BASTOK) >= 1 and
                        player:getCharVar('EcoReset') == 0
                    then
                        return quest:progressEvent(278) -- Offers the quest.
                    end
                end,
            },

            onEventFinish =
            {
                [278] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.GUSGEN_MINES] =
        {
            ['Degga'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.INDIGESTED_ORE) and
                        quest:getVar(player, 'Informed') == 0
                    then
                        return quest:progressEvent(16) -- Sends the player to Raifa.
                    elseif player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) then
                        return quest:progressEvent(15) -- Offers to remove the ointment.
                    elseif not player:hasKeyItem(xi.ki.INDIGESTED_ORE) then
                        return quest:progressEvent(13) -- Offers to apply the ointment.
                    end
                end,
            },

            ['Pudding'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if not player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) then
                        return
                    end

                    for i = gusgenID.mob.PUDDING_OFFSET, gusgenID.mob.PUDDING_OFFSET + 1 do
                        local nmCheck = GetMobByID(i)

                        if
                            i ~= mob:getID() and
                            nmCheck and
                            nmCheck:isAlive()
                        then
                            return
                        end
                    end

                    quest:setVar(player, 'Prog', 1)
                end,
            },

            ['qm5'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) and
                        npcUtil.popFromQM(player, npc, { gusgenID.mob.PUDDING_OFFSET, gusgenID.mob.PUDDING_OFFSET + 1 }, { claim = true, look = true, hide = 0 })
                    then
                        return quest:messageSpecial(gusgenID.text.OINTMENT_DRAWS_MONSTERS)
                    elseif
                        quest:getVar(player, 'Prog') == 1 and
                        not player:hasKeyItem(xi.ki.INDIGESTED_ORE)
                    then
                        return quest:keyItem(xi.ki.INDIGESTED_ORE)
                    end
                end,
            },

            onEventFinish =
            {
                [13] = function(player, csid, option, npc)
                    if option == 1 then
                        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, {
                            power    = 25,
                            subPower = 1, -- exp uses actual level and not the restricted level.
                            origin   = player,
                            flag     = xi.effectFlag.ON_ZONE
                        })
                    end
                end,

                [15] = function(player, csid, option, npc)
                    if option == 0 then
                        player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
                    end
                end,

                [16] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Informed', 1)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Raifa'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.INDIGESTED_ORE) then
                        return quest:progressEvent(282) -- Completes the quest.
                    else
                        return quest:event(280) -- Reminder to see Degga.
                    end
                end,
            },

            onEventFinish =
            {
                [282] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.INDIGESTED_ORE)
                        player:setCharVar('EcoReset', 1, NextConquestTally())
                    end
                end,
            },
        },
    },

    -- Section: Quest completed.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Raifa'] =
            {
                onTrigger = function(player, npc)
                    -- Repeatable after the next conquest tally.
                    if
                        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.ECO_WARRIOR) == xi.questStatus.QUEST_ACCEPTED or
                        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.ECO_WARRIOR) == xi.questStatus.QUEST_ACCEPTED
                    then
                        return quest:event(283) -- Already on another nation's Eco-Warrior.
                    elseif
                        player:getFameLevel(xi.fameArea.BASTOK) >= 1 and
                        player:getCharVar('EcoReset') == 0
                    then
                        return quest:progressEvent(278) -- Offers the quest.
                    end
                end,
            },

            onEventFinish =
            {
                [278] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delQuest(xi.questLog.BASTOK, xi.quest.id.bastok.ECO_WARRIOR)
                        quest:begin(player)
                    end
                end,
            },
        },
    },
}

return quest
