-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Lurouillat
-- !pos 44 2 -35 80
-- Sealed Container NPC
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local itemID = trade:getItemId()
    local itemKeyItemMapping =
    {
        [xi.item.MAPLE_STRONGBOX] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_I,
        [xi.item.MAGNOLIA_STRONGBOX] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_II,
        [xi.item.BEECH_STRONGBOX] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_III,
        [xi.item.EVERGREEN_STRONGBOX] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_IV,
        [xi.item.HOLLY_STRONGBOX] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_V,
        [xi.item.OAK_STRONGBOX] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_VI,
        [xi.item.ELM_STRONGBOX] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_VII,
        [xi.item.WILLOW_STRONGBOX] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_VIII
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

return entity
