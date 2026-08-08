-----------------------------------
-- Eco-Warrior (Windurst)
-----------------------------------
-- Log ID: 2, Quest ID: 84
-- !addquest 2 84
-- Lumomo            : !pos -55.770 -5.499 18.914 238
-- Ahko Mhalijikhari : !pos -344.617 -12.226 -166.233 198
-- qm2               : !pos 143 9 -219 198
-----------------------------------
-- The indigested meat alone gates the turn-in. Returning to Ahko Mhalijikhari first is optional.
-- Event 65 does not remove the level restriction. Removal stays available through event 64.
-- Completing any nation's Eco-Warrior locks all three until the next conquest tally.
-----------------------------------
local mazeID = zones[xi.zone.MAZE_OF_SHAKHRAMI]
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.ECO_WARRIOR)

quest.reward =
{
    fame     = 20,
    fameArea = xi.fameArea.WINDURST,
    gil      = 5000,
    item     = xi.item.DRAGON_CHRONICLES,
    title    = xi.title.EMERALD_EXTERMINATOR,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Lumomo'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.ECO_WARRIOR) == xi.questStatus.QUEST_ACCEPTED or
                        player:getQuestStatus(xi.questLog.BASTOK, xi.quest.id.bastok.ECO_WARRIOR) == xi.questStatus.QUEST_ACCEPTED
                    then
                        return quest:event(823) -- Already on another nation's Eco-Warrior.
                    elseif
                        player:getFameLevel(xi.fameArea.WINDURST) >= 1 and
                        player:getCharVar('EcoReset') == 0
                    then
                        return quest:progressEvent(818) -- Offers the quest.
                    end
                end,
            },

            onEventFinish =
            {
                [818] = function(player, csid, option, npc)
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

        [xi.zone.MAZE_OF_SHAKHRAMI] =
        {
            ['Ahko_Mhalijikhari'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.INDIGESTED_MEAT) and
                        quest:getVar(player, 'Informed') == 0
                    then
                        return quest:progressEvent(65) -- Sends the player to Lumomo.
                    elseif player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) then
                        return quest:progressEvent(64) -- Offers to remove the ointment.
                    elseif not player:hasKeyItem(xi.ki.INDIGESTED_MEAT) then
                        return quest:progressEvent(62) -- Offers to apply the ointment.
                    end
                end,
            },

            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) and
                        npcUtil.popFromQM(player, npc, { mazeID.mob.WYRMFLY_OFFSET, mazeID.mob.WYRMFLY_OFFSET + 1, mazeID.mob.WYRMFLY_OFFSET + 2 }, { claim = true, look = true, hide = 0 })
                    then
                        return quest:messageSpecial(mazeID.text.OINTMENT_DRAWS_MONSTERS)
                    elseif
                        quest:getVar(player, 'Prog') == 1 and
                        not player:hasKeyItem(xi.ki.INDIGESTED_MEAT)
                    then
                        return quest:keyItem(xi.ki.INDIGESTED_MEAT)
                    end
                end,
            },

            ['Wyrmfly'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if not player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) then
                        return
                    end

                    for i = mazeID.mob.WYRMFLY_OFFSET, mazeID.mob.WYRMFLY_OFFSET + 2 do
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

            onEventFinish =
            {
                [62] = function(player, csid, option, npc)
                    if option == 1 then
                        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, {
                            power    = 25,
                            subPower = 1, -- exp uses actual level and not the restricted level.
                            origin   = player,
                            flag     = xi.effectFlag.ON_ZONE
                        })
                    end
                end,

                [64] = function(player, csid, option, npc)
                    if option == 0 then
                        player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
                    end
                end,

                [65] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Informed', 1)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Lumomo'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.INDIGESTED_MEAT) then
                        return quest:progressEvent(822) -- Completes the quest.
                    else
                        return quest:event(820) -- Reminder to see Ahko Mhalijikhari.
                    end
                end,
            },

            onEventFinish =
            {
                [822] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.INDIGESTED_MEAT)
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

        [xi.zone.WINDURST_WATERS] =
        {
            ['Lumomo'] =
            {
                onTrigger = function(player, npc)
                    -- Repeatable after the next conquest tally.
                    if
                        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.ECO_WARRIOR) == xi.questStatus.QUEST_ACCEPTED or
                        player:getQuestStatus(xi.questLog.BASTOK, xi.quest.id.bastok.ECO_WARRIOR) == xi.questStatus.QUEST_ACCEPTED
                    then
                        return quest:event(823) -- Already on another nation's Eco-Warrior.
                    elseif
                        player:getFameLevel(xi.fameArea.WINDURST) >= 1 and
                        player:getCharVar('EcoReset') == 0
                    then
                        return quest:progressEvent(818) -- Offers the quest.
                    end
                end,
            },

            onEventFinish =
            {
                [818] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delQuest(xi.questLog.WINDURST, xi.quest.id.windurst.ECO_WARRIOR)
                        quest:begin(player)
                    end
                end,
            },
        },
    },
}

return quest
