-----------------------------------
-- A Purchase of Arms
-----------------------------------
-- Log ID: 0, Quest ID: 27
-----------------------------------
-- Helbort : !pos 71 -1 65 230
-- Alexius : !pos 105 1 382 104
-----------------------------------
local forestID = zones[xi.zone.JUGNER_FOREST]
local southID  = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.A_PURCHASE_OF_ARMS)

quest.reward =
{
    item  = xi.item.ELM_STAFF,
    title = xi.title.ARMS_TRADER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.FATHER_AND_SON) == xi.questStatus.QUEST_COMPLETED and
                player:getFameLevel(xi.fameArea.SANDORIA) >= 2
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Helbort'] = quest:progressEvent(594),

            onEventFinish =
            {
                [594] = function(player, csid, option, npc)
                    if option == 0 and npcUtil.giveKeyItem(player, xi.ki.WEAPONS_ORDER) then
                        quest:begin(player)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status ~= xi.questStatus.QUEST_AVAILABLE and
                player:hasKeyItem(xi.ki.WEAPONS_ORDER)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Helbort'] = quest:message(southID.text.HELBORT_ORDERS),
        },

        [xi.zone.JUGNER_FOREST] =
        {
            ['Alexius'] = quest:progressEvent(5),

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    if npcUtil.giveKeyItem(player, xi.ki.WEAPONS_RECEIPT) then
                        player:delKeyItem(xi.ki.WEAPONS_ORDER)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                not player:hasKeyItem(xi.ki.WEAPONS_ORDER)
        end,

        [xi.zone.JUGNER_FOREST] =
        {
            ['Alexius'] = quest:message(forestID.text.ALEXIUS_ORDERS, xi.ki.WEAPONS_RECEIPT),
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Helbort'] = quest:progressEvent(607),

            onEventFinish =
            {
                [607] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.WEAPONS_RECEIPT)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Helbort'] = quest:message(southID.text.HELBORT_ORDERS + 3)
        },
    },
}

return quest
