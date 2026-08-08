-----------------------------------
-- Eco-Warrior (San d'Oria)
-----------------------------------
-- Log ID: 0, Quest ID: 97
-- !addquest 0 97
-- Norejaie   : !pos 83.924 1 110.54 230
-- Rojaireaut : !pos -91.781 -0.545 587.944 193
-- qm7        : !pos -90 30 156 193
-----------------------------------
-- The indigested stalagmite alone gates the turn-in. Returning to Rojaireaut first is optional.
-- Event 54 does not remove the level restriction. Removal stays available through event 53.
-- Completing any nation's Eco-Warrior locks all three until the next conquest tally.
-----------------------------------
local ordellesID = zones[xi.zone.ORDELLES_CAVES]
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.ECO_WARRIOR)

quest.reward =
{
    fame     = 20,
    fameArea = xi.fameArea.SANDORIA,
    gil      = 5000,
    item     = xi.item.DRAGON_CHRONICLES,
    title    = xi.title.VERMILLION_VENTURER,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Norejaie'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getQuestStatus(xi.questLog.BASTOK, xi.quest.id.bastok.ECO_WARRIOR) == xi.questStatus.QUEST_ACCEPTED or
                        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.ECO_WARRIOR) == xi.questStatus.QUEST_ACCEPTED
                    then
                        return quest:event(682) -- Already on another nation's Eco-Warrior.
                    elseif
                        player:getFameLevel(xi.fameArea.SANDORIA) >= 1 and
                        player:getCharVar('EcoReset') == 0
                    then
                        return quest:progressEvent(677) -- Offers the quest.
                    end
                end,
            },

            onEventFinish =
            {
                [677] = function(player, csid, option, npc)
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

        [xi.zone.ORDELLES_CAVES] =
        {
            ['Necroplasm'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },

            ['qm7'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) and
                        npcUtil.popFromQM(player, npc, ordellesID.mob.NECROPLASM, { claim = true, look = true, hide = 0 })
                    then
                        return quest:messageSpecial(ordellesID.text.OINTMENT_DRAWS_CREATURE)
                    elseif
                        quest:getVar(player, 'Prog') == 1 and
                        not player:hasKeyItem(xi.ki.INDIGESTED_STALAGMITE)
                    then
                        return quest:keyItem(xi.ki.INDIGESTED_STALAGMITE)
                    end
                end,
            },

            ['Rojaireaut'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.INDIGESTED_STALAGMITE) and
                        quest:getVar(player, 'Informed') == 0
                    then
                        return quest:progressEvent(54) -- Sends the player to Norejaie.
                    elseif player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) then
                        return quest:progressEvent(53) -- Offers to remove the ointment.
                    elseif not player:hasKeyItem(xi.ki.INDIGESTED_STALAGMITE) then
                        return quest:progressEvent(51) -- Offers to apply the ointment.
                    end
                end,
            },

            onEventFinish =
            {
                [51] = function(player, csid, option, npc)
                    if option == 1 then
                        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, {
                            power    = 25,
                            subPower = 1, -- exp uses actual level and not the restricted level.
                            origin   = player,
                            flag     = xi.effectFlag.ON_ZONE
                        })
                    end
                end,

                [53] = function(player, csid, option, npc)
                    if option == 0 then
                        player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
                    end
                end,

                [54] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Informed', 1)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Norejaie'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.INDIGESTED_STALAGMITE) then
                        return quest:progressEvent(681) -- Completes the quest.
                    else
                        return quest:event(679) -- Reminder to see Rojaireaut.
                    end
                end,
            },

            onEventFinish =
            {
                [681] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.INDIGESTED_STALAGMITE)
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

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Norejaie'] =
            {
                onTrigger = function(player, npc)
                    -- Repeatable after the next conquest tally.
                    if
                        player:getQuestStatus(xi.questLog.BASTOK, xi.quest.id.bastok.ECO_WARRIOR) == xi.questStatus.QUEST_ACCEPTED or
                        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.ECO_WARRIOR) == xi.questStatus.QUEST_ACCEPTED
                    then
                        return quest:event(682) -- Already on another nation's Eco-Warrior.
                    elseif
                        player:getFameLevel(xi.fameArea.SANDORIA) >= 1 and
                        player:getCharVar('EcoReset') == 0
                    then
                        return quest:progressEvent(677) -- Offers the quest.
                    end
                end,
            },

            onEventFinish =
            {
                [677] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.ECO_WARRIOR)
                        quest:begin(player)
                    end
                end,
            },
        },
    },
}

return quest
