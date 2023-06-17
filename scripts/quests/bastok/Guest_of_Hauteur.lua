-----------------------------------
-- Welcome to Bastok
-----------------------------------
-- Log ID: 1, Quest ID: 3
-- Powhatan    : !pos -152.135 -7.48 19.014 236
-- Steel Bones : !pos -185.766 1.999 -57.631 236
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.GUEST_OF_HAUTEUR)

quest.reward =
{
    fame     = 80,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.items.TARGE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.BASTOK) >= 3 and
                player:getMainLvl() >= 31 and
                player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.WELCOME_TO_BASTOK)
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Powhatan'] = quest:progressEvent(55),

            onEventFinish =
            {
                [55] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Powhatan'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.LETTER_FROM_DOMIEN) then
                        return quest:event(56)
                    else
                        return quest:progressEvent(58)
                    end
                end,
            },

            ['Steel_Bones'] =
            {
                onTrigger = function(player, npc)
                    local mainSlot = player:getEquipID(xi.slot.MAIN)

                    if
                        not player:hasKeyItem(xi.ki.LETTER_FROM_DOMIEN) and
                        (mainSlot == xi.items.MAUL or
                        mainSlot == xi.items.REPLICA_MAUL)
                    then
                        return quest:progressEvent(57)
                    end
                end,
            },

            onEventFinish =
            {
                [57] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_DOMIEN)
                end,

                [58] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.LETTER_FROM_DOMIEN)
                    end
                end,
            },
        },
    },
}

return quest
