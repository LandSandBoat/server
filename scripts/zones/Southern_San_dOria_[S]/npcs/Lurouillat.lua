-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Lurouillat
-- !pos 44 2 -35 80
-- Sealed Container NPC
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria_[S]/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local itemID = trade:getItemId()
    local itemKeyItemMapping =
    {
        [xi.items.MAPLE_STRONGBOX] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_I,
        [xi.items.MAGNOLIA_STRONGBOX] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_II,
        [xi.items.BEECH_STRONGBOX] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_III,
        [xi.items.EVERGREEN_STRONGBOX] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_IV,
        [xi.items.HOLLY_STRONGBOX] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_V,
        [xi.items.OAK_STRONGBOX] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_VI,
        [xi.items.ELM_STRONGBOX] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_VII,
        [xi.items.WILLOW_STRONGBOX] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_VIII
    }
    -- Make sure we're only trading 1 Basket at a time.
    if
        npcUtil.tradeHasExactly(trade, itemID) and
        itemKeyItemMapping[itemID]
    then
        player:tradeComplete()
        local keyItem = itemKeyItemMapping[itemID]
        npc:showText(npc, ID.text.LUROUILLAT_TURN_IN)
        npcUtil.giveKeyItem(player, keyItem)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(350)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
