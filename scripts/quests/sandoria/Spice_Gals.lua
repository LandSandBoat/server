-----------------------------------
-- Spice Gals
-----------------------------------
-- Log ID: 0, Quest ID: 110
-----------------------------------
-- CoP 3-1             : !addmission 6 258
-- Rouva               : !pos -16.194 2.101 11.805
-- Riverne - Site #A01 : !pos -514.717 -6.684 -407.314
-- Riverne - Site #B01 : !pos -517.137 0.094 689.199
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.SPICE_GALS)

quest.reward =
{
    item = xi.item.MIRATETES_MEMOIRS,
    fame = 0,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return vars.Prog == 0 and
            vars.Wait < NextConquestTally() and
            player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_VOWS)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Rouva'] =
            {
                onTrigger = function(player, npc)
                    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.SPICE_GALS) == xi.questStatus.QUEST_AVAILABLE then
                        return quest:progressEvent(724)
                    else
                        return quest:progressEvent(726) -- Repeat after conquest tally
                    end
                end,
            },

            onEventFinish =
            {
                [724] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                end,

                [726] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return vars.Prog == 1
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Rouva'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.SPICE_GALS) == xi.questStatus.QUEST_ACCEPTED and
                        player:hasKeyItem(xi.ki.RIVERNEWORT)
                    then
                        return quest:progressEvent(725) -- First time completion
                    elseif
                        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.SPICE_GALS) == xi.questStatus.QUEST_COMPLETED and
                        player:hasKeyItem(xi.ki.RIVERNEWORT)
                    then
                        return quest:progressEvent(727) -- Repeat completion
                    else
                        return quest:event(728):oncePerZone()
                    end
                end,
            },

            onEventFinish =
            {
                [725] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addFame(xi.fameArea.SANDORIA, 40)
                        player:delKeyItem(xi.ki.RIVERNEWORT)
                        quest:setVar(player, 'Wait', NextConquestTally())
                    end
                end,

                [727] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.RIVERNEWORT)
                        quest:setVar(player, 'Wait', NextConquestTally())
                    end
                end,
            },
        },

        [xi.zone.RIVERNE_SITE_A01] =
        {
            ['qm_rivernewort'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.RIVERNEWORT) then
                        return quest:keyItem(xi.ki.RIVERNEWORT)
                    end
                end,
            },
        },

        [xi.zone.RIVERNE_SITE_B01] =
        {
            ['qm_rivernewort'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.RIVERNEWORT) then
                        return quest:keyItem(xi.ki.RIVERNEWORT)
                    end
                end,
            },
        },
    },
}

return quest
