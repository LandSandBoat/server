-----------------------------------
-- The Truth Beckons
-----------------------------------
-- !addquest 8 161
-- Joachim : !pos -52.844 0 -9.978 246
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.THE_TRUTH_BECKONS)

quest.reward = {}

local handleOnZoneIn = function(player, prevZone)
    quest:setVar(player, 'Prog', 1)
end

quest.sections =
{
    -- This quest is flagged on completion of A Journey Begins.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['Joachim'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(327, 0, 0, xi.abyssea.getTraverserCap(player))
                    else
                        return quest:progressEvent(326)
                    end
                end,
            },

            onEventFinish =
            {
                [327] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addQuest(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DAWN_OF_DEATH)
                    end
                end,
            },
        },

        [xi.zone.ABYSSEA_KONSCHTAT] =
        {
            onZoneIn = { handleOnZoneIn },
        },

        [xi.zone.ABYSSEA_LA_THEINE] =
        {
            onZoneIn = { handleOnZoneIn },
        },

        [xi.zone.ABYSSEA_TAHRONGI] =
        {
            onZoneIn = { handleOnZoneIn },
        },

        [xi.zone.ABYSSEA_ATTOHWA] =
        {
            onZoneIn = { handleOnZoneIn },
        },

        [xi.zone.ABYSSEA_MISAREAUX] =
        {
            onZoneIn = { handleOnZoneIn },
        },

        [xi.zone.ABYSSEA_VUNKERL] =
        {
            onZoneIn = { handleOnZoneIn },
        },

        [xi.zone.ABYSSEA_ALTEPA] =
        {
            onZoneIn = { handleOnZoneIn },
        },

        [xi.zone.ABYSSEA_ULEGUERAND] =
        {
            onZoneIn = { handleOnZoneIn },
        },

        [xi.zone.ABYSSEA_GRAUBERG]  =
        {
            onZoneIn = { handleOnZoneIn },
        },
    },
}

return quest
