-----------------------------------
-- Area: Windurst Woods
--  NPC: Auction Counter
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.tutorial.onAuctionTrigger(player)
    player:sendMenu(xi.menuType.AUCTION)
end

return entity
