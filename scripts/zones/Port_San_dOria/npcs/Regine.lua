-----------------------------------
-- Area: Port San d'Oria
--  NPC: Regine
-- !pos 68 -9 -74 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local flyersForRegine = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.FLYERS_FOR_REGINE)

    -- FLYERS FOR REGINE
    if
        flyersForRegine == xi.questStatus.QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, { { 'gil', 10 } })
    then
        if npcUtil.giveItem(player, xi.item.MAGICMART_FLYER) then
            player:confirmTrade()
        end
    end
end

entity.onTrigger = function(player, npc)
    local ffr = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.FLYERS_FOR_REGINE)

    -- FLYERS FOR REGINE
    if ffr == xi.questStatus.QUEST_AVAILABLE then -- ready to accept quest
        player:startEvent(510, 2)
    elseif
        ffr == xi.questStatus.QUEST_ACCEPTED and
        utils.mask.isFull(player:getCharVar('[ffr]deliveryMask'), 15)
    then
        -- all 15 flyers delivered
        player:startEvent(603)
    elseif
        ffr == xi.questStatus.QUEST_ACCEPTED and
        not player:hasItem(xi.item.MAGICMART_FLYER)
    then -- on quest but out of flyers
        player:startEvent(510, 3)

    -- DEFAULT MENU
    else
        player:startEvent(510)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- FLYERS FOR REGINE
    if csid == 510 and option == 2 then
        if npcUtil.giveItem(player, { { xi.item.MAGICMART_FLYER, 12 }, { xi.item.MAGICMART_FLYER, 3 } }) then
            player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.FLYERS_FOR_REGINE)
        end
    elseif csid == 603 then
        npcUtil.completeQuest(
            player, xi.questLog.SANDORIA, xi.quest.id.sandoria.FLYERS_FOR_REGINE,
            {
                gil = 440,
                title = xi.title.ADVERTISING_EXECUTIVE,
                var = '[ffr]deliveryMask',
            }
        )

    -- WHITE MAGIC SHOP
    elseif csid == 510 and option == 0 then
        local stockA =
        {
            xi.item.SCROLL_OF_CURE,        70, 3,
            xi.item.SCROLL_OF_CURE_II,    676, 2,
            xi.item.SCROLL_OF_CURAGA,    1575, 3,
            xi.item.SCROLL_OF_POISONA,    208, 3,
            xi.item.SCROLL_OF_PARALYNA,   374, 3,
            xi.item.SCROLL_OF_BLINDNA,   1144, 3,
            xi.item.SCROLL_OF_DIA,         95, 3,
            xi.item.SCROLL_OF_BANISH,     162, 2,
            xi.item.SCROLL_OF_DIAGA,     1346, 1,
            xi.item.SCROLL_OF_BANISHGA,  1346, 2,
            xi.item.SCROLL_OF_PROTECT,    253, 3,
            xi.item.SCROLL_OF_SHELL,     1830, 3,
            xi.item.SCROLL_OF_BLINK,     2423, 2,
            xi.item.SCROLL_OF_STONESKIN, 8118, 1,
            xi.item.SCROLL_OF_AQUAVEIL,   416, 3,
            xi.item.SCROLL_OF_SLOW,       967, 1,
        }
        xi.shop.nation(player, stockA, xi.nation.SANDORIA)

    -- BLACK MAGIC SHOP
    elseif csid == 510 and option == 1 then
        local stockB =
        {
            xi.item.SCROLL_OF_STONE,      70, 3,
            xi.item.SCROLL_OF_WATER,     162, 3,
            xi.item.SCROLL_OF_AERO,      374, 3,
            xi.item.SCROLL_OF_FIRE,      967, 3,
            xi.item.SCROLL_OF_BLIZZARD, 1830, 3,
            xi.item.SCROLL_OF_THUNDER,  3768, 3,
            xi.item.SCROLL_OF_POISON,     95, 2,
            xi.item.SCROLL_OF_BIO,       416, 2,
            xi.item.SCROLL_OF_BLIND,     128, 1,
            xi.item.SCROLL_OF_SLEEP,    2600, 2,
            xi.item.SCROLL_OF_BURN,     5366, 3,
            xi.item.SCROLL_OF_FROST,    4261, 3,
            xi.item.SCROLL_OF_CHOCKE,   2600, 3,
            xi.item.SCROLL_OF_RASP,     2111, 3,
            xi.item.SCROLL_OF_SHOCK,    1575, 3,
            xi.item.SCROLL_OF_DROWN,    7356, 3,
        }
        xi.shop.nation(player, stockB, xi.nation.SANDORIA)
    end
end

return entity
