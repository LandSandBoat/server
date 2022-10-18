-----------------------------------
-- Not Meant to Be
-----------------------------------
-- Log ID: 6, Quest ID: 64
-- Fhe Maksojha   : !pos 19.084 -7 71.287 53
-- qm12 (Caedarva): !pos 456.993 -7.000 -270.815 79
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local caedarvaMireID = require('scripts/zones/Caedarva_Mire/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.NOT_MEANT_TO_BE)

quest.reward =
{
    item =
    {
        { xi.items.IMPERIAL_GOLD_PIECE, 3 },
    },
}

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.NASHMAU] =
        {
            ['Fhe_Maksojha'] =
            {
                onTrigger = quest:progressEvent(293),
            },

            onEventFinish =
            {
                [293] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NASHMAU] =
        {
            ['Fhe_Maksojha'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 1 then
                        return quest:event(295)
                    elseif questProgress == 2 then
                        return quest:progressEvent(294)
                    elseif questProgress == 3 then
                        return quest:event(296)
                    elseif questProgress == 4 then
                        return quest:event(297)
                    end
                end,
            },

            onEventFinish =
            {
                [294] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [297] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.CAEDARVA_MIRE] =
        {
            ['qm12'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')
                    local questStage = quest:getVar(player, 'Stage')

                    if questProgress == 1 then
                        return quest:progressEvent(16)
                    elseif questProgress == 3 then
                        if
                            questStage < 3 and
                            not GetMobByID(caedarvaMireID.mob.LAMIA_NO27):isSpawned() and
                            not GetMobByID(caedarvaMireID.mob.MOSHDAHN):isSpawned()
                        then
                            return quest:event(17)
                        elseif questStage == 3 then
                            return quest:progressEvent(18)
                        end
                    end
                end,
            },

            ['Lamia_No27'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 3 then
                        quest:setVarBit(player, 'Stage', 0)
                    end
                end,
            },

            ['Moshdahn'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 3 then
                        quest:setVarBit(player, 'Stage', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [16] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [17] = function(player, csid, option, npc)
                    -- This conditional exists in both the trigger and the event finish in the original implementation
                    -- and left in as additional protection to prevent multiple sets of NMs being spawned if the ???
                    -- is hit by multiple players at the same time.  This is a fairly long cutscene!
                    if
                        not GetMobByID(caedarvaMireID.mob.LAMIA_NO27):isSpawned() and
                        not GetMobByID(caedarvaMireID.mob.MOSHDAHN):isSpawned()
                    then
                        SpawnMob(caedarvaMireID.mob.LAMIA_NO27):updateClaim(player)
                        SpawnMob(caedarvaMireID.mob.MOSHDAHN):updateClaim(player)
                    end
                end,

                [18] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        }
    },

    -- Section: Quest completed
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.NASHMAU] =
        {
            ['Fhe_Maksojha'] = quest:event(298)
        },
    },
}

return quest
