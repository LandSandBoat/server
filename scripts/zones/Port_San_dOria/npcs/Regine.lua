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
        if npcUtil.giveItem(player, { { xi.item.MAGICMART_FLYER, 1 }, { xi.item.MAGICMART_FLYER, 14 } })  then
            player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.FLYERS_FOR_REGINE)
        end
    elseif csid == 603 then
        npcUtil.completeQuest(
            player, xi.questLog.SANDORIA, xi.quest.id.sandoria.FLYERS_FOR_REGINE,
            {
                fame     = 20,
                fameArea = xi.fameArea.SANDORIA,
                gil      = 440,
                title    = xi.title.ADVERTISING_EXECUTIVE,
                var      = '[ffr]deliveryMask',
            }
        )

    -- WHITE MAGIC SHOP
    elseif csid == 510 and option == 0 then
        local stockA =
        {
            { xi.item.SCROLL_OF_CURE,        67, 3, },
            { xi.item.SCROLL_OF_CURE_II,    650, 2, },
            { xi.item.SCROLL_OF_CURAGA,    1515, 3, },
            { xi.item.SCROLL_OF_POISONA,    200, 3, },
            { xi.item.SCROLL_OF_PARALYNA,   360, 3, },
            { xi.item.SCROLL_OF_BLINDNA,   1100, 3, },
            { xi.item.SCROLL_OF_DIA,         92, 3, },
            { xi.item.SCROLL_OF_BANISH,     156, 2, },
            { xi.item.SCROLL_OF_DIAGA,     1295, 1, },
            { xi.item.SCROLL_OF_BANISHGA,  1295, 2, },
            { xi.item.SCROLL_OF_PROTECT,    244, 3, },
            { xi.item.SCROLL_OF_SHELL,     1760, 3, },
            { xi.item.SCROLL_OF_BLINK,     2330, 2, },
            { xi.item.SCROLL_OF_STONESKIN, 7806, 1, },
            { xi.item.SCROLL_OF_AQUAVEIL,   400, 3, },
            { xi.item.SCROLL_OF_SLOW,       930, 1, },
        }
        xi.shop.nation(player, stockA, xi.nation.SANDORIA)

    -- BLACK MAGIC SHOP
    elseif csid == 510 and option == 1 then
        local stockB =
        {
            { xi.item.SCROLL_OF_STONE,      67, 3, },
            { xi.item.SCROLL_OF_WATER,     156, 3, },
            { xi.item.SCROLL_OF_AERO,      360, 3, },
            { xi.item.SCROLL_OF_FIRE,      930, 3, },
            { xi.item.SCROLL_OF_BLIZZARD, 1760, 3, },
            { xi.item.SCROLL_OF_THUNDER,  3624, 3, },
            { xi.item.SCROLL_OF_POISON,     92, 2, },
            { xi.item.SCROLL_OF_BIO,       400, 2, },
            { xi.item.SCROLL_OF_BLIND,     124, 1, },
            { xi.item.SCROLL_OF_SLEEP,    2500, 2, },
            { xi.item.SCROLL_OF_BURN,     5160, 3, },
            { xi.item.SCROLL_OF_FROST,    4098, 3, },
            { xi.item.SCROLL_OF_CHOKE,    2500, 3, },
            { xi.item.SCROLL_OF_RASP,     2030, 3, },
            { xi.item.SCROLL_OF_SHOCK,    1515, 3, },
            { xi.item.SCROLL_OF_DROWN,    7074, 3, },
        }
        xi.shop.nation(player, stockB, xi.nation.SANDORIA)
    end
end

return entity
