-----------------------------------
-- Moblin Maze Mongers: Tutorial (Goldagrik)
-----------------------------------
require('scripts/globals/npc_util')
-----------------------------------
xi = xi or {}
xi.mmm = xi.mmm or {}

xi.mmm.tutorialOnTrigger = function(player)
    if xi.settings.main.ENABLE_MMM ~= 1 then
        player:printToPlayer('This content is disabled.', xi.msg.channel.SYSTEM_3)
    elseif player:hasKeyItem(xi.ki.TATTERED_MAZE_MONGER_POUCH) then
        local ccPoints = xi.mmm.calculateCCPoints(player)

        player:startEvent(20006, ccPoints)
    else
        player:startEvent(20004)
    end
end

xi.mmm.tutorialOnEventFinish = function(player, csid, option)
    if csid == 20004 and option == 1 then
        if npcUtil.giveItem(player, { xi.item.MAZE_TABULA_M01, xi.item.MAZE_VOUCHER_01, xi.item.MAZE_RUNE_106, xi.item.MAZE_RUNE_109 }) then
            npcUtil.giveKeyItem(player, xi.ki.TATTERED_MAZE_MONGER_POUCH)
        end
    end
end
