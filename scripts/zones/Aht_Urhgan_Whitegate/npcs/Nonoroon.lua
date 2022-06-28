-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Nonoroon
-- Mythic Start Quest
-- !gotoid 16982132
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("settings/main")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local pZeni  = player:getCurrency("zeni_point")
    local pLevel = player:getMainLvl()
            
    if pZeni >= 6000 and pLevel > 74 then -- Zeni Points Check and Player level check.
        player:PrintToPlayer("Nonoroon: I see you have at least 6000 Zeni Points and are able to equip this weapon", 0xd)
        player:PrintToPlayer("Nonoroon: If you can help me out with this myth then you can have the final reward!", 0xd)
        player:PrintToPlayer("Nonoroon: Please make sure you are on the Job you wish to continue this path!", 0xd)
        player:PrintToPlayer("Nonoroon: When you are ready Trade me 5 Impirial Gold Pieces and on the correct JOB!", 0x1F)
    else
        player:PrintToPlayer("You are not worthy come back when you are ready!", 0xd)
    end
end

entity.onTrade = function(player, npc, trade)
    local pZeni  = player:getCurrency("zeni_point")
    local pLevel = player:getMainLvl()

    if pZeni >= 6000 and pLevel > 74 and npcUtil.tradeHasExactly(trade, {{2187, 5}}) then
        player:tradeComplete()
        player:delCurrency("zeni_point", 6000)
        player:PrintToPlayer( "Nonoroon: Thank you for the persistent intrest in this Myth here is your reward.", 0xd)
        npcUtil.giveItem(player, 18970 + player:getMainJob())
    else
        player:PrintToPlayer( "Nonoroon: You need more Zeni Points, Incorrect level or wrong items to proceed .", 0xd)
    end
end

return entity