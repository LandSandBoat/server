-----------------------------------
-- Module to remove the gil compensation given by 'Rock Bottom' when the player
-- already holds the map key item.
-- Gil was added in 2013 so it is removed here.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_rock_bottom', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/ahtUrhgan/Rock_Bottom', function(quest)
        quest.sections[2][xi.zone.MOUNT_ZHAYOLM].onEventFinish[9] = function(player, csid, option, npc)
            if quest:complete(player) then
                player:tradeComplete()
                if not player:hasKeyItem(xi.keyItem.MAP_OF_MOUNT_ZHAYOLM) then
                    npcUtil.giveKeyItem(player, xi.keyItem.MAP_OF_MOUNT_ZHAYOLM)
                end
            end
        end
    end)
end)
