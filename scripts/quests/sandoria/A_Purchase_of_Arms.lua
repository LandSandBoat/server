-----------------------------------
-- A Purchase of Arms
-----------------------------------
-- Log ID: 0, Quest ID: 27
-- Helbort: !gotoid 17719353
-- Alexius: !gotoid 17203813
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
local ID = require("scripts/zones/Southern_San_dOria/IDs")
local jugnerID = require("scripts/zones/Jugner_Forest/IDs")

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_PURCHASE_OF_ARMS)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    title    = xi.title.ARMS_TRADER,
    item     = xi.items.ELM_STAFF,

}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.FATHER_AND_SON) == QUEST_COMPLETED and
            player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 2
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Helbort'] = quest:progressEvent(594),

            onEventFinish =
            {
                [594] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.WEAPONS_ORDER)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Helbort'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem (xi.ki.WEAPONS_RECEIPT) then
                        return quest:progressEvent(607)
                    else
                        return quest:event(593)
                    end
                end,
            },

            onEventFinish =
            {
                [607] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.WEAPONS_RECEIPT)
                    end
                end,
            },
        },

        [xi.zone.JUGNER_FOREST] =
        {
            ['Alexius'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem (xi.ki.WEAPONS_ORDER) then
                        return quest:progressEvent(5)
                    else
                        return quest:messageSpecial(jugnerID.text.ALEXIUS_DEFAULT)
                    end
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.WEAPONS_ORDER)
                    npcUtil.giveKeyItem(player, xi.ki.WEAPONS_RECEIPT)
                    return quest:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.WEAPONS_RECEIPT)
                end,
            },
        },
    },
}

return quest
