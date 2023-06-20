-----------------------------------
-- Soul Searching
-----------------------------------
-- Log ID: 5, Quest ID: 162
-- Cermet Headstone : !pos 235 0 280 121
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local zitahID = require('scripts/zones/The_Sanctuary_of_ZiTah/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.SOUL_SEARCHING)

quest.reward =
{
    item  = xi.items.BAT_EARRING,
    title = xi.title.GUIDER_OF_SOULS_TO_THE_SANCTUARY,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.THE_SANCTUARY_OF_ZITAH] =
        {
            ['Cermet_Headstone'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.PRISMATIC_FRAGMENT) then
                        return quest:progressEvent(202, xi.ki.PRISMATIC_FRAGMENT)
                    else
                        return quest:messageSpecial(zitahID.text.AIR_REMAINS_STAGNANT)
                    end
                end,
            },

            onEventFinish =
            {
                [202] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
