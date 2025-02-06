-----------------------------------
-- The Curse Collector
-----------------------------------
-- Log ID: 1, Quest ID: 34
-- Zon-Fobun : !pos -241.293 -3 63.406 235
-- The Mute  : !pos -166.230 -1 -73.685 147
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.THE_CURSE_COLLECTOR)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.BASTOK,
    item     = xi.item.POISON_CESTI,
}

local handleAfflictorTriggerArea = function(player, triggerArea)
    local triggerAreaId = triggerArea:getTriggerAreaID()
    local yPos          = player:getYPos()
    local requiredYPos  = nil

    if triggerAreaId == 4 then
        requiredYPos = 35
    elseif triggerAreaId >= 3 then
        requiredYPos = 20
    end

    if
        (not requiredYPos or
        yPos > requiredYPos) and
        not quest:isVarBitsSet(player, 'Prog', 1)
    then
        quest:setVarBit(player, 'Prog', 1)
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and player:getFameLevel(xi.fameArea.BASTOK) >= 4
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Zon-Fobun'] = quest:progressEvent(251),

            onEventFinish =
            {
                [251] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.CURSEPAPER)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Zon-Fobun'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: Determine if there is reminder dialogue prior to quest
                    -- being completed.

                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(252)
                    end
                end,
            },

            onEventFinish =
            {
                [252] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.CURSEPAPER)
                    end
                end,
            },
        },

        [xi.zone.BEADEAUX] =
        {
            ['The_Mute'] =
            {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Prog', 0) then
                        quest:setVarBit(player, 'Prog', 0)
                    end

                    -- Intentional Fallthrough
                    -- TODO: Determine if there is a separate event or
                    -- message displayed here.
                end,
            },

            onTriggerAreaEnter =
            {
                [1] = handleAfflictorTriggerArea,
                [2] = handleAfflictorTriggerArea,
                [3] = handleAfflictorTriggerArea,
                [4] = handleAfflictorTriggerArea,
                [5] = handleAfflictorTriggerArea,
                [6] = handleAfflictorTriggerArea,
            },
        },
    },
}

return quest
