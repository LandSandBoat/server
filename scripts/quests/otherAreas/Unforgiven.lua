-----------------------------------
-- Unforgiven
-----------------------------------
-- Log ID: 4, Quest ID: 72
-- Elysia        : !pos -50.410 -22.204 -41.640 26
-- Pradiulot     : !pos -20.814 -22 8.399 26
-- qm_unforgiven : !pos 110.291 -40.85 -53.039
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.UNFORGIVEN)

quest.reward =
{
    exp = 2000,
    ki  = xi.ki.MAP_OF_TAVNAZIA,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.AN_INVITATION_WEST
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Elysia'] = quest:progressEvent(200),

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Elysia'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ALABASTER_HAIRPIN) then
                        return quest:progressEvent(202)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:event(203) -- Reminder to talk to Pradiulot
                    else
                        return quest:event(201) -- Reminder to find the Alabaster Hairpin
                    end
                end,
            },

            ['qm_unforgiven'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.ALABASTER_HAIRPIN) then
                        return quest:keyItem(xi.ki.ALABASTER_HAIRPIN)
                    end
                end,
            },

            ['Pradiulot'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(204)
                    end
                end,
            },

            onEventFinish =
            {
                [202] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.ALABASTER_HAIRPIN)
                    quest:setVar(player, 'Prog', 1)
                end,

                [204] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        quest:setVar(player, 'Post', 1)
                    end
                end,
            },
        },
    },

    {
        -- Post Quest Cutscene
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Elysia'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Post') == 1 then
                        return quest:progressEvent(205)
                    end
                end,
            },

            ['Pradiulot'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Post') == 2 then
                        return quest:progressEvent(206)
                    end
                end,
            },

            onEventFinish =
            {
                [205] = function(player, csid, option, npc)
                    quest:setVar(player, 'Post', 2)
                end,

                [206] = function(player, csid, option, npc)
                    quest:cleanup(player)
                end,
            },
        },
    },
}

return quest
