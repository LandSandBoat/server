-----------------------------------
-- Brygid the Stylist
-----------------------------------
-- Log ID: 1, Quest ID: 44
-- Brygid : !pos -90 -4 -108 235
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BRYGID_THE_STYLIST)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.items.GLOVES,
    title    = xi.title.BRYGID_APPROVED,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Brygid'] = quest:progressEvent(310),

            onEventFinish =
            {
                [310] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Brygid'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getEquipID(xi.slot.BODY) == xi.items.ROBE and
                        player:getEquipID(xi.slot.LEGS) == xi.items.BRONZE_SUBLIGAR
                    then
                        return quest:progressEvent(311)
                    else
                        return quest:event(310)
                    end
                end,
            },

            onEventFinish =
            {
                [311] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
